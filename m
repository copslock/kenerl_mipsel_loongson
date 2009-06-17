Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2009 09:55:59 +0200 (CEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:33392 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491937AbZFQHzx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Jun 2009 09:55:53 +0200
Received: by fxm23 with SMTP id 23so141831fxm.0
        for <linux-mips@linux-mips.org>; Wed, 17 Jun 2009 00:54:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :organization:user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=6D6jCo1d3ZbYyQu9Blbp1aJLUx49y4ZDsoIeWavyKYI=;
        b=EebR31DvALuajXhUrbPe7r3cg0vP89lM7Nb1APN4Hu3hqeTe/GOl7y/tZpFWxyVcP6
         iMQd7Okur71lrbHRa9iKtsiirKNLB7aXPbGykH4oDeRwACAYW92YGF6b50Sa7QMw7UvG
         t4SDNXs12PHR1pwd86pQh939oLHm9+si4Vlw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        b=vUIBuONLhF72kr52pg27W413j/9uo3On+yj8fC+zOYYeLg1udOs0Q35sgQDEffvlx6
         T6FaPkbs1rIRuQoQnIC3ksMT5K5yR+LDubdsKCYotSS+2L9TrxRhAqq34wQtwFVIGaY6
         N+9Pfvvu7bCB8+shX5Qne30+nNgDrChVf61Io=
Received: by 10.103.222.1 with SMTP id z1mr5053286muq.44.1245225269624;
        Wed, 17 Jun 2009 00:54:29 -0700 (PDT)
Received: from ?0.0.0.0? (p5496CC7D.dip.t-dialin.net [84.150.204.125])
        by mx.google.com with ESMTPS id u9sm839624muf.37.2009.06.17.00.54.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Jun 2009 00:54:29 -0700 (PDT)
Message-ID: <4A38A173.9010508@gmail.com>
Date:	Wed, 17 Jun 2009 09:55:31 +0200
From:	Manuel Lauss <manuel.lauss@googlemail.com>
Organization: Private
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: [PATCH] -git compile fixes for MIPS
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips


Quick fixes for some compile failures which have cropped up
in linus-git in the last 24 hours:

   CC      arch/mips/kernel/time.o
In file included from linux-2.6.git/include/linux/bug.h:4,
                  from linux-2.6.git/arch/mips/kernel/time.c:13:
linux-2.6.git/arch/mips/include/asm/bug.h:10: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'BUG'
linux-2.6.git/arch/mips/include/asm/bug.h: In function '__BUG_ON':
linux-2.6.git/arch/mips/include/asm/bug.h:26: error: implicit declaration of function 'BUG'

   CC      arch/mips/mm/uasm.o
In file included from linux-2.6.git/arch/mips/mm/uasm.c:21:
linux-2.6.git/arch/mips/include/asm/bugs.h: In function 'check_bugs':
linux-2.6.git/arch/mips/include/asm/bugs.h:34: error: implicit declaration of function 'smp_processor_id'
linux-2.6.git/arch/mips/mm/uasm.c: In function 'uasm_copy_handler':
linux-2.6.git/arch/mips/mm/uasm.c:514: error: implicit declaration of function 'memcpy'

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
  arch/mips/include/asm/bug.h  |    2 +-
  arch/mips/include/asm/bugs.h |    1 +
  arch/mips/mm/uasm.c          |    1 +
  3 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
index 08ea468..92b372a 100644
--- a/arch/mips/include/asm/bug.h
+++ b/arch/mips/include/asm/bug.h
@@ -7,7 +7,7 @@

  #include <asm/break.h>

-static inline void __noreturn BUG(void)
+static inline void __attribute__((noreturn)) BUG(void)
  {
  	__asm__ __volatile__("break %0" : : "i" (BRK_BUG));
  	/* Fool GCC into thinking the function doesn't return. */
diff --git a/arch/mips/include/asm/bugs.h b/arch/mips/include/asm/bugs.h
index 9dc10df..b160a70 100644
--- a/arch/mips/include/asm/bugs.h
+++ b/arch/mips/include/asm/bugs.h
@@ -11,6 +11,7 @@

  #include <linux/bug.h>
  #include <linux/delay.h>
+#include <linux/smp.h>

  #include <asm/cpu.h>
  #include <asm/cpu-info.h>
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index f467199..ba538f7 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -15,6 +15,7 @@
  #include <linux/kernel.h>
  #include <linux/types.h>
  #include <linux/init.h>
+#include <linux/string.h>

  #include <asm/inst.h>
  #include <asm/elf.h>
-- 
1.6.3.1
