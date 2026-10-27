import unittest
from decimal import Decimal

MAX_LIMIT = Decimal('1000000.00')

def validate_limit(value: Decimal) -> bool:
    return Decimal('0.00') <= value <= MAX_LIMIT

def reconciles(read, valid, rejected):
    return read == valid + rejected

class BusinessRulesTest(unittest.TestCase):
    def test_limit_bounds(self):
        self.assertTrue(validate_limit(Decimal('25000.00')))
        self.assertTrue(validate_limit(Decimal('0.00')))
        self.assertFalse(validate_limit(Decimal('-1.00')))
        self.assertFalse(validate_limit(Decimal('1000000.01')))

    def test_balanced_line(self):
        self.assertTrue(reconciles(100000, 99990, 10))
        self.assertFalse(reconciles(100000, 99990, 9))

if __name__ == '__main__':
    unittest.main()
