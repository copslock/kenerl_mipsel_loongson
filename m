Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 20:02:57 +0000 (GMT)
Received: from mms1.broadcom.com ([216.31.210.17]:36362 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133470AbWAQUCj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 20:02:39 +0000
Received: from 10.10.64.154 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Tue, 17 Jan 2006 12:06:02 -0800
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 98AA967421; Tue, 17 Jan 2006 12:06:02 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 65A9C67420 for
 <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 12:06:02 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CSK42521; Tue, 17 Jan 2006 12:06:01 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 D35B320501 for <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 12:06:01
 -0800 (PST)
Received: from localhost.localdomain ([10.9.253.119]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Tue, 17 Jan 2006 12:06:01 -0800
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by localhost.localdomain (8.13.4/8.13.4) with ESMTP id k0HK5VNS019729
 for <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 12:05:38 -0800
Received: (from mason@localhost) by localhost.localdomain (
 8.13.4/8.13.4/Submit) id k0HK5PQ6019728 for linux-mips@linux-mips.org;
 Tue, 17 Jan 2006 12:05:25 -0800
Date:	Tue, 17 Jan 2006 12:05:25 -0800
From:	"Mark Mason" <mason@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [patch] sb1250 serial patch
Message-ID: <20060117200525.GD19531@localhost.localdomain>
MIME-Version: 1.0
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 17 Jan 2006 20:06:01.0643 (UTC)
 FILETIME=[706BB7B0:01C61BA1]
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006011707; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230342E34334344344346462E303031312D412D;
 ENG=IBF; TS=20060117200603; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006011707_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FD391A010G1754300-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello all,

The recent git import changed some of the tty datastructures, and subsequently broke the special sb1250 serial driver.  This patch fixes that broken-ness, and cleans up some compilation warnings as well.
Please apply - Thanks.

[Yes - the driver needs a rewrite.  It's on our to-do list.  Really.  I promise...]

Mark


diff --git a/drivers/char/sb1250_duart.c b/drivers/char/sb1250_duart.c
--- a/drivers/char/sb1250_duart.c
+++ b/drivers/char/sb1250_duart.c
@@ -105,14 +105,14 @@ typedef struct { 
 	unsigned long       flags;
 	struct tty_struct   *tty;
 	/* CSR addresses */
-	u32		    *status;
-	u32		    *imr;
-	u32		    *tx_hold;
-	u32		    *rx_hold;
-	u32		    *mode_1;
-	u32		    *mode_2;
-	u32		    *clk_sel;
-	u32		    *cmd;
+	volatile u32	    *status;
+	volatile u32	    *imr;
+	volatile u32	    *tx_hold;
+	volatile u32	    *rx_hold;
+	volatile u32	    *mode_1;
+	volatile u32	    *mode_2;
+	volatile u32	    *clk_sel;
+	volatile u32	    *cmd;
 } uart_state_t;
 
 static uart_state_t uart_states[DUART_MAX_LINE];
@@ -130,7 +130,7 @@ static uart_state_t uart_states[DUART_MA
 static unsigned int last_mode1[DUART_MAX_LINE];
 #endif
 
-static inline u32 READ_SERCSR(u32 *addr, int line)
+static inline u32 READ_SERCSR(volatile u32 *addr, int line)
 {
 	u32 val = csr_in32(addr);
 #if SIBYTE_1956_WAR
@@ -139,7 +139,7 @@ static inline u32 READ_SERCSR(u32 *addr,
 	return val;
 }
 
-static inline void WRITE_SERCSR(u32 val, u32 *addr, int line)
+static inline void WRITE_SERCSR(u32 val, volatile u32 *addr, int line)
 {
 	csr_out32(val, addr);
 #if SIBYTE_1956_WAR
@@ -258,11 +258,7 @@ static irqreturn_t duart_int(int irq, vo
 			if (!(READ_SERCSR(us->status, us->line) & M_DUART_RX_RDY))
 				break;
 			ch = READ_SERCSR(us->rx_hold, us->line);
-			if (tty->flip.count < TTY_FLIPBUF_SIZE) {
-				*tty->flip.char_buf_ptr++ = ch;
-				*tty->flip.flag_buf_ptr++ = 0;
-				tty->flip.count++;
-			}
+			tty_insert_flip_char(tty, ch, 0);
 			udelay(1);
 			counter--;
 		}
