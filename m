Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 14:22:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46847 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992200AbcHIMWK59cGf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 14:22:10 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C80B6AD98A589;
        Tue,  9 Aug 2016 13:21:51 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 9 Aug 2016 13:21:54 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 0/2] MIPS: Memory setup tweaks
Date:   Tue, 9 Aug 2016 13:21:47 +0100
Message-ID: <cover.842913b0756706569a896ef308bb5bf98be4f0ce.1470745146.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Here are a couple of tweaks for MIPS memory setup, primarily in order to
handle memory which extends right up to the end of physical memory on
32-bit systems with 32-bit phys_addr_t. More specifically we omit the
final page of physical memory to avoid the overflow (see patch 1 for
details).

Patch 2 improves the rounding in the MAAR setup, so as to include the
first full page of an already aligned region, and to avoid a BUG_ON for
regions with non 64-KByte aligned end addresses (which I happened to hit
while working on a different version of patch 1 which wasn't correctly
merging the kernel data section into the main RAM region).

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org

James Hogan (2):
  MIPS: Allow memory reaching top of physical
  MIPS: MAAR: Fix address alignment

 arch/mips/kernel/setup.c |  7 +++++++
 arch/mips/mm/init.c      | 13 ++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

-- 
git-series 0.8.7
