Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 15:04:30 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:51392 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493198AbZKWOEZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Nov 2009 15:04:25 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nANE4eZK005256;
	Mon, 23 Nov 2009 14:04:40 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nANE4RY8005254;
	Mon, 23 Nov 2009 14:04:27 GMT
Date:	Mon, 23 Nov 2009 14:04:27 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	dmitri.vorobiev@movial.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Move several variables from .bss to .init.data
Message-ID: <20091123140427.GA5232@linux-mips.org>
References: <1258977217-25461-1-git-send-email-dmitri.vorobiev@movial.com> <20091123.222609.74748367.anemo@mba.ocn.ne.jp> <20091123134633.GB28687@linux-mips.org> <20091123.225919.44090248.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091123.225919.44090248.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 23, 2009 at 10:59:19PM +0900, Atsushi Nemoto wrote:

> On Mon, 23 Nov 2009 13:46:33 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > > And for console option strings parts, I doubt these can be marked as
> > > __initdata.  Theoretically, the console driver might be a module,
> > 
> > No; if the driver is a module we don't offer console functionality.  Typical
> > example:
> 
> Oh, I missed that.  Thanks.  Then no objections for this part.

So below is what I've got queued now.

Thanks everbody,

  Ralf

Date:	Mon, 23 Nov 2009 13:53:37 +0200
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>

MIPS: Move several variables from .bss to .init.data

Several static uninitialized variables are used in the scope of __init
functions but are themselves not marked as __initdata.  This patch is to put
those variables to where they belong and to reduce the memory footprint a
little bit.

Also, a couple of lines with spaces instead of tabs were fixed.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Cc: linux-mips@linux-mips.org
Patchwork: http://patchwork.linux-mips.org/patch/697/
Acked-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/ar7/platform.c        |    2 +-
 arch/mips/sgi-ip22/ip22-eisa.c  |    4 ++--
 arch/mips/sgi-ip22/ip22-setup.c |    2 +-
 arch/mips/sgi-ip32/ip32-setup.c |    2 +-
 arch/mips/sni/setup.c           |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-queue/arch/mips/ar7/platform.c
===================================================================
--- linux-queue.orig/arch/mips/ar7/platform.c
+++ linux-queue/arch/mips/ar7/platform.c
@@ -505,7 +505,7 @@ static int __init ar7_register_devices(v
 	int res;
 	u32 *bootcr, val;
 #ifdef CONFIG_SERIAL_8250
-	static struct uart_port uart_port[2];
+	static struct uart_port uart_port[2] __initdata;
 
 	memset(uart_port, 0, sizeof(struct uart_port) * 2);
 
Index: linux-queue/arch/mips/sgi-ip22/ip22-eisa.c
===================================================================
--- linux-queue.orig/arch/mips/sgi-ip22/ip22-eisa.c
+++ linux-queue/arch/mips/sgi-ip22/ip22-eisa.c
@@ -50,9 +50,9 @@
 
 static char __init *decode_eisa_sig(unsigned long addr)
 {
-        static char sig_str[EISA_SIG_LEN];
+	static char sig_str[EISA_SIG_LEN] __initdata;
 	u8 sig[4];
-        u16 rev;
+	u16 rev;
 	int i;
 
 	for (i = 0; i < 4; i++) {
Index: linux-queue/arch/mips/sgi-ip22/ip22-setup.c
===================================================================
--- linux-queue.orig/arch/mips/sgi-ip22/ip22-setup.c
+++ linux-queue/arch/mips/sgi-ip22/ip22-setup.c
@@ -67,7 +67,7 @@ void __init plat_mem_setup(void)
 	cserial = ArcGetEnvironmentVariable("ConsoleOut");
 
 	if ((ctype && *ctype == 'd') || (cserial && *cserial == 's')) {
-		static char options[8];
+		static char options[8] __initdata;
 		char *baud = ArcGetEnvironmentVariable("dbaud");
 		if (baud)
 			strcpy(options, baud);
Index: linux-queue/arch/mips/sgi-ip32/ip32-setup.c
===================================================================
--- linux-queue.orig/arch/mips/sgi-ip32/ip32-setup.c
+++ linux-queue/arch/mips/sgi-ip32/ip32-setup.c
@@ -90,7 +90,7 @@ void __init plat_mem_setup(void)
 	{
 		char* con = ArcGetEnvironmentVariable("console");
 		if (con && *con == 'd') {
-			static char options[8];
+			static char options[8] __initdata;
 			char *baud = ArcGetEnvironmentVariable("dbaud");
 			if (baud)
 				strcpy(options, baud);
Index: linux-queue/arch/mips/sni/setup.c
===================================================================
--- linux-queue.orig/arch/mips/sni/setup.c
+++ linux-queue/arch/mips/sni/setup.c
@@ -60,7 +60,7 @@ static void __init sni_console_setup(voi
 	char *cdev;
 	char *baud;
 	int port;
-	static char options[8];
+	static char options[8] __initdata;
 
 	cdev = prom_getenv("console_dev");
 	if (strncmp(cdev, "tty", 3) == 0) {
