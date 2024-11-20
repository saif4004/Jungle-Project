describe('Product Page', () => {
  it('should navigate to the product detail page when a product is clicked', ()=>{
    cy.visit('/');
    cy.get(".products article").should("be.visible");
    cy.get(".products article").should("have.length", 2);
    cy.get('.products article').first().click();
    cy.url().should('include', '/products/');
  });
});