Return-Path: <SRS0=7KIV=YC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3145ECE58D
	for <linux-mips@archiver.kernel.org>; Wed,  9 Oct 2019 13:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B701321A4A
	for <linux-mips@archiver.kernel.org>; Wed,  9 Oct 2019 13:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfJIN1a (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:27:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:47412 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731152AbfJIN1a (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 9 Oct 2019 09:27:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70562AC6E;
        Wed,  9 Oct 2019 13:27:28 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Clean up ARC code and fix IP22/28 early printk
Date:   Wed,  9 Oct 2019 15:27:11 +0200
Message-Id: <20191009132718.25346-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

While fixing the problem of not working EARLY_PRINTK on IP22/IP28
I've removed not used ARC function and made 32bit ARC PROMs working
with 64bit kernels. By switching to memory detection via PROM calls
EARLY_PRINTK works now. And by using the regular 64bit spaces
maximum memory of 384MB on Indigo2 R4k machines is working, too.

Thomas Bogendoerfer (6):
  MIPS: fw: arc: remove unused ARC code
  MIPS: fw: arc: use call_o32 to call ARC prom from 64bit kernel
  MIPS: Kconfig: always select ARC_MEMORY and ARC_PROMLIB for platform
  MIPS: fw: arc: workaround 64bit kernel/32bit ARC problems
  MIPS: SGI-IP22: set PHYS_OFFSET to memory start
  MIPS: SGI-IP22/28: Use PROM for memory detection

 arch/mips/Kconfig                        |  32 +++-----
 arch/mips/fw/arc/Makefile                |   2 +-
 arch/mips/fw/arc/env.c                   |   6 --
 arch/mips/fw/arc/file.c                  |  49 ------------
 arch/mips/fw/arc/identify.c              |   5 ++
 arch/mips/fw/arc/init.c                  |   5 ++
 arch/mips/fw/arc/memory.c                |   9 +++
 arch/mips/fw/arc/misc.c                  |  59 --------------
 arch/mips/fw/arc/promlib.c               |  25 +++++-
 arch/mips/fw/arc/salone.c                |  25 ------
 arch/mips/fw/arc/time.c                  |  25 ------
 arch/mips/fw/arc/tree.c                  | 127 -------------------------------
 arch/mips/include/asm/bootinfo.h         |   1 +
 arch/mips/include/asm/mach-ip22/spaces.h |  12 +--
 arch/mips/include/asm/sgialib.h          |  12 ---
 arch/mips/include/asm/sgiarcs.h          | 103 ++++++++-----------------
 arch/mips/sgi-ip22/ip22-mc.c             |  74 +++++-------------
 17 files changed, 105 insertions(+), 466 deletions(-)
 delete mode 100644 arch/mips/fw/arc/salone.c
 delete mode 100644 arch/mips/fw/arc/time.c
 delete mode 100644 arch/mips/fw/arc/tree.c

-- 
2.16.4

