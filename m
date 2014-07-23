Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 15:42:41 +0200 (CEST)
Received: from mail-wg0-f46.google.com ([74.125.82.46]:32787 "EHLO
        mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826470AbaGWNmfV3PFM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 15:42:35 +0200
Received: by mail-wg0-f46.google.com with SMTP id m15so1202619wgh.29
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 06:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TJsY3/aIXYDq4Cqc+Sr+reLrUt7cd9pml1Tng/1cy1o=;
        b=jCGkzl6PxsDDBT5cD6ohnaEV4fKEgWCtn5XjtIWcEdSfZXsxV6GHstApGXNyTK10ai
         32cmhWf+t32Lby0VzwyS5OzbNdtTvaICpMJinJPFw8GjlWvJoOhsL/GkmYYXAw2zV3mD
         0yxyHutNMc0VP9qJwFLpPEEn90a746PCt1g91Jefq6+QCKj6cuC9kzB6gm9KlLY1jLfu
         7xOZeU8/k50zBgT8LRP8el4n877wHTQ03ZsKOgS0B0Ewxo0KQjnlDu1MyKauWHTwheBj
         UcUv46b0A9XxH8WPLNpO0CUv87BYPKiosKBbc0V1NqGn3M/efZdcERmKgke8CI65Dyqr
         FT7A==
X-Gm-Message-State: ALoCoQkEoKdJPlHuEt5K3Hle4pBclgpRc5ZeuLeajGzikTkFzPjJ2EiZDrgEV7V884h4C1rRDswn
X-Received: by 10.194.133.42 with SMTP id oz10mr2092387wjb.40.1406122949173;
        Wed, 23 Jul 2014 06:42:29 -0700 (PDT)
Received: from localhost.localdomain (host31-50-226-70.range31-50.btcentralplus.com. [31.50.226.70])
        by mx.google.com with ESMTPSA id w10sm9359341wie.22.2014.07.23.06.42.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 06:42:28 -0700 (PDT)
From:   Alex Smith <alex@alex-smith.me.uk>
To:     linux-mips@linux-mips.org
Cc:     Alex Smith <alex@alex-smith.me.uk>
Subject: [PATCH 00/11] MIPS ptrace/core dump fixes and cleanups
Date:   Wed, 23 Jul 2014 14:40:05 +0100
Message-Id: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
X-Mailer: git-send-email 1.9.1
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@alex-smith.me.uk
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

This patch set includes a number of fixes and cleanups for ptrace and
core dumps. The bulk of the changes are to make core dumps work again,
which have been broken since the core dumper was switched to use
regsets.

This series applies on top of Ralf's mips-for-linux-next branch.

Thanks,
Alex

Alex Smith (11):
  MIPS: ptrace: Avoid smp_processor_id() when retrieving FPU IR
  MIPS: ptrace: Test correct task's flags in task_user_regset_view()
  MIPS: asm/reg.h: Make 32- and 64-bit definitions available at the same
    time
  MIPS: ptrace: Change GP regset to use correct core dump register
    layout
  MIPS: ptrace: Always copy FCSR in FP regset
  MIPS: O32/32-bit: Fix bug which can cause incorrect system call
    restarts
  MIPS: O32/32-bit: Remove outdated comment
  MIPS: ptrace: Fix user pt_regs definition, use in
    ptrace_{get,set}regs()
  MIPS: Remove old core dump functions
  MIPS: Remove asm/user.h
  MIPS: asm/reg.h: Move to uapi

 arch/mips/include/asm/Kbuild        |   1 +
 arch/mips/include/asm/elf.h         |  17 ---
 arch/mips/include/asm/ptrace.h      |   8 +-
 arch/mips/include/asm/reg.h         | 129 +----------------
 arch/mips/include/asm/user.h        |  58 --------
 arch/mips/include/uapi/asm/ptrace.h |  25 ++--
 arch/mips/include/uapi/asm/reg.h    | 206 ++++++++++++++++++++++++++
 arch/mips/kernel/binfmt_elfo32.c    |  38 -----
 arch/mips/kernel/process.c          |  57 +-------
 arch/mips/kernel/ptrace.c           | 281 +++++++++++++++++++++++++++---------
 arch/mips/kernel/ptrace32.c         |  10 +-
 arch/mips/kernel/scall32-o32.S      |   2 -
 12 files changed, 447 insertions(+), 385 deletions(-)
 delete mode 100644 arch/mips/include/asm/user.h
 create mode 100644 arch/mips/include/uapi/asm/reg.h

-- 
1.9.1
