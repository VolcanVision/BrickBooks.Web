import 'package:flutter_test/flutter_test.dart';
import 'package:visionvolcan_site_app/screens/inventory_screen.dart';

void main() {
  group('UnitConverter Tests', () {
    
    // Test convertToBaseUnit method
    group('convertToBaseUnit', () {
      
      test('should convert ton to kg correctly', () {
        // Arrange
        const quantity = 1.0;
        const unit = 'ton';
        
        // Act
        final result = UnitConverter.convertToBaseUnit(quantity, unit);
        
        // Assert
        expect(result, equals(1000.0));
      });
      
      test('should convert kg to kg correctly (base unit)', () {
        // Arrange
        const quantity = 3.0;
        const unit = 'kg';
        
        // Act
        final result = UnitConverter.convertToBaseUnit(quantity, unit);
        
        // Assert
        expect(result, equals(3.0));
      });
      
      test('should convert gram to kg correctly', () {
        // Arrange
        const quantity = 500.0;
        const unit = 'g';
        
        // Act
        final result = UnitConverter.convertToBaseUnit(quantity, unit);
        
        // Assert
        expect(result, equals(0.5));
      });
      
      test('should convert meter to meter correctly (base unit)', () {
        // Arrange
        const quantity = 5.0;
        const unit = 'm';
        
        // Act
        final result = UnitConverter.convertToBaseUnit(quantity, unit);
        
        // Assert
        expect(result, equals(5.0));
      });
      
      test('should convert feet to meter correctly', () {
        // Arrange
        const quantity = 10.0;
        const unit = 'ft';
        
        // Act
        final result = UnitConverter.convertToBaseUnit(quantity, unit);
        
        // Assert
        expect(result, equals(3.048));
      });
      
      test('should handle unknown units by returning original quantity', () {
        // Arrange
        const quantity = 7.0;
        const unit = 'unknown_unit';
        
        // Act
        final result = UnitConverter.convertToBaseUnit(quantity, unit);
        
        // Assert
        expect(result, equals(7.0));
      });
      
      test('should handle case insensitive units', () {
        // Arrange
        const quantity = 2.0;
        const unit = 'KG';
        
        // Act
        final result = UnitConverter.convertToBaseUnit(quantity, unit);
        
        // Assert
        expect(result, equals(2.0));
      });
      
      test('should handle units with extra spaces', () {
        // Arrange
        const quantity = 1.5;
        const unit = '  kg  ';
        
        // Act
        final result = UnitConverter.convertToBaseUnit(quantity, unit);
        
        // Assert
        expect(result, equals(1.5));
      });
    });
    
    // Test getBaseUnit method
    group('getBaseUnit', () {
      
      test('should return kg for weight units', () {
        // Test various weight units
        expect(UnitConverter.getBaseUnit('ton'), equals('kg'));
        expect(UnitConverter.getBaseUnit('kg'), equals('kg'));
        expect(UnitConverter.getBaseUnit('gram'), equals('kg'));
        expect(UnitConverter.getBaseUnit('quintal'), equals('kg'));
      });
      
      test('should return m for length units', () {
        // Test various length units
        expect(UnitConverter.getBaseUnit('meter'), equals('m'));
        expect(UnitConverter.getBaseUnit('cm'), equals('m'));
        expect(UnitConverter.getBaseUnit('feet'), equals('m'));
        expect(UnitConverter.getBaseUnit('inch'), equals('m'));
      });
      
      test('should return l for volume units', () {
        // Test various volume units
        expect(UnitConverter.getBaseUnit('liter'), equals('l'));
        expect(UnitConverter.getBaseUnit('ml'), equals('l'));
        expect(UnitConverter.getBaseUnit('gallon'), equals('l'));
      });
      
      test('should return pcs for count units', () {
        // Test various count units
        expect(UnitConverter.getBaseUnit('bags'), equals('pcs'));
        expect(UnitConverter.getBaseUnit('bricks'), equals('pcs'));
        expect(UnitConverter.getBaseUnit('pieces'), equals('pcs'));
      });
      
      test('should return pcs for unknown units', () {
        // Test unknown unit defaults to pieces
        expect(UnitConverter.getBaseUnit('unknown'), equals('pcs'));
      });
    });
    
    // Test areCompatibleUnits method
    group('areCompatibleUnits', () {
      
      test('should return true for compatible weight units', () {
        // Arrange & Act & Assert
        expect(UnitConverter.areCompatibleUnits('ton', 'kg'), isTrue);
        expect(UnitConverter.areCompatibleUnits('gram', 'quintal'), isTrue);
      });
      
      test('should return true for compatible length units', () {
        // Arrange & Act & Assert
        expect(UnitConverter.areCompatibleUnits('meter', 'feet'), isTrue);
        expect(UnitConverter.areCompatibleUnits('cm', 'inch'), isTrue);
      });
      
      test('should return false for incompatible units', () {
        // Arrange & Act & Assert
        expect(UnitConverter.areCompatibleUnits('ton', 'meter'), isFalse);
        expect(UnitConverter.areCompatibleUnits('kg', 'liter'), isFalse);
      });
      
      test('should return true for same units', () {
        // Arrange & Act & Assert
        expect(UnitConverter.areCompatibleUnits('kg', 'kg'), isTrue);
        expect(UnitConverter.areCompatibleUnits('meter', 'meter'), isTrue);
      });
    });
  });
}
