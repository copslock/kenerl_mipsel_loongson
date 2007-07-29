Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jul 2007 23:01:28 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.171]:13817 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022945AbXG2WBZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 29 Jul 2007 23:01:25 +0100
Received: by ug-out-1314.google.com with SMTP id u2so1009813uge
        for <linux-mips@linux-mips.org>; Sun, 29 Jul 2007 15:01:08 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JeIXaok1hpVs2sFfiLUddA/3PT2LA/tjkjGdPzM2DhRP8rYQwrIQPABzPR0DW1F1YCU9Ei55QqwKEAuHhnQH/o8a2U3CbFo1L6tNBlnUUbxcYGoJfz6Bn4zu5ENVm5kd+wkI1E8M28R2G1oaio6RA2bqYaaigU6PpvF7HUo/Suw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mXHc8rNIEIHYQtM5IPUgUoU0mgg6cBD2sVHTUUUE63NrzHXjFzmIwAAAAHEHOLM7a0z14NVLA7LqJ28EknkfKHKKqTkwY2VoE58aCmRyvfatXxMdMnTMApJzMn2omFj1HvX+eyto7VbDCtot6wv/yF0pHIDK+iG5obpLp69FtT0=
Received: by 10.86.26.11 with SMTP id 11mr3481971fgz.1185746467911;
        Sun, 29 Jul 2007 15:01:07 -0700 (PDT)
Received: from ?192.168.1.34? ( [90.184.90.115])
        by mx.google.com with ESMTPS id e8sm10894981muf.2007.07.29.15.01.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jul 2007 15:01:07 -0700 (PDT)
From:	Jesper Juhl <jesper.juhl@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] mips: remove some duplicate includes
Date:	Sun, 29 Jul 2007 23:59:35 +0200
User-Agent: KMail/1.9.7
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Fuxin Zhang <zhangfx@lemote.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707292359.35971.jesper.juhl@gmail.com>
Return-Path: <jesper.juhl@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jesper.juhl@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

This patch removes some duplicate includes from arch/mips/


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 arch/mips/kernel/signal32.c   |    1 -
 arch/mips/lemote/lm2e/irq.c   |    1 -
 arch/mips/mipssim/sim_setup.c |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 486b8e5..64b612a 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -18,7 +18,6 @@
 #include <linux/errno.h>
 #include <linux/wait.h>
 #include <linux/ptrace.h>
-#include <linux/compat.h>
 #include <linux/suspend.h>
 #include <linux/compiler.h>
 #include <linux/uaccess.h>
diff --git a/arch/mips/lemote/lm2e/irq.c b/arch/mips/lemote/lm2e/irq.c
index 05693bc..3e0b7be 100644
--- a/arch/mips/lemote/lm2e/irq.c
+++ b/arch/mips/lemote/lm2e/irq.c
@@ -25,7 +25,6 @@
  */
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/irq.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
diff --git a/arch/mips/mipssim/sim_setup.c b/arch/mips/mipssim/sim_setup.c
index 17819b5..d012719 100644
--- a/arch/mips/mipssim/sim_setup.c
+++ b/arch/mips/mipssim/sim_setup.c
@@ -22,7 +22,6 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/ioport.h>
-#include <linux/serial.h>
 #include <linux/tty.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
