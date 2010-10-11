Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2010 15:41:15 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:64265 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491079Ab0JKNlL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Oct 2010 15:41:11 +0200
Received: by pwi2 with SMTP id 2so603970pwi.36
        for <multiple recipients>; Mon, 11 Oct 2010 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=Fr5NO7bFFUOGrDzneQjfDtieKeDAVT5xqxkdnoSGsLM=;
        b=QqUrcnOqEmBONpxKpHRTYf3aNhGoCdoAPL3xxPQFQ9uZM0UNxRU+wdOb+i9fdzZG/H
         ozS1X1hLXyY2x2W9S116g6dgPo+NloWpQufV2UlnutTckJXZigDymrVhBMRAOTed1aFF
         dypTjYCW8rqysT6FmBWPnUl5cpIqGb4zKVrmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=WI0DIE5tjH+flQaAM4y/x0VoxBo+qnB/9JSE+WOCgJKM8aUf9Rg679l7lCGnYa+u6d
         1zjzlh9IRPRfLjve4QEnQIo4OwHU/LjwPNdbzNzAx9uYwIT/pogfQc7GudbGLPqVlCRz
         YB+9XNnB8GaWJQI7LOvn5JnWLE1cnoxImYRtM=
Received: by 10.114.120.9 with SMTP id s9mr7031367wac.100.1286804464108;
        Mon, 11 Oct 2010 06:41:04 -0700 (PDT)
Received: from [114.84.73.67] ([114.84.73.67])
        by mx.google.com with ESMTPS id i4sm3577436wal.22.2010.10.11.06.40.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 06:41:00 -0700 (PDT)
Message-ID: <4CB3133A.5060106@gmail.com>
Date:   Mon, 11 Oct 2010 21:38:02 +0800
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
MIME-Version: 1.0
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        a.p.zijlstra@chello.nl, paulus@samba.org,
        Ingo Molnar <mingo@elte.hu>, acme@redhat.com
Subject: [PATCH v3 resend] Perf-tool/MIPS: support cross compiling of tools/perf
 for MIPS
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips



(Resending this version of patch to append the changelogs.)

This version fixed the cosmetic issue pointed out by Ralf. If it looks ok,

Ralf, please help Ack it. Thanks!


Changes
--------
v3 - v2:
o Fix the cosmetic issue of redundant dot-ops

v2 - v1:
o Change rmb() to use SYNC

v1:
o Include mips unistd.h and define rmb()/cpu_relax() in tools/perf/perf.h

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
