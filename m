Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 21:52:31 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.156]:16339 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491108Ab0EWTwR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 21:52:17 +0200
Received: by fg-out-1718.google.com with SMTP id 22so1361831fge.6
        for <multiple recipients>; Sun, 23 May 2010 12:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=ezFqUm1mscGy3/lDBVG/zzK3OudzocCPOAchywINbhg=;
        b=DoNIYI1DA4VHTSdHkw0pffipZhY7cHBh/zUBXdDzGltwNBCWa6+axKIjXHuDHmho1V
         XMA8FQgXZtcXvTLtwc8JiUveJh0ieefkHV4zIp+xhzv7ab2XEjGyZxN01yetUuLFp7/F
         NIHRvnVwmv2d21pp8PVsLpMmuQK4mXHA5XKgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=nINSkMm/wIlndVVkJLkpbbsuSF1Sw5B27Pyao+K5ApQDUpSt1eqDb8hEzFuKKcSEsK
         ZTNKm46hW+VzryeqqDCSWCS+uDoB5VsQrVm4lWK3vEpYm589XKvbC1zRkor512vppqdC
         usW3d4ni/pmfUtF/3MVoweyJjXZV+dNNSdTWM=
Received: by 10.87.9.11 with SMTP id m11mr7130027fgi.73.1274644336067;
        Sun, 23 May 2010 12:52:16 -0700 (PDT)
Received: from localhost.localdomain (net-93-145-200-9.t2.dsl.vodafone.it [93.145.200.9])
        by mx.google.com with ESMTPS id d6sm6081796fga.3.2010.05.23.12.52.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 12:52:15 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 018/199] arch/mips/pci/ops-msc.c: Checkpatch cleanup
Date:   Sun, 23 May 2010 21:52:02 +0200
Message-Id: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 1.7.1.251.gf80a2
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
Precedence: bulk
X-list: linux-mips

arch/mips/pci/ops-msc.c:90: ERROR: "foo * bar" should be "foo *bar"
arch/mips/pci/ops-msc.c:100: ERROR: code indent should use tabs where possible
arch/mips/pci/ops-msc.c:127: ERROR: code indent should use tabs where possible

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/pci/ops-msc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/pci/ops-msc.c b/arch/mips/pci/ops-msc.c
index 5d9fbb0..3d3576f 100644
--- a/arch/mips/pci/ops-msc.c
+++ b/arch/mips/pci/ops-msc.c
@@ -87,7 +87,7 @@ static int msc_pcibios_config_access(unsigned char access_type,
  * read/write a 32bit word and mask/modify the data we actually want.
  */
 static int msc_pcibios_read(struct pci_bus *bus, unsigned int devfn,
-			     int where, int size, u32 * val)
+			    int where, int size, u32 *val)
 {
 	u32 data = 0;
 
@@ -97,7 +97,7 @@ static int msc_pcibios_read(struct pci_bus *bus, unsigned int devfn,
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (msc_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where,
-	                              &data))
+				      &data))
 		return -1;
 
 	if (size == 1)
@@ -124,7 +124,7 @@ static int msc_pcibios_write(struct pci_bus *bus, unsigned int devfn,
 		data = val;
 	else {
 		if (msc_pcibios_config_access(PCI_ACCESS_READ, bus, devfn,
-		                              where, &data))
+					      where, &data))
 			return -1;
 
 		if (size == 1)
-- 
1.7.1.251.gf80a2
