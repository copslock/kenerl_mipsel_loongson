From: Andrew Sharp <tigerand@gmail.com>
Date: Tue, 13 Feb 2007 10:34:40 -0800
Subject: [PATCH] Clean up serial console support on Sibyte 1250 duart serial ports,
Message-ID: <20070213183440.Y5omeViDHBhy5fQw7WLPfB9RnSFw_kKG8EvgQ31gQ5M@z>

including adding proper support for command line parsing.

Use cleaner 1956 WAR method, getting rid of all but one ifdef
and an extra static array.

Fix bug where a 64-bit write was being done to a 32-bit register
during port initialization.

Clean up considerable whitespace and style issues.

Signed-off-by: Andrew Sharp <tigerand@gmail.com>
---
 drivers/char/sb1250_duart.c |  191 ++++++++++++++++++++++++++----------------
 1 files changed, 118 insertions(+), 73 deletions(-)

diff --git a/drivers/char/sb1250_duart.c b/drivers/char/sb1250_duart.c
index 4ef345c..dcbbcb9 100644
--- a/drivers/char/sb1250_duart.c
+++ b/drivers/char/sb1250_duart.c
@@ -10,13 +10,13 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
 
-/* 
+/*
  * Driver support for the on-chip sb1250 dual-channel serial port,
  * running in asynchronous mode.  Also, support for doing a serial console
  * on one of those ports
@@ -81,18 +81,32 @@ char sb1250_duart_present[DUART_MAX_LINE];
 EXPORT_SYMBOL(sb1250_duart_present);
 
 /*
- * Still not sure what the termios structures set up here are for, 
+ * In bug 1956, we get glitches that can mess up uart registers.  This
+ * "read-mode-reg after any register access" is an accepted workaround.
+ */
+#if SIBYTE_1956_WAR
+# define SB1_SER1956_WAR {							\
+	u32 ignore;										\
+	ignore = csr_in32(uart_states[line].mode_1);	\
+	ignore = csr_in32(uart_states[line].mode_2);	\
+	}
+#else
+# define SB1_SER1956_WAR
+#endif
+
+/*
+ * Still not sure what the termios structures set up here are for,
  *  but we have to supply pointers to them to register the tty driver
  */
 static struct tty_driver *sb1250_duart_driver; //, sb1250_duart_callout_driver;
 
 /*
- * This lock protects both the open flags for all the uart states as 
+ * This lock protects both the open flags for all the uart states as
  * well as the reference count for the module
  */
 static DEFINE_SPINLOCK(open_lock);
 
-typedef struct { 
+typedef struct {
 	unsigned char       outp_buf[SERIAL_XMIT_SIZE];
 	unsigned int        outp_head;
 	unsigned int        outp_tail;
@@ -117,33 +131,20 @@ typedef struct {
 static uart_state_t uart_states[DUART_MAX_LINE];
 
 /*
- * Inline functions local to this module 
+ * Inline functions local to this module
  */
 
-/*
- * In bug 1956, we get glitches that can mess up uart registers.  This
- * "write-mode-1 after any register access" is the accepted
- * workaround.
- */
-#if SIBYTE_1956_WAR
-static unsigned int last_mode1[DUART_MAX_LINE];
-#endif
-
 static inline u32 READ_SERCSR(volatile u32 *addr, int line)
 {
 	u32 val = csr_in32(addr);
-#if SIBYTE_1956_WAR
-	csr_out32(last_mode1[line], uart_states[line].mode_1);
-#endif
+	SB1_SER1956_WAR;
 	return val;
 }
 
 static inline void WRITE_SERCSR(u32 val, volatile u32 *addr, int line)
 {
 	csr_out32(val, addr);
-#if SIBYTE_1956_WAR
-	csr_out32(last_mode1[line], uart_states[line].mode_1);
-#endif
+	SB1_SER1956_WAR;
 }
 
 static void init_duart_port(uart_state_t *port, int line)
@@ -158,6 +159,8 @@ static void init_duart_port(uart_state_t *port, int line)
 		port->mode_2 = IOADDR(UNIT_CHANREG(line, R_DUART_MODE_REG_2));
 		port->clk_sel = IOADDR(UNIT_CHANREG(line, R_DUART_CLK_SEL));
 		port->cmd = IOADDR(UNIT_CHANREG(line, R_DUART_CMD));
+		port->last_cflags = DEFAULT_CFLAGS;
+		spin_lock_init(&port->outp_lock);
 		port->flags |= DUART_INITIALIZED;
 	}
 }
@@ -173,7 +176,7 @@ static inline void duart_mask_ints(unsigned int line, unsigned int mask)
 	WRITE_SERCSR(tmp & ~mask, port->imr, line);
 }
 
-	
+
 /* Unmask the passed interrupt lines at the duart level */
 static inline void duart_unmask_ints(unsigned int line, unsigned int mask)
 {
@@ -213,7 +216,7 @@ static inline void transmit_char_pio(uart_state_t *us)
 		duart_mask_ints(us->line, M_DUART_IMR_TX);
 	}
 
-      	if (us->open &&
+	if (us->open &&
 	    (us->outp_count < (SERIAL_XMIT_SIZE/2))) {
 		/*
 		 * We told the discipline at one point that we had no
@@ -227,9 +230,9 @@ static inline void transmit_char_pio(uart_state_t *us)
 	}
 }
 
-/* 
+/*
  * Generic interrupt handler for both channels.  dev_id is a pointer
- * to the proper uart_states structure, so from that we can derive 
+ * to the proper uart_states structure, so from that we can derive
  * which port interrupted
  */
 
@@ -290,10 +293,10 @@ static int duart_write_room(struct tty_struct *tty)
 
 /* memcpy the data from src to destination, but take extra care if the
    data is coming from user space */
-static inline int copy_buf(char *dest, const char *src, int size, int from_user) 
+static inline int copy_buf(char *dest, const char *src, int size, int from_user)
 {
 	if (from_user) {
-		(void) copy_from_user(dest, src, size); 
+		(void) copy_from_user(dest, src, size);
 	} else {
 		memcpy(dest, src, size);
 	}
@@ -316,7 +319,8 @@ static int duart_write(struct tty_struct *tty, const unsigned char *buf,
 	us = tty->driver_data;
 	if (!us) return 0;
 
-	pr_debug("duart_write called for %i chars by %i (%s)\n", count, current->pid, current->comm);
+	pr_debug("duart_write called for %i chars by %i (%s)\n", count,
+			current->pid, current->comm);
 
 	spin_lock_irqsave(&us->outp_lock, flags);
 
@@ -342,7 +346,7 @@ static int duart_write(struct tty_struct *tty, const unsigned char *buf,
 
 	spin_unlock_irqrestore(&us->outp_lock, flags);
 
-	if (us->outp_count && !tty->stopped && 
+	if (us->outp_count && !tty->stopped &&
 	    !tty->hw_stopped && !(us->flags & TX_INTEN)) {
 		us->flags |= TX_INTEN;
 		duart_unmask_ints(us->line, M_DUART_IMR_TX);
@@ -379,11 +383,13 @@ static void duart_flush_chars(struct tty_struct * tty)
 {
 	uart_state_t *port;
 
-	if (!tty) return;
+	if (!tty)
+		return;
 
 	port = tty->driver_data;
 
-	if (!port) return;
+	if (!port)
+		return;
 
 	if (port->outp_count <= 0 || tty->stopped || tty->hw_stopped) {
 		return;
@@ -393,7 +399,7 @@ static void duart_flush_chars(struct tty_struct * tty)
 	duart_unmask_ints(port->line, M_DUART_IMR_TX);
 }
 
-/* Return the number of characters in the output buffer that have yet to be 
+/* Return the number of characters in the output buffer that have yet to be
    written */
 static int duart_chars_in_buffer(struct tty_struct *tty)
 {
@@ -436,10 +442,10 @@ static inline void duart_set_cflag(unsigned int line, unsigned int cflag)
 	switch (cflag & CSIZE) {
 	case CS7:
 		mode_reg1 |= V_DUART_BITS_PER_CHAR_7;
-		
+
 	default:
-		/* We don't handle CS5 or CS6...is there a way we're supposed to flag this? 
-		   right now we just force them to CS8 */
+		/* We don't handle CS5 or CS6...is there a way we're supposed to
+		 * flag this?  right now we just force them to CS8 */
 		mode_reg1 |= 0x0;
 		break;
 	}
@@ -452,13 +458,13 @@ static inline void duart_set_cflag(unsigned int line, unsigned int cflag)
 	if (cflag & PARODD) {
 		mode_reg1 |= M_DUART_PARITY_TYPE_ODD;
 	}
-	
+
 	/* Formula for this is (5000000/baud)-1, but we saturate
 	   at 12 bits, which means we can't actually do anything less
 	   that 1200 baud */
 	switch (cflag & CBAUD) {
-	case B200:	
-	case B300:	
+	case B200:
+	case B300:
 	case B1200:	clk_divisor = 4095;		break;
 	case B1800:	clk_divisor = 2776;		break;
 	case B2400:	clk_divisor = 2082;		break;
@@ -467,6 +473,7 @@ static inline void duart_set_cflag(unsigned int line, unsigned int cflag)
 	case B9600:	clk_divisor = 519;		break;
 	case B19200:	clk_divisor = 259;		break;
 	case B38400:	clk_divisor = 129;		break;
+	default:
 	case B57600:	clk_divisor = 85;		break;
 	case B115200:	clk_divisor = 42;		break;
 	}
@@ -482,25 +489,26 @@ static void duart_set_termios(struct tty_struct *tty, struct termios *old)
 {
 	uart_state_t *us = (uart_state_t *) tty->driver_data;
 
-	pr_debug("duart_set_termios called by %i (%s)\n", current->pid, current->comm);
+	pr_debug("duart_set_termios called by %i (%s)\n", current->pid,
+		current->comm);
 	if (old && tty->termios->c_cflag == old->c_cflag)
 		return;
 	duart_set_cflag(us->line, tty->termios->c_cflag);
 }
 
-static int get_serial_info(uart_state_t *us, struct serial_struct * retinfo) {
-
+static int get_serial_info(uart_state_t *us, struct serial_struct * retinfo)
+{
 	struct serial_struct tmp;
 
 	memset(&tmp, 0, sizeof(tmp));
 
-	tmp.type=PORT_SB1250;
-	tmp.line=us->line;
-	tmp.port=UNIT_CHANREG(tmp.line,0);
-	tmp.irq=UNIT_INT(tmp.line);
-	tmp.xmit_fifo_size=16; /* fixed by hw */
-	tmp.baud_base=5000000;
-	tmp.io_type=SERIAL_IO_MEM;
+	tmp.type = PORT_SB1250;
+	tmp.line = us->line;
+	tmp.port = UNIT_CHANREG(tmp.line,0);
+	tmp.irq = UNIT_INT(tmp.line);
+	tmp.xmit_fifo_size = 16; /* fixed by hw */
+	tmp.baud_base = 5000000;
+	tmp.io_type = SERIAL_IO_MEM;
 
 	if (copy_to_user(retinfo,&tmp,sizeof(*retinfo)))
 		return -EFAULT;
@@ -588,10 +596,10 @@ static void duart_stop(struct tty_struct *tty)
 }
 
 /* Not sure on the semantics of this; are we supposed to wait until the stuff
-   already in the hardware FIFO drains, or are we supposed to wait until 
-   we've drained the output buffer, too?  I'm assuming the former, 'cause thats
-   what the other drivers seem to assume 
-*/
+ * already in the hardware FIFO drains, or are we supposed to wait until
+ * we've drained the output buffer, too?  I'm assuming the former, 'cause thats
+ * what the other drivers seem to assume
+ */
 
 static void duart_wait_until_sent(struct tty_struct *tty, int timeout)
 {
@@ -602,7 +610,7 @@ static void duart_wait_until_sent(struct tty_struct *tty, int timeout)
 	pr_debug("duart_wait_until_sent(%d)+\n", timeout);
 	while (!(READ_SERCSR(us->status, us->line) & M_DUART_TX_EMT)) {
 		set_current_state(TASK_INTERRUPTIBLE);
-	 	schedule_timeout(1);
+		schedule_timeout(1);
 		if (signal_pending(current))
 			break;
 		if (timeout && time_after(jiffies, orig_jiffies + timeout))
@@ -638,8 +646,8 @@ static int duart_open(struct tty_struct *tty, struct file *filp)
 		return -ENODEV;
 
 	pr_debug("duart_open called by %i (%s), tty is %p, rw is %p, ww is %p\n",
-	       current->pid, current->comm, tty, tty->read_wait,
-	       tty->write_wait);
+	       current->pid, current->comm, tty, (void *)&tty->read_wait,
+	       (void *)&tty->write_wait);
 
 	us = uart_states + line;
 	tty->driver_data = us;
@@ -750,7 +758,7 @@ static void __init sb1250_duart_init_present_lines(void)
 
 /* Set up the driver and register it, register the UART interrupts.  This
    is called from tty_init, or as a part of the module init */
-static int __init sb1250_duart_init(void) 
+static int __init sb1250_duart_init(void)
 {
 	int i;
 
@@ -777,14 +785,21 @@ static int __init sb1250_duart_init(void)
 			continue;
 
 		init_duart_port(port, i);
-		spin_lock_init(&port->outp_lock);
 		duart_mask_ints(i, M_DUART_IMR_ALL);
 		if (request_irq(UNIT_INT(i), duart_int, 0, "uart", port)) {
 			panic("Couldn't get uart0 interrupt line");
 		}
-		__raw_writeq(M_DUART_RX_EN|M_DUART_TX_EN,
-			     IOADDR(UNIT_CHANREG(i, R_DUART_CMD)));
-		duart_set_cflag(i, DEFAULT_CFLAGS);
+		/*
+		 * this generic write to a register does not implement the 1956 WAR
+		 * and sometimes output gets corrupted afterwards, especially
+		 * if the port was in use as a console.
+		 */
+		__raw_writel(M_DUART_RX_EN|M_DUART_TX_EN, port->cmd);
+		/*
+		 * we should really check to see if it's registered as a console
+		 * before trashing those settings
+		 */
+		duart_set_cflag(i, port->last_cflags);
 	}
 
 	/* Interrupts are now active, our ISR can be called. */
@@ -851,7 +866,7 @@ static void ser_console_write(struct console *cons, const char *s,
 		if (*s == '\n')
 			serial_outc('\r', line);
 		serial_outc(*s++, line);
-    	}
+	}
 	WRITE_SERCSR(imr, port->imr, line);
 }
 
@@ -867,25 +882,54 @@ static int ser_console_setup(struct console *cons, char *str)
 
 	sb1250_duart_init_present_lines();
 
-	for (i=0; i<DUART_MAX_LINE; i++) {
+	for (i = 0; i < DUART_MAX_LINE; i++) {
 		uart_state_t *port = uart_states + i;
+		u32 cflags = DEFAULT_CFLAGS;
 
 		if (!sb1250_duart_present[i])
 			continue;
 
 		init_duart_port(port, i);
-#if SIBYTE_1956_WAR
-		last_mode1[i] = V_DUART_PARITY_MODE_NONE|V_DUART_BITS_PER_CHAR_8;
-#endif
-		WRITE_SERCSR(V_DUART_PARITY_MODE_NONE|V_DUART_BITS_PER_CHAR_8,
-			     port->mode_1, i);
-		WRITE_SERCSR(M_DUART_STOP_BIT_LEN_1,
-			     port->mode_2, i);
-		WRITE_SERCSR(V_DUART_BAUD_RATE(115200),
-			     port->clk_sel, i);
-		WRITE_SERCSR(M_DUART_RX_EN|M_DUART_TX_EN,
-			     port->cmd, i);
+		if (str) {
+			int speed;
+			char par = 'n';
+			int cbits = 8;
+
+			cflags = 0;
+
+			/*
+			 * format is in Documentation/serial_console.txt
+			 */
+			sscanf(str, "%d%c%d", &speed, &par, &cbits);
+
+			switch (speed) {
+				case 200:
+				case 300:
+				case 1200:	cflags |= B1200;	break;
+				case 1800:	cflags |= B1800;	break;
+				case 2400:	cflags |= B2400;	break;
+				case 4800:	cflags |= B4800;	break;
+				default:
+				case 9600:	cflags |= B9600;	break;
+				case 19200:	cflags |= B19200;	break;
+				case 38400:	cflags |= B38400;	break;
+				case 57600:	cflags |= B57600;	break;
+				case 115200:cflags |= B115200;	break;
+			}
+			switch (par) {
+				case 'o':	cflags |= PARODD;
+				case 'e':	cflags |= PARENB;
+			}
+			switch (cbits) {
+				default:	// we only do 7 or 8
+				case 8:	cflags |= CS8; break;
+				case 7:	cflags |= CS7; break;
+			}
+		}
+		duart_set_cflag(i, cflags);
+		WRITE_SERCSR(M_DUART_RX_EN | M_DUART_TX_EN, port->cmd, i);
 	}
+
 	return 0;
 }
 
@@ -900,6 +944,7 @@ static struct console sb1250_ser_cons = {
 
 static int __init sb1250_serial_console_init(void)
 {
+	//add_preferred_console("duart", 0, "57600n8");
 	register_console(&sb1250_ser_cons);
 	return 0;
 }
-- 
1.4.4.4


--SLDf9lqlvOQaIe6s--
