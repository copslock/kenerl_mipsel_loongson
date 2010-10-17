Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Oct 2010 18:41:57 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:41691 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491144Ab0JQQly (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Oct 2010 18:41:54 +0200
Received: by pvg3 with SMTP id 3so11353pvg.36
        for <multiple recipients>; Sun, 17 Oct 2010 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=VhLBA0LCkI0hWu7iCxudyWK6mwElJysVDPAd8KsTU5A=;
        b=ppTwhjswWrCW0JHzyc+odT42oZSHAbQuY3IXhUyDa++ZylZX4CU5D7qu7LrvJw59bH
         8xA9R+qo7rDUyjbkUzonSiPDFgz+6le1Akl5Yp4pTy37kWLnXankwx+v6/MAGqIODj9j
         MB2TO+23NU+bIJ1DmgeR1QvhDE6ZE50r+VnRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mZTFiqmuuyvLPvwp45xWfpZOY+J0cnQ8VNYClKKyPk1AyI/onxmuI19zuDEEF9QkO5
         3ziTUYMGOnrgLZcdWWAEUPc2GOnusl/IyB60nPDsaBk68sVd6Kea3nniIRFdhYhGjact
         xZc8JK/82uGCN0eywJ80MCcYivvEDom68/tkI=
Received: by 10.142.213.15 with SMTP id l15mr2587332wfg.87.1287333705502;
        Sun, 17 Oct 2010 09:41:45 -0700 (PDT)
Received: from localhost.localdomain ([211.201.183.198])
        by mx.google.com with ESMTPS id e36sm17192731wfj.2.2010.10.17.09.41.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Oct 2010 09:41:44 -0700 (PDT)
From:   Namhyung Kim <namhyung@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Fix build failure on asm/fcntl.h
Date:   Mon, 18 Oct 2010 01:41:39 +0900
Message-Id: <1287333699-1254-1-git-send-email-namhyung@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <namhyung@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: namhyung@gmail.com
Precedence: bulk
X-list: linux-mips

  CC      security/integrity/ima/ima_fs.o
In file included from linux/include/linux/fcntl.h:4:0,
                 from linux/security/integrity/ima/ima_fs.c:18:
linux/arch/mips/include/asm/fcntl.h:63:2: error: expected specifier-qualifier-list before 'off_t'
make[3]: *** [security/integrity/ima/ima_fs.o] Error 1
make[2]: *** [security/integrity/ima/ima_fs.o] Error 2
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 arch/mips/include/asm/fcntl.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/fcntl.h b/arch/mips/include/asm/fcntl.h
index e482fe9..75edded 100644
--- a/arch/mips/include/asm/fcntl.h
+++ b/arch/mips/include/asm/fcntl.h
@@ -56,6 +56,7 @@
  */
 
 #ifdef CONFIG_32BIT
+#include <linux/types.h>
 
 struct flock {
 	short	l_type;
-- 
1.7.0.4
