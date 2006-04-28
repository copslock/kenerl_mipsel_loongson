Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2006 12:20:00 +0100 (BST)
Received: from tool.snarl.nl ([213.84.251.124]:36022 "HELO tool.snarl.nl")
	by ftp.linux-mips.org with SMTP id S8133464AbWD1LTs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Apr 2006 12:19:48 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 922D15E5A1;
	Fri, 28 Apr 2006 13:19:34 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27907-04; Fri, 28 Apr 2006 13:19:34 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id DEC985DF5C; Fri, 28 Apr 2006 13:19:33 +0200 (CEST)
Date:	Fri, 28 Apr 2006 13:19:33 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: trouble on serial console for au1100
Message-ID: <20060428111933.GY11097@dusktilldawn.nl>
References: <20060427154948.GI32278@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qmxOb2Rj2UkcatHw"
Content-Disposition: inline
In-Reply-To: <20060427154948.GI32278@enneenne.com>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--qmxOb2Rj2UkcatHw
Content-Type: multipart/mixed; boundary="YB12yukDSDS6vHSd"
Content-Disposition: inline


--YB12yukDSDS6vHSd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rodolfo,

On Thu, Apr 27, 2006 at 05:49:48PM +0200, Rodolfo Giometti wrote:
> I noticed that the serial lines management code is changed from
> linux-2.6.12 and I'd like to know if someone is running the serial
> console on ttyS0 on au1100...
Can it be that you face the same problem I was facing not so long
ago? After I applied the patch in the email I attach to this one
all my serial troubles on the au1100 disappeared.

At the moment I'm running kernel 2.6.16 and am using a serial
console and several other serial applications without any
problem.

So, please find attached two emails. One is the answer I received
on sort of like the same question like you pose right now and the
other is the improved patch by Jon that fixed the problem for me.

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--YB12yukDSDS6vHSd
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <domen.puncer@ultra.si>
X-Spam-Checker-Version: SpamAssassin 3.1.0 (2005-09-13) on tool.local.snarl.nl
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00 autolearn=ham 
	version=3.1.0
X-Original-To: freddy@snarl.nl
Delivered-To: freddy@snarl.nl
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 68A925DF46
	for <freddy@snarl.nl>; Fri, 14 Apr 2006 08:06:46 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27664-03 for <freddy@snarl.nl>;
	Fri, 14 Apr 2006 08:06:46 +0200 (CEST)
Received: from minnie.intcom.nl (unknown [217.115.199.145])
	by tool.snarl.nl (Postfix) with ESMTP id 039775DF41
	for <freddy@tool.snarl.nl>; Fri, 14 Apr 2006 08:06:45 +0200 (CEST)
Received: from localhost (minnie.intcom.nl [127.0.0.1])
	by minnie.intcom.nl (Postfix) with ESMTP id AC12413C01C
	for <freddy@dusktilldawn.nl>; Fri, 14 Apr 2006 08:06:45 +0200 (CEST)
Received: from minnie.intcom.nl ([127.0.0.1])
	by localhost (minnie.intcom.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 24765-03 for <freddy@dusktilldawn.nl>;
	Fri, 14 Apr 2006 08:06:45 +0200 (CEST)
Received: from deliver-1.mx.triera.net (deliver-1.mx.triera.net [213.161.0.31])
	by minnie.intcom.nl (Postfix) with SMTP id F3745139D2B
	for <freddy@dusktilldawn.nl>; Fri, 14 Apr 2006 08:06:44 +0200 (CEST)
Received: from localhost (in-3.mx.triera.net [213.161.0.27])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 16ED6C052;
	Fri, 14 Apr 2006 08:06:39 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-3.mx.triera.net (Postfix) with SMTP id 250381BC091;
	Fri, 14 Apr 2006 08:06:39 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 5DFC21A18BC;
	Fri, 14 Apr 2006 08:06:39 +0200 (CEST)
Date: Fri, 14 Apr 2006 08:06:41 +0200
From: Domen Puncer <domen.puncer@ultra.si>
To: Freddy Spierenburg <freddy@dusktilldawn.nl>
Cc: linux-mips@linux-mips.org
Subject: Re: UART trouble on the DBAu1100
Message-ID: <20060414060640.GE29489@domen.ultra.si>
References: <20060413131117.GP11097@dusktilldawn.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413131117.GP11097@dusktilldawn.nl>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: Triera AV Service
X-Virus-Scanned: Debian amavisd-new at minnie.intcom.nl

On 13/04/06 15:11 +0200, Freddy Spierenburg wrote:
> Hi,
> 
> I have a problem and yet am not sure where to look. It's a
> problem in the serial driver for the internal UART's of the
> AU1100. It appeared ever since 2.6.15. 2.6.14 is working like a
> charm, but 2.6.15 gives me the trouble.
> 
> When I open a tty with the open(2) system call (see attached open.c)
> I see that the UART sends a 0x36 byte on the line.

We had the same problem on Au1200, applying
http://www.linux-mips.org/archives/linux-mips/2006-03/msg00259.html
(or maybe a different version of this patch) fixed it.

> 
> But that's not the only trouble. I also do not receive any
> bytes received by the UART. All the received bytes stay
> in the input buffer of the UART only to be send up to userland
> as soon as the UART is asked to send a byte on the line itself.
> Then in one take all the bytes are received by the application
> listening.

I may be way off, but maybe it's just flow control that needs
to be turned off.


	Domen

--YB12yukDSDS6vHSd
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <linux-mips-bounce@linux-mips.org>
X-Spam-Checker-Version: SpamAssassin 3.1.0 (2005-09-13) on tool.local.snarl.nl
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,UNPARSEABLE_RELAY 
	autolearn=ham version=3.1.0
X-Original-To: freddy@snarl.nl
Delivered-To: freddy@snarl.nl
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 55AA25E58A
	for <freddy@snarl.nl>; Thu, 20 Apr 2006 14:57:03 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06563-04 for <freddy@snarl.nl>;
	Thu, 20 Apr 2006 14:57:03 +0200 (CEST)
Received: from minnie.intcom.nl (unknown [217.115.199.145])
	by tool.snarl.nl (Postfix) with ESMTP id E31315DF5C
	for <freddy@tool.snarl.nl>; Thu, 20 Apr 2006 14:57:02 +0200 (CEST)
Received: from localhost (minnie.intcom.nl [127.0.0.1])
	by minnie.intcom.nl (Postfix) with ESMTP id 96F6713D01D
	for <freddy@dusktilldawn.nl>; Thu, 20 Apr 2006 14:57:02 +0200 (CEST)
Received: from minnie.intcom.nl ([127.0.0.1])
	by localhost (minnie.intcom.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 20995-01-2 for <freddy@dusktilldawn.nl>;
	Thu, 20 Apr 2006 14:57:01 +0200 (CEST)
Received: from ftp.linux-mips.org (ftp.linux-mips.org [194.74.144.162])
	by minnie.intcom.nl (Postfix) with ESMTP id 83A4013BC98
	for <freddy@dusktilldawn.nl>; Thu, 20 Apr 2006 14:57:01 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34195 "EHLO
	ftp.linux-mips.org") by ftp.linux-mips.org with ESMTP
	id S8133546AbWDTMoE (ORCPT <rfc822;freddy@dusktilldawn.nl>);
	Thu, 20 Apr 2006 13:44:04 +0100
Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2006 13:43:37 +0100 (BST)
Received: from fri.itea.ntnu.no ([129.241.7.60]:57735 "HELO fri.itea.ntnu.no")
	by ftp.linux-mips.org with SMTP id S8133542AbWDTMn2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Apr 2006 13:43:28 +0100
Received: from localhost (localhost [127.0.0.1])
	by fri.itea.ntnu.no (Postfix) with ESMTP id DDABE7EC3;
	Thu, 20 Apr 2006 14:56:00 +0200 (CEST)
Received: from invalid.ed.ntnu.no (invalid.ed.ntnu.no [129.241.205.150])
	by fri.itea.ntnu.no (Postfix) with ESMTP;
	Thu, 20 Apr 2006 14:55:59 +0200 (CEST)
Received: from invalid.ed.ntnu.no (jonah@localhost.ed.ntnu.no [127.0.0.1])
	by invalid.ed.ntnu.no (8.13.6/8.13.6) with ESMTP id k3KCtxYf005084
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO);
	Thu, 20 Apr 2006 14:55:59 +0200 (CEST)
	(envelope-from jonah@omegav.ntnu.no)
Received: from localhost (jonah@localhost)
	by invalid.ed.ntnu.no (8.13.6/8.13.6/Submit) with ESMTP id k3KCtxD3005081;
	Thu, 20 Apr 2006 14:55:59 +0200 (CEST)
	(envelope-from jonah@omegav.ntnu.no)
X-Authentication-Warning: invalid.ed.ntnu.no: jonah owned process doing -bs
Date:	Thu, 20 Apr 2006 14:55:59 +0200 (CEST)
From:	Jon Anders Haugum <jonah@omegav.ntnu.no>
X-X-Sender: jonah@invalid.ed.ntnu.no
To:	rmk+serial@arm.linux.org.uk
Cc:	linux-serial@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] serial8250: set divisor register correctly for AMD Alchemy
 SoC uart. 3rd edition.
Message-ID: <20060420144509.V1601@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Content-Scanned: with sophos and spamassassin at mailgw.ntnu.no.
X-archive-position: 11163
X-ecartis-version: Ecartis v1.0.0
Sender:	linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonah@omegav.ntnu.no
Precedence: bulk
X-list:	linux-mips
X-Virus-Scanned: Debian amavisd-new at minnie.intcom.nl

Alchemy SoC uart have got a non-standard divisor register that needs some
special handling.

This patch adds divisor read/write functions with test and special
handling for Alchemy internal uart.

Signed-off-by: Jon Anders Haugum <jonah@omegav.ntnu.no>

---

3rd edition:
- Removed section covering 16C850 autoconfig.


--- linux-2.6.16-rc5/drivers/serial/8250.c.orig	2006-03-03 02:12:10.000000000 +0100
+++ linux-2.6.16-rc5/drivers/serial/8250.c	2006-03-03 02:16:19.000000000 +0100
@@ -362,6 +362,40 @@ serial_out(struct uart_8250_port *up, in
 #define serial_inp(up, offset)		serial_in(up, offset)
 #define serial_outp(up, offset, value)	serial_out(up, offset, value)
 
+/* Uart divisor latch read */
+static inline int _serial_dl_read(struct uart_8250_port *up)
+{
+	return serial_inp(up, UART_DLL) | serial_inp(up, UART_DLM) << 8;
+}
+
+/* Uart divisor latch write */
+static inline void _serial_dl_write(struct uart_8250_port *up, int value)
+{
+	serial_outp(up, UART_DLL, value & 0xff);
+	serial_outp(up, UART_DLM, value >> 8 & 0xff);
+}
+
+#ifdef CONFIG_SERIAL_8250_AU1X00
+/* Au1x00 haven't got a standard divisor latch */
+static int serial_dl_read(struct uart_8250_port *up)
+{
+	if (up->port.iotype == UPIO_AU)
+		return __raw_readl(up->port.membase + 0x28);
+	else
+		return _serial_dl_read(up);
+}
+
+static void serial_dl_write(struct uart_8250_port *up, int value)
+{
+	if (up->port.iotype == UPIO_AU)
+		__raw_writel(value, up->port.membase + 0x28);
+	else
+		_serial_dl_write(up, value);
+}
+#else
+#define serial_dl_read(up) _serial_dl_read(up)
+#define serial_dl_write(up, value) _serial_dl_write(up, value)
+#endif
 
 /*
  * For the 16C950
@@ -494,7 +528,8 @@ static void disable_rsa(struct uart_8250
  */
 static int size_fifo(struct uart_8250_port *up)
 {
-	unsigned char old_fcr, old_mcr, old_dll, old_dlm, old_lcr;
+	unsigned char old_fcr, old_mcr, old_lcr;
+	unsigned short old_dl;
 	int count;
 
 	old_lcr = serial_inp(up, UART_LCR);
@@ -505,10 +540,8 @@ static int size_fifo(struct uart_8250_po
 		    UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
 	serial_outp(up, UART_MCR, UART_MCR_LOOP);
 	serial_outp(up, UART_LCR, UART_LCR_DLAB);
-	old_dll = serial_inp(up, UART_DLL);
-	old_dlm = serial_inp(up, UART_DLM);
-	serial_outp(up, UART_DLL, 0x01);
-	serial_outp(up, UART_DLM, 0x00);
+	old_dl = serial_dl_read(up);
+	serial_dl_write(up, 0x0001);
 	serial_outp(up, UART_LCR, 0x03);
 	for (count = 0; count < 256; count++)
 		serial_outp(up, UART_TX, count);
@@ -519,8 +552,7 @@ static int size_fifo(struct uart_8250_po
 	serial_outp(up, UART_FCR, old_fcr);
 	serial_outp(up, UART_MCR, old_mcr);
 	serial_outp(up, UART_LCR, UART_LCR_DLAB);
-	serial_outp(up, UART_DLL, old_dll);
-	serial_outp(up, UART_DLM, old_dlm);
+	serial_dl_write(up, old_dl);
 	serial_outp(up, UART_LCR, old_lcr);
 
 	return count;
@@ -750,8 +780,7 @@ static void autoconfig_16550a(struct uar
 
 			serial_outp(up, UART_LCR, 0xE0);
 
-			quot = serial_inp(up, UART_DLM) << 8;
-			quot += serial_inp(up, UART_DLL);
+			quot = serial_dl_read(up);
 			quot <<= 3;
 
 			status1 = serial_in(up, 0x04); /* EXCR1 */
@@ -759,8 +788,7 @@ static void autoconfig_16550a(struct uar
 			status1 |= 0x10;  /* 1.625 divisor for baud_base --> 921600 */
 			serial_outp(up, 0x04, status1);
 			
-			serial_outp(up, UART_DLL, quot & 0xff);
-			serial_outp(up, UART_DLM, quot >> 8);
+			serial_dl_write(up, quot);
 
 			serial_outp(up, UART_LCR, 0);
 
@@ -1862,8 +1890,7 @@ serial8250_set_termios(struct uart_port 
 		serial_outp(up, UART_LCR, cval | UART_LCR_DLAB);/* set DLAB */
 	}
 
-	serial_outp(up, UART_DLL, quot & 0xff);		/* LS of divisor */
-	serial_outp(up, UART_DLM, quot >> 8);		/* MS of divisor */
+	serial_dl_write(up, quot);
 
 	/*
 	 * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR

--YB12yukDSDS6vHSd--

--qmxOb2Rj2UkcatHw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEUfpFbxf9XXlB0eERAssBAJ0TFnf2tg6cEs+kFId7QVGLt8U/FQCfXLYm
ShMukU0ZYsA9W8XFrQV6TaY=
=gSup
-----END PGP SIGNATURE-----

--qmxOb2Rj2UkcatHw--
