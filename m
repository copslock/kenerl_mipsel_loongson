Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2014 15:33:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41779 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009415AbaIVNdOctRyQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Sep 2014 15:33:14 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0EC127CDDB0A8;
        Mon, 22 Sep 2014 14:33:05 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 22 Sep
 2014 14:33:07 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 22 Sep 2014 14:33:07 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 22 Sep 2014 14:33:06 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Minor MIPS ftrace fixes
Date:   Mon, 22 Sep 2014 14:32:57 +0100
Message-ID: <1411392779-9554-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi,

A few more fixes for ftrace/MIPS. The first patch fixes the
value of the MCOUNT_INSN_SIZE definition which holds the
total size of the mcount() call. The second one, fixes
the selfpc argument for the ftrace tracing function.

Markos Chandras (2):
  MIPS: ftrace.h: Fix the MCOUNT_INSN_SIZE definition
  MIPS: mcount: Fix selfpc address for static trace

 arch/mips/include/asm/ftrace.h | 2 +-
 arch/mips/kernel/ftrace.c      | 4 +++-
 arch/mips/kernel/mcount.S      | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.1.0
