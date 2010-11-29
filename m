Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2010 10:17:26 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:63807 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491170Ab0K2JRQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Nov 2010 10:17:16 +0100
Received: by yxm34 with SMTP id 34so2075556yxm.36
        for <multiple recipients>; Mon, 29 Nov 2010 01:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+vhx78frq4px7ttV/O2fH/3692VSqnKQ9aOvYjlZ4z4=;
        b=AB54qHhXeB/q46FhpGslNUQ2LzSNPcAvOl3w8VFMScKCL+5/Rk2k3beysBw3oo/5Ww
         aD9KqSbL0lb+MCFbBTRnO39md7H8lKsf3gjWAOX6L51L3SAjKQOb4ka2CakDt5zfR+FZ
         uPr3DblnSa0asoZDKwrh9Ad2RluZ3nHAkS5kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=IhQYTsBxXqDM8ENfTaknHaqDFOF6zCqJxAVqQQDbrlR5rYstRJCG2faHhPTlqZZa1j
         k+RuA0bJHcIT77vlvoScBLKa260bLs26w9mwNnvBLNSLoOSuS7+iWf2QfJLgodsc3ZYN
         lHoWSoQz3ahSZAJcw5VCbeYI+dMUscdsskP6Y=
Received: by 10.90.111.20 with SMTP id j20mr7792521agc.117.1291022230135;
        Mon, 29 Nov 2010 01:17:10 -0800 (PST)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id u68sm522697yhc.47.2010.11.29.01.17.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 01:17:08 -0800 (PST)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, dengcheng.zhu@gmail.com, matt@console-pimps.org,
        sshtylyov@mvista.com
Subject: [PATCH v3 0/5] MIPS/Perf-events: Sync with mainline upper layer (v3)
Date:   Mon, 29 Nov 2010 17:19:06 +0800
Message-Id: <1291022351-13152-1-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Current MIPS Perf-events uses older interfaces to the generic layer. So it
will not work. This patch set fixes this issue (reported by Wu Zhangjin) by
adding MIPS counterparts for a list of previous commits that went to
mainline earlier.

Changes:
v3 - v2:
o Keep all mentioned commits in the form of number + title + original
summary + (MIPS specific info when needed).
v2 - v1:
o Corrected the return value of the event check in validate_event().

Deng-Cheng Zhu (5):
  MIPS/Perf-events: Work with irq_work
  MIPS/Perf-events: Work with the new PMU interface
  MIPS/Perf-events: Fix event check in validate_event()
  MIPS/Perf-events: Work with the new callchain interface
  MIPS/Perf-events: Use unsigned delta for right shift in event update

 arch/mips/Kconfig                    |    1 +
 arch/mips/include/asm/perf_event.h   |   12 +-
 arch/mips/kernel/perf_event.c        |  345 ++++++++++++++++------------------
 arch/mips/kernel/perf_event_mipsxx.c |    4 +-
 4 files changed, 171 insertions(+), 191 deletions(-)
