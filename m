Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 May 2006 23:54:20 +0200 (CEST)
Received: from nf-out-0910.google.com ([64.233.182.190]:28171 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133927AbWERVyM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 May 2006 23:54:12 +0200
Received: by nf-out-0910.google.com with SMTP id k27so190488nfc
        for <linux-mips@linux-mips.org>; Thu, 18 May 2006 14:54:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iVC1yKK2A6GczXIdhFG6/drRWT+DRhNWNh1h6dJDH7LpVLtekro+923A9+WVTOYwRWdoTsCFf3Xy97GPnKLWHDwIEiUDsHYWiFvdZz3jDGgAzqvEoSZxnEGutXdWitpnQgVyQXiMj/YhitoC9NvuuEVURdUvPMW2ziIOqC4rt9U=
Received: by 10.49.27.12 with SMTP id e12mr923671nfj;
        Thu, 18 May 2006 14:54:06 -0700 (PDT)
Received: by 10.49.85.18 with HTTP; Thu, 18 May 2006 14:54:06 -0700 (PDT)
Message-ID: <ecb4efd10605181454v34ef19degf2cdd2535b37fc30@mail.gmail.com>
Date:	Thu, 18 May 2006 17:54:06 -0400
From:	"Clem Taylor" <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: I2C troubles with Au1550
Cc:	"Jordan Crouse" <jordan.crouse@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

We've been having troubles with the reliability of the I2C interface
on the Au1550.  Basically 1% of the I2C transactions would timeout.
Sometimes the failures would cluster in long runs which was causing
pain.

Last night I got annoyed with the problem enough that I applied a
portion of a Au1200 I2C patch posted by Jordan Crouse on 2005.12.02.
This patch was not applied to the the linux-mips tree (as of
2.6.16.16) but it seems to have fixed our timeout problems. I ran a
I2C test for 14 hours doing constant I2C transactions from user space
and did not see an error.

Maybe Jordan could try again with a fresh patch because it really does
seem to help...

This is the subset of the patch I used:
--- drivers/i2c/busses/i2c-au1550.c	(revision 2271)
+++ drivers/i2c/busses/i2c-au1550.c	(working copy)
@@ -118,13 +118,19 @@

  	/* Reset the FIFOs, clear events.
 	*/
-	sp->psc_smbpcr = PSC_SMBPCR_DC;
+	stat = sp->psc_smbstat;
  	sp->psc_smbevnt = PSC_SMBEVNT_ALLCLR;
 	au_sync();
-	do {
-		stat = sp->psc_smbpcr;
+
+	if (!(stat & PSC_SMBSTAT_TE) || !(stat & PSC_SMBSTAT_RE)) {
+		sp->psc_smbpcr = PSC_SMBPCR_DC;
 		au_sync();
-	} while ((stat & PSC_SMBPCR_DC) != 0);
+		do {
+			stat = sp->psc_smbpcr;
+			au_sync();
+		} while ((stat & PSC_SMBPCR_DC) != 0);
+		udelay(50);
+	}

 	/* Write out the i2c chip address and specify operation
 	*/
