Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Nov 2010 04:04:00 +0100 (CET)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:64922 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492134Ab0KZDD4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Nov 2010 04:03:56 +0100
Received: by gwj20 with SMTP id 20so788382gwj.36
        for <multiple recipients>; Thu, 25 Nov 2010 19:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=cx4KKLGrT2eiFfZ8fIFGNhFp+cat4h871ytX4jWYy+Q=;
        b=V8ubIAn2jkxAmu9S5kDDOOY5W6WgjQvj625riYmrt1J1pdE/kER11kFgB9H2Aw5q2w
         SKtMokkL9rVvbwrjdYPOyCpxxkrUmmUZD1/gexKfRLVys0tbAwhm2JVlcu4kDqff1R08
         ZxOcqNp4GhAq6vDKJJHz7GAaF/I6LhrJInJQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=QDFtyoqyJwQplEVYNcCU4ymRnE7BcqHOZ0aidgisuFlzSUovjs5y5ZoYrMoxNUIAy8
         Ddb7/0h1Lv1PO3p8AlP84jAO8WjP0o/47i/RUqkVEZgynsk1NkiZyNkf4HczYJhdHZfE
         Yl2/7YVidCFQAiyWHbPSUfmXpCe0rl0aHUrl8=
Received: by 10.90.37.28 with SMTP id k28mr3727298agk.53.1290740629250;
        Thu, 25 Nov 2010 19:03:49 -0800 (PST)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id 43sm933046yhl.37.2010.11.25.19.03.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 19:03:47 -0800 (PST)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, dengcheng.zhu@gmail.com
Subject: [PATCH v2 0/5] MIPS/Perf-events: Sync with mainline upper layer (v2)
Date:   Fri, 26 Nov 2010 11:05:02 +0800
Message-Id: <1290740707-32586-1-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28530
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
