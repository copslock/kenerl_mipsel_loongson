Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 10:21:28 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:47672 "EHLO
        linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010943AbcBJJV0t6xz6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 10:21:26 +0100
Received: from localhost (handman.bmw-carit.intra [192.168.101.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linuxmail.bmw-carit.de (Postfix) with ESMTPS id 4FF145CD2B;
        Wed, 10 Feb 2016 10:04:25 +0100 (CET)
From:   Daniel Wagner <daniel.wagner@bmw-carit.de>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v4 0/2]  Differentiate between 32 and 64 bit ELF header
Date:   Wed, 10 Feb 2016 10:21:19 +0100
Message-Id: <1455096081-7176-1-git-send-email-daniel.wagner@bmw-carit.de>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <56BAD881.9000208@bmw-carit.de>
References: <56BAD881.9000208@bmw-carit.de>
Return-Path: <daniel.wagner@oss.bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51965
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

I did test compile a few different configurations and with and without
mrproper upfront. All looks fine now. Let's see what still goes wrong :)

cheers,
daniel

Daniel Wagner (2):
  crash_dump: Add vmcore_elf32_check_arch
  mips: Differentiate between 32 and 64 bit ELF header

 arch/mips/include/asm/elf.h      | 9 +++++++--
 arch/mips/kernel/binfmt_elfn32.c | 2 +-
 arch/mips/kernel/binfmt_elfo32.c | 2 +-
 fs/proc/vmcore.c                 | 2 +-
 include/linux/crash_dump.h       | 8 ++++++--
 5 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.5.0
