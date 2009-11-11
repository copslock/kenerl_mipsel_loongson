Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 14:28:54 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:63425 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492533AbZKKN2r (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 14:28:47 +0100
Received: by pzk35 with SMTP id 35so803096pzk.22
        for <multiple recipients>; Wed, 11 Nov 2009 05:28:39 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=96R8JtDwqURPufR3tnH5DCGmpXwIJlj1Qw5rRyI+JnA=;
        b=UFRuMhAZp4ePRxkxB9HfwYkdRpvU9Y4/Ltg/cFriWSiO+zYx9MllVUCoLjRiTwaYth
         MRaqeslm5PQhpkWzIYhMKzRUHXKvXc4VEnKjxZqeo7g0pZikuScNVkRi1//m5Mjkox9j
         +/xc/GIl+rltUCiQaqOK5eiy5LwZ3Uvhg7ggo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=f/4To7UzCu6lpYkV5dR4jaiB+WCGDIZlkHw7ddYZet8TsShYFmPUCrKpOa5WQI34CM
         9JzAwDXgkK+MZwxBWoIFRKUm8UQseFtUttye3ahcBnI6veMEvp9Mszx/r/vQIb2aSPGd
         CEFCDXNvf6XRm2RnB+SFoLf/+HyQA0rFHxu9M=
Received: by 10.114.86.2 with SMTP id j2mr3174509wab.159.1257946119343;
        Wed, 11 Nov 2009 05:28:39 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1009558pzk.14.2009.11.11.05.28.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 05:28:39 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue] [loongson] arch/mips/pci/fixup-lemote2f.c: Remove unused variable
Date:	Wed, 11 Nov 2009 21:28:28 +0800
Message-Id: <cb3016a658fa22eca85a6f2cf4f30b5f030a1634.1257946042.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

(Hi, Ralf, Could you please fold it into "MIPS: Lemote-2f: Add PCI
 support"?)

This patch fixes the following warning:

arch/mips/pci/fixup-lemote2f.c:115: warning: unused variable 'val'

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/pci/fixup-lemote2f.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/fixup-lemote2f.c b/arch/mips/pci/fixup-lemote2f.c
index e7c2b4d..caf2ede 100644
--- a/arch/mips/pci/fixup-lemote2f.c
+++ b/arch/mips/pci/fixup-lemote2f.c
@@ -112,8 +112,6 @@ static void __init loongson_cs5536_ide_fixup(struct pci_dev *pdev)
 
 static void __init loongson_cs5536_acc_fixup(struct pci_dev *pdev)
 {
-	u8 val;
-
 	/* enable the AUDIO interrupt in PIC  */
 	pci_write_config_dword(pdev, PCI_ACC_INT_REG, 1);
 
-- 
1.6.2.1
