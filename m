Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jan 2008 03:44:12 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.155]:13764 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S28575132AbYAHDoE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Jan 2008 03:44:04 +0000
Received: by fg-out-1718.google.com with SMTP id d23so4269683fga.32
        for <linux-mips@linux-mips.org>; Mon, 07 Jan 2008 19:44:03 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=4l0FkKxLkvbzMkrpI+MpCTEjXAcRIuSVBJHdhcBYZX0=;
        b=NAhnf/BOVHrwi4UEYZ4CKIjjau3tEPhKlWJXYuDew/NuE1yujic3bj9yb/k7HqgZgFekolgGBwqNcBDkquHgDsKm0rTUFi1ylXLkW+xbQx17SZK9z9god9s5W7lHLnmkQPcQkYe93IjSZ9XXbS1uKcLGEkrbfdGj4wHwiuBU4LA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=gFJwa9yfh1dTCbOqghsVs2jbsp7sgo3q1AXb8G4i8A4L7IrMhBIDKQcF+vaBNNxYKqMfdyijgh9/cCUMHH03X+EBlsqRYuDKA6E/j6Ot1HIkV2eD71KidiU1GwixFwcTXLvM/8x74z8Op+XyngiZpU/gWcD4DPjj/6BQIGaqtCY=
Received: by 10.86.51.2 with SMTP id y2mr213949fgy.6.1199763843887;
        Mon, 07 Jan 2008 19:44:03 -0800 (PST)
Received: from ?192.168.1.3? ( [85.140.8.229])
        by mx.google.com with ESMTPS id e20sm23687335fga.1.2008.01.07.19.44.02
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Jan 2008 19:44:03 -0800 (PST)
Message-ID: <4782F180.7000104@gmail.com>
Date:	Tue, 08 Jan 2008 06:44:00 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Organization: DmVo Home
User-Agent: Thunderbird 1.5.0.14pre (X11/20071022)
MIME-Version: 1.0
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
CC:	Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [BUG][PATCH] fix broken software reset for Malta board
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

From: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>

I noticed that the commit f197465384bf7ef1af184c2ed1a4e268911a91e3
(MIPS Tech: Get rid of volatile in core code) broke the software
reset functionality for MIPS Malta boards in big-endian mode.

According to the MIPS Malta board user's manual, writing the magic
32-bit GORESET value into the SOFTRES register initiates board soft
reset. My experimentation has shown that the endianness of the GORESET
integer should thereby be the same as the endianness, which has been
set for the CPU itself. The writew() function used to write the magic
value in the code introduced by the commit mentioned above, however,
swaps bytes for big-endian kernels and transfers 16 bits instead of 32.

The patch below replaces the writew() function by the __raw_writel()
routine, which leaves the byte order intact and transfers the whole
MIPS machine word. Trivial code cleanup (replacing spaces by a tab
and cutting oversized lines to make checkpatch.pl happy) is also
included.

The patch was tested using a Malta evaluation board running in both
BE and LE modes. For both modes, software reset was fully functional
after the change.

P.S. I suspect that the same commit broke the "standby" functionality
for MIPS Atlas boards. However, I did not touch the Atlas code as I
don't have such board at my disposal and also because the linux-mips.org
Web site claims that Atlas support is scheduled for removal.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>

---
diff --git a/arch/mips/mips-boards/generic/reset.c b/arch/mips/mips-boards/generic/reset.c
index 7a1bb51..583d468 100644
--- a/arch/mips/mips-boards/generic/reset.c
+++ b/arch/mips/mips-boards/generic/reset.c
@@ -39,16 +39,18 @@ static void atlas_machine_power_off(void);
 
 static void mips_machine_restart(char *command)
 {
-	unsigned int __iomem *softres_reg = ioremap(SOFTRES_REG, sizeof(unsigned int));
+	unsigned int __iomem *softres_reg =
+		ioremap(SOFTRES_REG, sizeof(unsigned int));
 
-	writew(GORESET, softres_reg);
+	__raw_writel(GORESET, softres_reg);
 }
 
 static void mips_machine_halt(void)
 {
-        unsigned int __iomem *softres_reg = ioremap(SOFTRES_REG, sizeof(unsigned int));
+	unsigned int __iomem *softres_reg =
+		ioremap(SOFTRES_REG, sizeof(unsigned int));
 
-	writew(GORESET, softres_reg);
+	__raw_writel(GORESET, softres_reg);
 }
 
 #if defined(CONFIG_MIPS_ATLAS)
