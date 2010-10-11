Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2010 14:22:22 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:51054 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490958Ab0JKMWT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Oct 2010 14:22:19 +0200
Received: by pwi2 with SMTP id 2so579650pwi.36
        for <multiple recipients>; Mon, 11 Oct 2010 05:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=hJQhuma3Z4blc0NYJiMKyzCBUFSQ121svj5cD7FyLBI=;
        b=CWwbMgqnegBkgL+sT0s6cR4/ssAhEVpteOKWdwnVpSZMo7n6pa5pdyjIsSJ9+8vdll
         Ks26d52XQvQhp7CuJ+Ng7LravfEVFDFUdcwaCJOZFLnUGL1adad4epvBEPi22Lfg4ZaF
         yp35IEdHaND4whcUSHeZieJlMIqD4xLjGTYkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=YuwXdjJCtYmQRdJHNSJSR9FbzJECHflJNp4+C6ba+oWcJzdNp5clYTMYYYoxwQ2LsP
         ouJXNDTo9T4V+WzCcm4XRNWpUCxFx20y/Du7OLvtYSc67HxAP26VPjBb1JiJhottaOwb
         WKYp+XkkEgh45AicHv+uY+1F3+3y2fIEkhfW8=
Received: by 10.114.110.16 with SMTP id i16mr6903581wac.208.1286799732647;
        Mon, 11 Oct 2010 05:22:12 -0700 (PDT)
Received: from [114.84.73.67] ([114.84.73.67])
        by mx.google.com with ESMTPS id d2sm13270279wam.14.2010.10.11.05.21.44
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 05:21:55 -0700 (PDT)
Message-ID: <4CB300A2.2070101@gmail.com>
Date:   Mon, 11 Oct 2010 20:18:42 +0800
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
MIME-Version: 1.0
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com
Subject: [PATCH v3] Perf-tool/MIPS: support cross compiling of tools/perf
 for MIPS
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips



This version fixed the cosmetic issue pointed out by Ralf. If it looks ok,

Ralf, please help Ack it.


Thanks,


Deng-Cheng


Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>

---
 tools/perf/perf.h |   12 ++++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 6fb379b..cd05284 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -73,6 +73,18 @@
 #define cpu_relax()	asm volatile("":::"memory")
 #endif

+#ifdef __mips__
+#include "../../arch/mips/include/asm/unistd.h"
+#define rmb()		asm volatile(					\
+				".set	mips2\n\t"			\
+				"sync\n\t"				\
+				".set	mips0"				\
+				: /* no output */			\
+				: /* no input */			\
+				: "memory")
+#define cpu_relax()	asm volatile("" ::: "memory")
+#endif
+
 #include<time.h>
 #include<unistd.h>
 #include<sys/types.h>
