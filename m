Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f73LklH29898
	for linux-mips-outgoing; Fri, 3 Aug 2001 14:46:47 -0700
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f73LkhV29891
	for <linux-mips@oss.sgi.com>; Fri, 3 Aug 2001 14:46:43 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id OAA08494;
	Fri, 3 Aug 2001 14:41:43 -0700
Date: Fri, 3 Aug 2001 14:41:43 -0700
From: Jun Sun <jsun@mvista.com>
To: "John D. Davis" <johnd@stanford.edu>
Cc: linux-mips@oss.sgi.com
Subject: Re: printk
Message-ID: <20010803144143.B3894@mvista.com>
References: <Pine.GSO.4.31.0108031412450.675-100000@myth1.Stanford.EDU>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.31.0108031412450.675-100000@myth1.Stanford.EDU>; from johnd@stanford.edu on Fri, Aug 03, 2001 at 02:15:54PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 03, 2001 at 02:15:54PM -0700, John D. Davis wrote:
> Does anyone know off hand, the earlies point that I can use printk?  I
> added some printk statements to driver/char/console.c and the resulting
> kernel hangs with only the logo showing and no text.  Is prom_printf
> something that I should use instead. I put some printk statements in
> tty_io.c and kernel/printk.c and those compiled kernels work.
> 
> thanks,
> john davis
>

Like other folks from this list have pointed out, you can use
it as early as the first C line.  The output is stored in a memory
buffer and later displayed on your screen when your serial console
is registered.

When porting to a new machine, I often use dev-only patch (i.e.,
not meant to be checked in) to enable seeing printk immediately, *if*
it is a standard UART port.  See the attache patch below.

I don't recommand use or implement prom_printf.

Jun

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="early-printk.patch"

diff -Nru linux/kernel/printk.c.orig linux/kernel/printk.c
--- linux/kernel/printk.c.orig	Fri Mar  9 12:34:58 2001
+++ linux/kernel/printk.c	Thu Mar 15 14:24:19 2001
@@ -251,6 +251,7 @@
 	return do_syslog(type, buf, len);
 }
 
+extern void debug_out(char * msg, int len);
 asmlinkage int printk(const char *fmt, ...)
 {
 	va_list args;
@@ -296,6 +297,11 @@
 				break;
 			}
 		}
+
+		/* jsun */
+                debug_out(msg,  p - msg + line_feed); 
+
+		/*
 		if (msg_level < console_loglevel && console_drivers) {
 			struct console *c = console_drivers;
 			while(c) {
@@ -304,6 +310,7 @@
 				c = c->next;
 			}
 		}
+		*/
 		if (line_feed)
 			msg_level = -1;
 	}
@@ -494,4 +501,132 @@
 	if (tty && tty->driver.write)
 		tty->driver.write(tty, 0, msg, strlen(msg));
 	return;
+}
+
+
+/* --- CONFIG --- */
+
+/* we need uint32 uint8 */
+/* #include "types.h" */
+typedef         unsigned char uint8;
+typedef         unsigned int  uint32;
+
+/* --- END OF CONFIG --- */
+
+#define         UART16550_BAUD_2400             2400
+#define         UART16550_BAUD_4800             4800
+#define         UART16550_BAUD_9600             9600
+#define         UART16550_BAUD_19200            19200
+#define         UART16550_BAUD_38400            38400
+#define         UART16550_BAUD_57600            57600
+#define         UART16550_BAUD_115200           115200
+
+#define         UART16550_PARITY_NONE           0
+#define         UART16550_PARITY_ODD            0x08
+#define         UART16550_PARITY_EVEN           0x18
+#define         UART16550_PARITY_MARK           0x28
+#define         UART16550_PARITY_SPACE          0x38
+
+#define         UART16550_DATA_5BIT             0x0
+#define         UART16550_DATA_6BIT             0x1
+#define         UART16550_DATA_7BIT             0x2
+#define         UART16550_DATA_8BIT             0x3
+
+#define         UART16550_STOP_1BIT             0x0
+#define         UART16550_STOP_2BIT             0x4
+
+void Uart16550Init(uint32 baud, uint8 data, uint8 parity, uint8 stop);
+
+/* blocking call */
+uint8 Uart16550GetPoll(void);
+
+void Uart16550Put(uint8 byte);
+
+/* ----------------------------------------------------- */
+
+/* === CONFIG === */
+
+#define         BASE                    0xbfa04200
+#define         MAX_BAUD                115200
+#define		REG_OFFSET		8
+
+/* === END OF CONFIG === */
+
+/* register offset */
+#define         OFS_RCV_BUFFER          (0*REG_OFFSET)
+#define         OFS_TRANS_HOLD          (0*REG_OFFSET)
+#define         OFS_SEND_BUFFER         (0*REG_OFFSET)
+#define         OFS_INTR_ENABLE         (1*REG_OFFSET)
+#define         OFS_INTR_ID             (2*REG_OFFSET)
+#define         OFS_DATA_FORMAT         (3*REG_OFFSET)
+#define         OFS_LINE_CONTROL        (3*REG_OFFSET)
+#define         OFS_MODEM_CONTROL       (4*REG_OFFSET)
+#define         OFS_RS232_OUTPUT        (4*REG_OFFSET)
+#define         OFS_LINE_STATUS         (5*REG_OFFSET)
+#define         OFS_MODEM_STATUS        (6*REG_OFFSET)
+#define         OFS_RS232_INPUT         (6*REG_OFFSET)
+#define         OFS_SCRATCH_PAD         (7*REG_OFFSET)
+
+#define         OFS_DIVISOR_LSB         (0*REG_OFFSET)
+#define         OFS_DIVISOR_MSB         (1*REG_OFFSET)
+
+
+/* memory-mapped read/write of the port */
+#define         UART16550_READ(y)    (*((volatile uint8*)(BASE + y)))
+#define         UART16550_WRITE(y, z)  ((*((volatile uint8*)(BASE + y))) = z)
+
+#define DEBUG_LED (*(unsigned short*)0xb7ffffc0)
+#define OutputLED(x)  (DEBUG_LED = x)
+
+void Uart16550Init(uint32 baud, uint8 data, uint8 parity, uint8 stop)
+{
+    /* disable interrupts */
+    UART16550_WRITE(OFS_INTR_ENABLE, 0);
+
+    /* set up buad rate */
+    { 
+        uint32 divisor;
+       
+        /* set DIAB bit */
+        UART16550_WRITE(OFS_LINE_CONTROL, 0x80);
+        
+        /* set divisor */
+        divisor = MAX_BAUD / baud;
+        UART16550_WRITE(OFS_DIVISOR_LSB, divisor & 0xff);
+        UART16550_WRITE(OFS_DIVISOR_MSB, (divisor & 0xff00)>>8);
+
+        /* clear DIAB bit */
+        UART16550_WRITE(OFS_LINE_CONTROL, 0x0);
+    }
+
+    /* set data format */
+    UART16550_WRITE(OFS_DATA_FORMAT, data | parity | stop);
+}
+
+uint8 Uart16550GetPoll(void)
+{
+    while((UART16550_READ(OFS_LINE_STATUS) & 0x1) == 0);
+    return UART16550_READ(OFS_RCV_BUFFER);
+}
+
+
+void Uart16550Put(uint8 byte)
+{
+    while ((UART16550_READ(OFS_LINE_STATUS) &0x20) == 0);
+    UART16550_WRITE(OFS_SEND_BUFFER, byte);
+}
+
+/* ---------------------------------------------------------- */
+
+void debug_out(char * msg, int len)
+{
+	int i;
+ 	for (i=0; i< len; i++) {
+		if (msg[i] == '\n') {
+			Uart16550Put('\r');
+			Uart16550Put('\n');
+		} else {
+			Uart16550Put(msg[i]);
+		}
+	}
 }

--G4iJoqBmSsgzjUCe--
