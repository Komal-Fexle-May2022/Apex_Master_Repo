// This class contain the customer discount description.
// And Interface with PurchaseOrder.
public  class CustomerPurchaseOrderController implements PurchaseOrder {
    public Double discount() {
        System.debug('This provide discount to customer::');
        return .05;
    }
}