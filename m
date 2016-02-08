Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 16:45:41 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:47644 "EHLO
        linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011496AbcBHPouiF3Jk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 16:44:50 +0100
Received: from localhost (handman.bmw-carit.intra [192.168.101.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linuxmail.bmw-carit.de (Postfix) with ESMTPS id B580E5C343;
        Mon,  8 Feb 2016 16:27:58 +0100 (CET)
From:   Daniel Wagner <daniel.wagner@bmw-carit.de>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v3 0/3] Differentiate between 32 and 64 bit ELF header
Date:   Mon,  8 Feb 2016 16:44:35 +0100
Message-Id: <1454946278-13859-1-git-send-email-daniel.wagner@bmw-carit.de>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <alpine.DEB.2.00.1602061624460.15885@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1602061624460.15885@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.wagner@oss.bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51848
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

Thanks a lot for your input. It looks like we getting somewhere.
This version is much smaller and not so invasive as the prevision one.

I had some trouble with my cross compile setup. The first patch addresses
this problem. If I got it right it is just a missing include wrapper file.

cheers,
daniel

Daniel Wagner (3):
  mips: Use arch specific auxvec.h instead of generic-asm version
  crash_dump: Add vmcore_elf32_check_arch
  mips: Differentiate between 32 and 64 bit ELF header

 arch/mips/include/asm/auxvec.h   | 1 +
 arch/mips/include/asm/elf.h      | 9 +++++++--
 arch/mips/kernel/binfmt_elfn32.c | 2 +-
 arch/mips/kernel/binfmt_elfo32.c | 2 +-
 fs/proc/vmcore.c                 | 2 +-
 include/linux/crash_dump.h       | 8 ++++++--
 6 files changed, 17 insertions(+), 7 deletions(-)
 create mode 100644 arch/mips/include/asm/auxvec.h

-- 
2.5.0
