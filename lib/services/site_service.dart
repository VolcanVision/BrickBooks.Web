import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:visionvolcan_site_app/main.dart';

/// Manages all operations related to construction sites in the application
class SiteService {
  // Private constructor for singleton pattern
  SiteService._();
  
  // Single instance of SiteService
  static final SiteService instance = SiteService._();

  /// Retrieves a list of all construction sites from the database
  Future<List<Map<String, dynamic>>> getSites({bool forceRefresh = false}) async {
    try {
      final response = await supabase.from('sites').select();
      return List<Map<String, dynamic>>.from(response as List);
    } catch (e) {
      throw Exception('Failed to fetch sites: $e');
    }
  }

  /// Updates a specific field of a site
  /// 
  /// [siteToUpdate] The site map containing at least the 'id' field
  /// [fieldKey] The name of the field to update
  /// [newValue] The new value to set for the field
  Future<void> updateSiteField(
    Map<String, dynamic> siteToUpdate, 
    String fieldKey, 
    dynamic newValue
  ) async {
    try {
      if (siteToUpdate['id'] != null) {
        await supabase
            .from('sites')
            .update({fieldKey: newValue})
            .eq('id', siteToUpdate['id']);
      }
    } catch (e) {
      throw Exception('Failed to update site: $e');
    }
  }

  /// Creates a new construction site in the database
  /// 
  /// [newSite] A map containing the site details (name, location, etc.)
  Future<void> addSite(Map<String, dynamic> newSite) async {
    try {
      await supabase.from('sites').insert(newSite);
    } catch (e) {
      throw Exception('Failed to add site: $e');
    }
  }

  /// Permanently removes a site from the database
  /// 
  /// [siteToDelete] The site map containing at least the 'id' field
  Future<void> deleteSite(Map<String, dynamic> siteToDelete) async {
    try {
      if (siteToDelete['id'] != null) {
        await supabase
            .from('sites')
            .delete()
            .eq('id', siteToDelete['id']);
      }
    } catch (e) {
      throw Exception('Failed to delete site: $e');
    }
  }

  /// Marks a site as completed in the system
  /// 
  /// [siteToUpdate] The site map containing at least the 'id' field
  Future<void> markSiteAsCompleted(Map<String, dynamic> siteToUpdate) async {
    await updateSiteField(siteToUpdate, 'status', 'completed');
  }
}