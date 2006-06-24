Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2006 03:02:27 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:48551 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8133862AbWFXCCP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Jun 2006 03:02:15 +0100
Received: (qmail 18180 invoked by uid 101); 24 Jun 2006 02:02:09 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by father.pmc-sierra.com with SMTP; 24 Jun 2006 02:02:09 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k5O228ie019579;
	Fri, 23 Jun 2006 19:02:08 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JPF7KJN1>; Fri, 23 Jun 2006 19:02:07 -0700
Message-ID: <C28979E4F697C249ABDA83AC0C33CDF8143EF8@sjc1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Kiran Thota <Kiran_Thota@pmc-sierra.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Raj Palani <Rajesh_Palani@pmc-sierra.com>
Subject: [PATCH 4/6] Sequoia Serial driver
Date:	Fri, 23 Jun 2006 19:02:00 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Kiran_Thota@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Kiran_Thota@pmc-sierra.com
Precedence: bulk
X-list: linux-mips


- Add specific code for PMC Internal uart
- Add IRQ defns for PMC Internal uart
- Add definitions for PMC Internal uart reg defns (AFAIK, Basler sent similar patch)

Signed-off-by: Kiran Kumar Thota <kiran_thota@pmc-sierra.com>


diff -Naur a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c	2005-07-11 11:28:10.000000000 -0700
+++ b/drivers/serial/8250.c	2006-06-22 11:48:21.000000000 -0700
@@ -275,7 +275,11 @@
 		return inb(up->port.iobase + 1);
 
 	case UPIO_MEM:
+#if defined(CONFIG_PMC_INTERNAL_UART)
+		return (__raw_readl(up->port.membase + offset) & 0xff);
+#else
 		return readb(up->port.membase + offset);
+#endif
 
 	case UPIO_MEM32:
 		return readl(up->port.membase + offset);
@@ -297,7 +301,11 @@
 		break;
 
 	case UPIO_MEM:
+#if defined(CONFIG_PMC_INTERNAL_UART)
+		__raw_writel(value, up->port.membase + offset);
+#else
 		writeb(value, up->port.membase + offset);
+#endif
 		break;
 
 	case UPIO_MEM32:
@@ -1036,6 +1044,12 @@
 		up->acr &= ~UART_ACR_TXDIS;
 		serial_icr_write(up, UART_ACR, up->acr);
 	}
+
+#if defined(CONFIG_PMC_INTERNAL_UART)
+	/* kick it! */
+	serial_out(up, UART_TX, 0);
+#endif
+
 }
 
 static void serial8250_stop_rx(struct uart_port *port)
@@ -2158,6 +2172,10 @@
 	int parity = 'n';
 	int flow = 'n';
 
+#ifdef CONFIG_PMC_SEQUOIA
+	baud=115200;
+#endif
+
 	/*
 	 * Check whether an invalid uart number has been specified, and
 	 * if so, search for the first available port that does have
diff -Naur a/include/asm-mips/serial.h b/include/asm-mips/serial.h
--- a/include/asm-mips/serial.h	2005-07-11 11:28:10.000000000 -0700
+++ b/include/asm-mips/serial.h	2006-06-22 11:48:21.000000000 -0700
@@ -298,6 +298,11 @@
 #define MOMENCO_JAGUAR_ATX_SERIAL_PORT_DEFNS
 #endif
 
+#ifdef CONFIG_PMC_SEQUOIA
+#define SEQUOIA_SERIAL_IRQ      0
+#define SEQUOIA_SERIAL_IRQ_1    0
+#endif
+
 #ifdef CONFIG_MOMENCO_OCELOT_3
 #define OCELOT_3_BASE_BAUD	( 20000000 / 16 )
 #define OCELOT_3_SERIAL_IRQ	6
diff -Naur a/include/linux/serial_reg.h b/include/linux/serial_reg.h
--- a/include/linux/serial_reg.h	2005-07-11 11:28:10.000000000 -0700
+++ b/include/linux/serial_reg.h	2006-06-22 11:48:21.000000000 -0700
@@ -17,10 +17,17 @@
 /*
  * DLAB=0
  */
+#if defined(CONFIG_PMC_INTERNAL_UART) && defined(CONFIG_PMC_SEQUOIA)
+#define UART_RX         0x508    /* In:  Receive buffer (DLAB=0) */
+#define UART_TX         0x50C    /* Out: Transmit buffer (DLAB=0) */
+
+#define UART_IER        0x514    /* Out: Interrupt Enable Register */
+#else
 #define UART_RX		0	/* In:  Receive buffer */
 #define UART_TX		0	/* Out: Transmit buffer */
 
 #define UART_IER	1	/* Out: Interrupt Enable Register */
+#endif /* CONFIG_PMC_INTERNAL_UART && CONFIG_PMC_SEQUOIA */
 #define UART_IER_MSI		0x08 /* Enable Modem status interrupt */
 #define UART_IER_RLSI		0x04 /* Enable receiver line status interrupt */
 #define UART_IER_THRI		0x02 /* Enable Transmitter holding register int. */
@@ -30,7 +37,11 @@
  */
 #define UART_IERX_SLEEP		0x10 /* Enable sleep mode */
 
+#if defined(CONFIG_PMC_INTERNAL_UART) && defined(CONFIG_PMC_SEQUOIA)
+#define UART_IIR        0x51C    /* In:  Interrupt ID Register */
+#else
 #define UART_IIR	2	/* In:  Interrupt ID Register */
+#endif /* CONFIG_PMC_INTERNAL_UART && CONFIG_PMC_SEQUOIA */
 #define UART_IIR_NO_INT		0x01 /* No interrupts pending */
 #define UART_IIR_ID		0x06 /* Mask for the interrupt ID */
 #define UART_IIR_MSI		0x00 /* Modem status interrupt */
@@ -38,7 +49,11 @@
 #define UART_IIR_RDI		0x04 /* Receiver data interrupt */
 #define UART_IIR_RLSI		0x06 /* Receiver line status interrupt */
 
+#if defined(CONFIG_PMC_INTERNAL_UART) && defined(CONFIG_PMC_SEQUOIA)
+#define UART_FCR        0x520    /* Out: FIFO Control Register */
+#else
 #define UART_FCR	2	/* Out: FIFO Control Register */
+#endif /* CONFIG_PMC_INTERNAL_UART && CONFIG_PMC_SEQUOIA */
 #define UART_FCR_ENABLE_FIFO	0x01 /* Enable the FIFO */
 #define UART_FCR_CLEAR_RCVR	0x02 /* Clear the RCVR FIFO */
 #define UART_FCR_CLEAR_XMIT	0x04 /* Clear the XMIT FIFO */
@@ -81,7 +96,11 @@
 #define UART_FCR6_T_TRIGGER_30	0x30 /* Mask for transmit trigger set at 30 */
 #define UART_FCR7_64BYTE	0x20 /* Go into 64 byte mode (TI16C750) */
 
+#if defined(CONFIG_PMC_INTERNAL_UART) && defined(CONFIG_PMC_SEQUOIA)
+#define UART_LCR        0x524    /* Out: Line Control Register */
+#else
 #define UART_LCR	3	/* Out: Line Control Register */
+#endif /* CONFIG_PMC_INTERNAL_UART && CONFIG_PMC_SEQUOIA */
 /*
  * Note: if the word length is 5 bits (UART_LCR_WLEN5), then setting 
  * UART_LCR_STOP will select 1.5 stop bits, not 2 stop bits.
@@ -97,7 +116,11 @@
 #define UART_LCR_WLEN7		0x02 /* Wordlength: 7 bits */
 #define UART_LCR_WLEN8		0x03 /* Wordlength: 8 bits */
 
+#if defined(CONFIG_PMC_INTERNAL_UART) && defined(CONFIG_PMC_SEQUOIA)
+#define UART_MCR        0x528    /* Out: Modem Control Register */
+#else
 #define UART_MCR	4	/* Out: Modem Control Register */
+#endif /* CONFIG_PMC_INTERNAL_UART && CONFIG_PMC_SEQUOIA */
 #define UART_MCR_CLKSEL		0x80 /* Divide clock by 4 (TI16C752, EFR[4]=1) */
 #define UART_MCR_TCRTLR		0x40 /* Access TCR/TLR (TI16C752, EFR[4]=1) */
 #define UART_MCR_XONANY		0x20 /* Enable Xon Any (TI16C752, EFR[4]=1) */
@@ -108,7 +131,11 @@
 #define UART_MCR_RTS		0x02 /* RTS complement */
 #define UART_MCR_DTR		0x01 /* DTR complement */
 
+#if defined(CONFIG_PMC_INTERNAL_UART) && defined(CONFIG_PMC_SEQUOIA)
+#define UART_LSR        0x52C    /* In:  Line Status Register */
+#else
 #define UART_LSR	5	/* In:  Line Status Register */
+#endif /* CONFIG_PMC_INTERNAL_UART && CONFIG_PMC_SEQUOIA */
 #define UART_LSR_TEMT		0x40 /* Transmitter empty */
 #define UART_LSR_THRE		0x20 /* Transmit-hold-register empty */
 #define UART_LSR_BI		0x10 /* Break interrupt indicator */
@@ -117,7 +144,11 @@
 #define UART_LSR_OE		0x02 /* Overrun error indicator */
 #define UART_LSR_DR		0x01 /* Receiver data ready */
 
+#if defined(CONFIG_PMC_INTERNAL_UART) && defined(CONFIG_PMC_SEQUOIA)
+#define UART_MSR        0x530    /* In:  Modem Status Register */
+#else
 #define UART_MSR	6	/* In:  Modem Status Register */
+#endif /* CONFIG_PMC_INTERNAL_UART && CONFIG_PMC_SEQUOIA */
 #define UART_MSR_DCD		0x80 /* Data Carrier Detect */
 #define UART_MSR_RI		0x40 /* Ring Indicator */
 #define UART_MSR_DSR		0x20 /* Data Set Ready */
@@ -128,18 +159,34 @@
 #define UART_MSR_DCTS		0x01 /* Delta CTS */
 #define UART_MSR_ANY_DELTA	0x0F /* Any of the delta bits! */
 
+#if defined(CONFIG_PMC_INTERNAL_UART) && defined(CONFIG_PMC_SEQUOIA)
+#define UART_SCR        0x534    /* I/O: Scratch Register */
+#else
 #define UART_SCR	7	/* I/O: Scratch Register */
+#endif /* CONFIG_PMC_INTERNAL_UART && CONFIG_PMC_SEQUOIA */
 
 /*
  * DLAB=1
  */
+#if defined(CONFIG_PMC_INTERNAL_UART) && defined(CONFIG_PMC_SEQUOIA)
+#define UART_DLL        0x510    /* Out: Divisor Latch Low */
+#define UART_DLM        0x518    /* Out: Divisor Latch High */
+#else
 #define UART_DLL	0	/* Out: Divisor Latch Low */
 #define UART_DLM	1	/* Out: Divisor Latch High */
+#endif /* CONFIG_PMC_INTERNAL_UART && CONFIG_PMC_SEQUOIA */
+
 
 /*
  * LCR=0xBF (or DLAB=1 for 16C660)
  */
+#if defined(CONFIG_PMC_INTERNAL_UART) && defined(CONFIG_PMC_SEQUOIA)
+#define UART_EFR        0x520    /* N/A
+                                  * (DLAB=1, 16C660 only) */
+
+#else
 #define UART_EFR	2	/* I/O: Extended Features Register */
+#endif /* CONFIG_PMC_INTERNAL_UART && CONFIG_PMC_SEQUOIA */
 #define UART_EFR_CTS		0x80 /* CTS flow control */
 #define UART_EFR_RTS		0x40 /* RTS flow control */
 #define UART_EFR_SCD		0x20 /* Special character detect */
@@ -165,9 +212,15 @@
 /*
  * LCR=0xBF, XR16C85x
  */
+#if defined(CONFIG_PMC_INTERNAL_UART) && defined(CONFIG_PMC_SEQUOIA)
+#define UART_TRG        0x510    /* N/A, make comiler happy
+                                  * XR16C85x only */
+
+#else
 #define UART_TRG	0	/* FCTR bit 7 selects Rx or Tx
 				 * In: Fifo count
 				 * Out: Fifo custom trigger levels */
+#endif /* CONFIG_PMC_INTERNAL_UART && CONFIG_PMC_SEQUOIA */
 /*
  * These are the definitions for the Programmable Trigger Register
  */
@@ -181,7 +234,12 @@
 #define UART_TRG_120		0x78
 #define UART_TRG_128		0x80
 
+#if defined(CONFIG_PMC_INTERNAL_UART) && defined(CONFIG_PMC_SEQUOIA)
+#define UART_FCTR       0x518    /* N/A
+                                  * XR16C85x only */
+#else
 #define UART_FCTR	1	/* Feature Control Register */
+#endif /* CONFIG_PMC_INTERNAL_UART && CONFIG_PMC_SEQUOIA */
 #define UART_FCTR_RTS_NODELAY	0x00  /* RTS flow control delay */
 #define UART_FCTR_RTS_4DELAY	0x01
 #define UART_FCTR_RTS_6DELAY	0x02
@@ -199,7 +257,12 @@
 /*
  * LCR=0xBF, FCTR[6]=1
  */
+#if defined(CONFIG_PMC_INTERNAL_UART) && defined(CONFIG_PMC_SEQUOIA)
+#define UART_EMSR       0x534    /* N/A
+                                  * XR16c85x only */
+#else
 #define UART_EMSR	7	/* Extended Mode Select Register */
+#endif /* CONFIG_PMC_INTERNAL_UART && CONFIG_PMC_SEQUOIA */
 #define UART_EMSR_FIFO_COUNT	0x01  /* Rx/Tx select */
 #define UART_EMSR_ALT_COUNT	0x02  /* Alternating count select */
