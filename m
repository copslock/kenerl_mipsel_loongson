Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2015 23:13:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15313 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013082AbbESVNtoJPOW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2015 23:13:49 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2CCBB145EBFBD;
        Tue, 19 May 2015 22:13:42 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 19 May
 2015 22:13:46 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Tue, 19 May
 2015 22:13:45 +0100
Received: from [127.0.1.1] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 19 May
 2015 14:13:42 -0700
Subject: [PATCH 0/2] MIPS: MSA: bugfixes of context switch
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     <linux-mips@linux-mips.org>, <rusty@rustcorp.com.au>,
        <alexinbeijing@gmail.com>, <paul.burton@imgtec.com>,
        <david.daney@cavium.com>, <alex@alex-smith.me.uk>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <james.hogan@imgtec.com>, <markos.chandras@imgtec.com>,
        <macro@linux-mips.org>, <eunb.song@samsung.com>,
        <manuel.lauss@gmail.com>, <andreas.herrmann@caviumnetworks.com>
Date:   Tue, 19 May 2015 14:13:42 -0700
Message-ID: <20150519211222.35859.52798.stgit@ubuntu-yegoshin>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

Two bug fixes of MSA registers set handling during context switch.

This fixes are respones to multithreading MSA application crash.
It was traced to incorrect handling of MSA registers set during
thread cloning. See inside.
---

Leonid Yegoshin (2):
      MIPS: MSA: bugfix - disable MSA during thread switch correctly
      MIPS: MSA: bugfix of keeping MSA live context through clone or fork


 arch/mips/include/asm/switch_to.h |    1 -
 arch/mips/kernel/process.c        |    1 -
 arch/mips/kernel/r4k_switch.S     |    6 ++++++
 3 files changed, 6 insertions(+), 2 deletions(-)

--
Signature
