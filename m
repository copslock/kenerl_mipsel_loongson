Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2IFWIW14246
	for linux-mips-outgoing; Sun, 18 Mar 2001 07:32:18 -0800
Received: from boco.fee.vutbr.cz (boco.fee.vutbr.cz [147.229.9.11])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2IFWHM14243
	for <linux-mips@oss.sgi.com>; Sun, 18 Mar 2001 07:32:17 -0800
Received: from fest.stud.fee.vutbr.cz (fest.stud.fee.vutbr.cz [147.229.9.16])
	by boco.fee.vutbr.cz (8.11.3/8.11.3) with ESMTP id f2IFWCt12317
	(using TLSv1/SSLv3 with cipher EDH-RSA-DES-CBC3-SHA (168 bits) verified OK)
	for <linux-mips@oss.sgi.com>; Sun, 18 Mar 2001 16:32:14 +0100 (CET)
Received: (from xmichl03@localhost)
	by fest.stud.fee.vutbr.cz (8.11.2/8.11.2) id f2IFWB218968;
	Sun, 18 Mar 2001 16:32:11 +0100 (CET)
From: Michl Ladislav <xmichl03@stud.fee.vutbr.cz>
Date: Sun, 18 Mar 2001 16:32:11 +0100 (CET)
X-processed: pine.send
To: <linux-mips@oss.sgi.com>
Subject: arc cmdline.c
Message-ID: <Pine.BSF.4.33.0103181559120.18101-100000@fest.stud.fee.vutbr.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi all,

i have some beginner questions, so please be patient with me :-)

1) quoting indy-hd-boot-micro-howto.html:
O.k. we're almost there. The last thing to do is to tell the PROM which
file to boot on power up:
[snip]
	setenv OSLoader linux
	setenv SystemPartition scsi(0)disk(1)rdisk(0)partition(8)
	setenv OSLoadPartition /dev/sda1

but OSLoadPartition is ignored, so this no loger works. does it mean that
i have to use
	setenv root /dev/sda1
instead?

hmm, i really hate gotos :-(

--- cmdline.c.orig	Sun Mar 18 15:26:02 2001
+++ cmdline.c	Sun Mar 18 15:46:22 2001
@@ -34,23 +34,18 @@
 	char *cp;
 	int actr, i;

-	actr = 1; /* Always ignore argv[0] */
-
 	cp = &(arcs_cmdline[0]);
-	while(actr < prom_argc) {
-		for(i = 0; i < NENTS(ignored); i++) {
-			int len = strlen(ignored[i]);
-
-			if(!strncmp(prom_argv[actr], ignored[i], len))
-				goto pic_cont;
+
+	/* Always ignore argv[0] */
+	for (actr = 1; actr < prom_argc; actr++) {
+		for (i = 0; i < NENTS(ignored); i++) {
+			if (strncmp(prom_argv[actr], ignored[i], strlen(ignored[i]))) {
+				/* Ok, we want it. */
+				strcpy(cp, prom_argv[actr]);
+				cp += strlen(prom_argv[actr]);
+				*cp++ = ' ';
+			}
 		}
-		/* Ok, we want it. */
-		strcpy(cp, prom_argv[actr]);
-		cp += strlen(prom_argv[actr]);
-		*cp++ = ' ';
-
-	pic_cont:
-		actr++;
 	}
 	if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
 		--cp;

2) i also don't understand directory layout in arch/mips. i expected
indy's prom cmdline in arch/mips/sgi/prom, but found it in arch/mips/arc.
is there any historical (or other) reason for this?

3) what compiler are you using? compilation of glibc2.2.2 with gcc 2.95.2
took about 11 (!) hours on 100 MHz Indy, ie much more than on i486. now
i'm trying build gcc 3.0 from cvs, i hope it helps.

thanks for explanation,
ladis
