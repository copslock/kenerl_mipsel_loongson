Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 21:09:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52822 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008792AbbIVTJUClyqP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 21:09:20 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B5086250E767;
        Tue, 22 Sep 2015 20:09:09 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 20:09:13 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 20:09:11 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 0/2] MAAR SMP fix
Date:   Tue, 22 Sep 2015 12:08:46 -0700
Message-ID: <1442948929-15862-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This series improves support for Memory Accessibility Attribute
Registers (MAARs) by printing their configuration during boot and by
applying the configuration to secondary CPUs, which have their own
independent MAAR state.

Paul Burton (2):
  MIPS: print MAAR configuration during boot
  MIPS: initialise MAARs on secondary CPUs

 arch/mips/include/asm/maar.h |  9 +++++++
 arch/mips/kernel/smp.c       |  2 ++
 arch/mips/mm/init.c          | 57 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 65 insertions(+), 3 deletions(-)

-- 
2.5.3
