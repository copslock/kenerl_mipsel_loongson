Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Jun 2009 07:55:22 +0200 (CEST)
Received: from mail-px0-f191.google.com ([209.85.216.191]:53874 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491771AbZFNFzN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 14 Jun 2009 07:55:13 +0200
Received: by pxi29 with SMTP id 29so222835pxi.22
        for <multiple recipients>; Sat, 13 Jun 2009 22:54:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=DwckijutvMWAZPCA30bwtzBqvcQ5HhZsOOk/qfZHw1s=;
        b=B7kV3npHR87YtyhKpGjCnQTwqihSRPBt9ZmbKYQAZhhVkICM0rNSJhBYvqsR1oDnUg
         ryH8QwpXRaQyrjUKCabf4IZu6nRAjvDejy9uH27V89L+eoq2UlNPP1c0f2V2QSp4IvWa
         sNs96rS8Ix7srG83k1HWIZfSFj9MFizsx6mAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JjZ8p3bxpQ265e+5potAfpbi/LiYFm2z80tUDzPwtnW1JKJRoE7K0tDzg7RPIozVZU
         FiySQ/IM/bS/wm7pmFSwUSyDB5izMqugJj8GM2i7iuCl4tvOy3nL+Xxa4GScW4tmJN2h
         dst1WoO+EO+iqQ9nUjqT0PhR2CJCZETabtQMk=
Received: by 10.114.80.18 with SMTP id d18mr9564968wab.122.1244958875703;
        Sat, 13 Jun 2009 22:54:35 -0700 (PDT)
Received: from localhost.localdomain ([219.246.59.144])
        by mx.google.com with ESMTPS id j31sm3806586waf.33.2009.06.13.22.54.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Jun 2009 22:54:35 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel@vger.kernel.org,
	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Steven Rostedt <rostedt@goodmis.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Wu Zhangjin <wuzj@lemote.com>
Subject: [PATCH] kmemtrace:fix undeclared 'PAGE_SIZE' via asm/page.h
Date:	Sun, 14 Jun 2009 13:54:23 +0800
Message-Id: <1244958863-28899-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.3.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

when compiling linux-mips with kmemtrace enabled, this error will be
there:

include/linux/trace_seq.h:12: error: 'PAGE_SIZE' undeclared here (not in
				a function)

I checked the source code and found trace_seq.h used PAGE_SIZE but not
include the relative header file, so, fix it via adding the header file
<asm/page.h>

this error will not be triggered in linux-x86 for there is a
<asm/page.h> header file included in a certain header file. but which
not means <asm/page.h> is not needed in trace_seq.h

Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 include/linux/trace_seq.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index c68bccb..c134dd1 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -3,6 +3,8 @@
 
 #include <linux/fs.h>
 
+#include <asm/page.h>
+
 /*
  * Trace sequences are used to allow a function to call several other functions
  * to create a string of data to use (up to a max of PAGE_SIZE.
-- 
1.6.0.4
