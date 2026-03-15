import 'package:supabase_flutter/supabase_flutter.dart';

class ExpenseService {
  ExpenseService._();
  static final ExpenseService instance = ExpenseService._();

  // --- *** NEW MATERIAL PURCHASE FUNCTIONS *** ---
  // These talk to your new 'raw_material_purchases' table

  // NEW: Gets all purchases for a specific site
  Future<List<Map<String, dynamic>>> getMaterialPurchasesForSite(int siteId, {bool forceRefresh = false}) async {
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .from('raw_material_purchases')
          .select()
          .eq('site_id', siteId);
      return List<Map<String, dynamic>>.from(response as List);
    } catch (e) {
      throw Exception('Failed to fetch material purchases: $e');
    }
  }

  // 2. Realtime Stream (Isse ADD karo)
  Stream<List<Map<String, dynamic>>> materialPurchasesStream(int siteId) {
    final supabase = Supabase.instance.client;
    return supabase
        .from('raw_material_purchases')
        .stream(primaryKey: ['id']) // 'id' column primary key hona zaroori hai
        .eq('site_id', siteId);
  }

  // NEW: Adds a new purchase record
  Future<void> addMaterialPurchase(Map<String, dynamic> item) async {
    try {
      final supabase = Supabase.instance.client;
      await supabase.from('raw_material_purchases').insert(item);
    } catch (e) {
      throw Exception('Failed to add material purchase: $e');
    }
  }

  // NEW: Deletes a purchase record
  Future<void> updateMaterialPurchase(String id, Map<String, dynamic> updatedData) async {
    try {
      final supabase = Supabase.instance.client;
      await supabase
          .from('raw_material_purchases') // Make sure this matches your Supabase table name
          .update(updatedData)
          .eq('id', id);
    } catch (e) {
      throw Exception('Failed to update purchase: $e');
    }
  }

  // --- DELETE METHOD ---
  Future<void> deleteMaterialPurchase(String id) async {
    try {
      final supabase = Supabase.instance.client;
      await supabase
          .from('raw_material_purchases')
          .delete()
          .eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete purchase: $e');
    }
  }


  // --- *** CONTRACTOR FUNCTIONS *** ---
  // This logic is correct and remains unchanged.

  Future<List<Map<String, dynamic>>> getContractorsForSite(int siteId, {bool forceRefresh = false}) async {
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .from('contractors')
          .select()
          .eq('site_id', siteId);
      return List<Map<String, dynamic>>.from(response as List);
    } catch (e) {
      throw Exception('Failed to fetch contractors: $e');
    }
  }

  Future<void> addContractor(Map<String, dynamic> contractor) async {
    try {
      final supabase = Supabase.instance.client;
      await supabase.from('contractors').insert(contractor);
    } catch (e) {
      throw Exception('Failed to add contractor: $e');
    }
  }

  Future<void> updateContractor(String id, Map<String, dynamic> updatedContractor) async {
    final supabase = Supabase.instance.client;
    await supabase
        .from('contractors')
        .update(updatedContractor)
        .eq('id', id);
  }

  Future<void> deleteContractor(String id) async {
    final supabase = Supabase.instance.client;
    await supabase
        .from('contractors')
        .delete()
        .eq('id', id);
  }

}