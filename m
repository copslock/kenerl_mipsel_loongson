Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Apr 2003 16:14:35 +0100 (BST)
Received: from natsmtp00.webmailer.de ([IPv6:::ffff:192.67.198.74]:26340 "EHLO
	post.webmailer.de") by linux-mips.org with ESMTP
	id <S8225212AbTDMPOe>; Sun, 13 Apr 2003 16:14:34 +0100
Received: from excalibur.cologne.de (p508510AA.dip.t-dialin.net [80.133.16.170])
	by post.webmailer.de (8.12.8/8.8.7) with ESMTP id h3DFEW7S009850
	for <linux-mips@linux-mips.org>; Sun, 13 Apr 2003 17:14:33 +0200 (MEST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.35 #1 (Debian))
	id 194jJP-0004R1-00
	for <linux-mips@linux-mips.org>; Sun, 13 Apr 2003 17:22:31 +0200
Date: Sun, 13 Apr 2003 17:22:26 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030413152226.GB1968@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
References: <20030402120316Z8225232-1272+1120@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20030402120316Z8225232-1272+1120@linux-mips.org>
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 02, 2003 at 01:03:08PM +0100, macro@linux-mips.org wrote:

> Changes by:	macro@ftp.linux-mips.org	03/04/02 13:03:08
> 
> Modified files:
> 	drivers/char   : Tag: linux_2_4 dz.c 
> 	drivers/tc     : Tag: linux_2_4 zs.c 
> 
> Log message:
> 	Set .owner in case the code gets modularized.  Patch by Hanna Linder.

I guess something went wrong here. Maciej, you are trying to set a field
"owner" in a struct tty_driver, which does not have an "owner" field.
This results in dz.c and zs.c not compiling.

Besides this problem, Ralf's recent changes regarding the CPU infos
broke the build for DECstations:

http://cvs.linux-mips.org/cvsweb/linux/arch/mips/dec/prom/init.c.diff?r1=1.8&r2=1.9&f=h

uses current_cpu_data instead of mips_cpu but does not define it. To get
them defined, inclusion of <asm/processor.h> and <linux/smp.h> is needed.

Appended is a small patch which makes the CVS compileable again.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cvs_20030413_compile_fix.patch"

diff -Nur linux.orig/arch/mips/dec/prom/init.c linux/arch/mips/dec/prom/init.c
--- linux.orig/arch/mips/dec/prom/init.c	Mon Apr  7 02:17:06 2003
+++ linux/arch/mips/dec/prom/init.c	Sun Apr 13 16:51:11 2003
@@ -11,7 +11,8 @@
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
 #include <asm/dec/prom.h>
-
+#include <asm/processor.h>
+#include <linux/smp.h>
 
 int (*__rex_bootinit)(void);
 int (*__rex_bootread)(void);
diff -Nur linux.orig/drivers/char/dz.c linux/drivers/char/dz.c
--- linux.orig/drivers/char/dz.c	Wed Apr  2 14:03:00 2003
+++ linux/drivers/char/dz.c	Sun Apr 13 15:20:43 2003
@@ -1310,7 +1310,7 @@
 
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
-	serial_driver.owner = THIS_MODULE;
+/*	serial_driver.owner = THIS_MODULE; */
 #if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
 	serial_driver.name = "ttyS";
 #else
diff -Nur linux.orig/drivers/tc/zs.c linux/drivers/tc/zs.c
--- linux.orig/drivers/tc/zs.c	Wed Apr  2 14:03:04 2003
+++ linux/drivers/tc/zs.c	Sun Apr 13 15:20:57 2003
@@ -1888,7 +1888,7 @@
 
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
-	serial_driver.owner = THIS_MODULE;
+/*	serial_driver.owner = THIS_MODULE; */
 #if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
 	serial_driver.name = "tts/%d";
 #else




--MGYHOYXEY6WxJCY8--
