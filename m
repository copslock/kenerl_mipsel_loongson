Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 13:37:23 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:47689 "EHLO
        linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012519AbcBKMhDeoFAJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 13:37:03 +0100
Received: from localhost (handman.bmw-carit.intra [192.168.101.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linuxmail.bmw-carit.de (Postfix) with ESMTPS id D56FB5D23A;
        Thu, 11 Feb 2016 13:19:57 +0100 (CET)
From:   Daniel Wagner <daniel.wagner@bmw-carit.de>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v5 0/2] Differentiate between 32 and 64 bit ELF header
Date:   Thu, 11 Feb 2016 13:36:53 +0100
Message-Id: <1455194215-20026-1-git-send-email-daniel.wagner@bmw-carit.de>
X-Mailer: git-send-email 2.5.0
Return-Path: <daniel.wagner@oss.bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.wagner@bmw-carit.de
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

Hi Maciej,

The missing typeof(*(hdr)) is back in this version. I wonder why
I didn't see the warning by gcc with v4.

cheers,
daniel

Daniel Wagner (2):
  crash_dump: Add vmcore_elf32_check_arch
  mips: Differentiate between 32 and 64 bit ELF header

 arch/mips/include/asm/elf.h      | 13 +++++++++----
 arch/mips/kernel/binfmt_elfn32.c |  4 ++--
 arch/mips/kernel/binfmt_elfo32.c |  4 ++--
 fs/proc/vmcore.c                 |  2 +-
 include/linux/crash_dump.h       |  8 ++++++--
 5 files changed, 20 insertions(+), 11 deletions(-)

-- 
2.5.0
