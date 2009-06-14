Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Jun 2009 08:53:37 +0200 (CEST)
Received: from mail-pz0-f179.google.com ([209.85.222.179]:59309 "EHLO
	mail-pz0-f179.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491807AbZFNGxa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 14 Jun 2009 08:53:30 +0200
Received: by pzk9 with SMTP id 9so1239562pzk.22
        for <multiple recipients>; Sat, 13 Jun 2009 23:52:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=AGYLQN3ZpvHsvwei6sceg5Ryg6TdKzgbHa3N/v4amlI=;
        b=n2b9yfixG4PzPR2HBLBSCeXLwbySeG80gasEdQEMAgcVGSWUH/LpMcrYIbokwsG20K
         8LA+qdKKknOyy5aNzgPzSnt6Ett51zJNgdiFNohOLJe+Au3t2/6QRJNs/rCStKEpF6K1
         drQfk5Krdz7cTaC6kcjpM5MIfzruePleWsU5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=UkX3I9yNC0A04CYtYZH1TmbR4tWqPTHvF/DTVFSTmOMs3OubWh97KneXk9E3Jyuwjl
         M90sSTO5I61K3E5qmyTNeOZnz3RxmE4OR4l6cOIdCrSFdNu1N92BFaDKNgFnELVCThGA
         KneaBEwFFQZ3mdUVo0ASX9/fbHsk6tQPlPjBs=
Received: by 10.114.179.13 with SMTP id b13mr9222615waf.30.1244962378404;
        Sat, 13 Jun 2009 23:52:58 -0700 (PDT)
Received: from localhost.localdomain ([219.246.59.144])
        by mx.google.com with ESMTPS id j31sm3855753waf.33.2009.06.13.23.52.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Jun 2009 23:52:57 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel@vger.kernel.org,
	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Steven Rostedt <rostedt@goodmis.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Wu Zhangjin <wuzj@lemote.com>
Subject: [PATCH] tracing: fix undeclared 'PAGE_SIZE' in include/linux/trace_seq.h
Date:	Sun, 14 Jun 2009 14:52:30 +0800
Message-Id: <1244962350-28702-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.3.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

when compiling linux-mips with kmemtrace enabled, there will be an
error:

include/linux/trace_seq.h:12: error: 'PAGE_SIZE' undeclared here (not in
				a function)

I checked the source code and found trace_seq.h used PAGE_SIZE but not
included the relative header file, so, fix it via adding the header file
<asm/page.h>

Acked-by: Pekka Enberg <penberg@cs.helsinki.fi>
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
