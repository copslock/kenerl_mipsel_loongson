From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Mon, 25 Oct 2010 12:28:27 +0200
Subject: [PATCH v3] MIPS: Alchemy: fix build with SERIAL_8250=n
Message-ID: <20101025102827.EhKg8-qan01pJXf27rI4MyEulHjuRJwdSGFC2GXNF-I@z>

In commit 7d172bfe ("Alchemy: Add UART PM methods") I introduced
platform PM methods which call a function of the 8250 driver;
this patch works around link failures when the kernel is built
without 8250 support.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
v3: account for modular 8250 code.
v2: added commit name to patch description as per Sergei's suggestion.

 arch/mips/alchemy/common/platform.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c
b/arch/mips/alchemy/common/platform.c
index 3691630..1f98032 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -27,6 +27,9 @@
 static void alchemy_8250_pm(struct uart_port *port, unsigned int state,
 			    unsigned int old_state)
 {
+	void(*pm_func)(struct uart_port *, unsigned int, unsigned int);
+	pm_func = symbol_get(serial8250_do_pm);
+
 	switch (state) {
 	case 0:
 		if ((__raw_readl(port->membase + UART_MOD_CNTRL) & 3) != 3) {
@@ -38,17 +41,23 @@ static void alchemy_8250_pm(struct uart_port
*port, unsigned int state,
 		}
 		__raw_writel(3, port->membase + UART_MOD_CNTRL); /* full on */
 		wmb();
-		serial8250_do_pm(port, state, old_state);
+		if (pm_func)
+			pm_func(port, state, old_state);
 		break;
 	case 3:		/* power off */
-		serial8250_do_pm(port, state, old_state);
+		if (pm_func)
+			pm_func(port, state, old_state);
 		__raw_writel(0, port->membase + UART_MOD_CNTRL);
 		wmb();
 		break;
 	default:
-		serial8250_do_pm(port, state, old_state);
+		if (pm_func)
+			pm_func(port, state, old_state);
 		break;
 	}
+
+	if (pm_func)
+		symbol_put(pm_func);
 }

 #define PORT(_base, _irq)					\
-- 
1.7.3.2


Thanks,
      Manuel Lauss
