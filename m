Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 18:46:23 +0200 (CEST)
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35881 "EHLO
        mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010458AbbGNQqWcbikn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 18:46:22 +0200
Received: by obnw1 with SMTP id w1so9692027obn.3
        for <linux-mips@linux-mips.org>; Tue, 14 Jul 2015 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=7QvHLx7l8N5Co2gaUPSmhYDD5Wgi0dSjg26A6Ak2yCo=;
        b=f0LSCw7okwqqZyHU9ArP8PDyKqk2/A1RQq6HHkz+2YVNdwkOnaoRSY61vbOITYsS6c
         aqsipDMLIeJBammwE3u9F77CW5EsrLrAHIoagX4yerOvxnYt/+3hZ2mMggeSQ8Y23xMb
         zkvNv/dBMZc+TBELGI14UZUsuSnFRCHuna1irZbTpr1PrylLYzToOUNODNKLwn4cXTap
         gsBuYvOI60PtPdvuy0LeNOleqjRp4XixLWI1wfzqjyRF2DpxJl+rbZODwoD0kOi4WZpY
         ++UfWxJ1d5AR4f+5muxDAeQBs0In9a7+SQJ5C9MVVKb172SOn1eq1v+pKcSiByRKzP1z
         u+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=7QvHLx7l8N5Co2gaUPSmhYDD5Wgi0dSjg26A6Ak2yCo=;
        b=K45nG8A+KWs4pbBcIAO/3i3m29MLMHTd9nQ1THBSVaW7EaJNAEUa2CVxFf0D7NfZkd
         9yfiv3jNjt4dS8y1KQbTN5ytbQP0mIzcKTRRKdGwK0SnWvs2o5e07ecrl9BqXmrU/ZXZ
         oisZ9gEtlB7gYlXM4T1K+nRnu8sjJi0gPlmSXHKEJcDXrDRou3/RUznv6MNrK1MyYC62
         fCLVL3ElYZzwUYN4v7oYXsie1f1KTszq6iD9KWEbuZmfj2wMpg8doYOqjrf1i5AO1bfN
         GzGfzAR80x0VjSl4SpF7nQjqlcebeljTDdb2ixpy1hgQB2CZIWaApuiaod4plRau8gTG
         4GaQ==
X-Gm-Message-State: ALoCoQlj01ykNIAuj5XDxk0ffDbj8WpATxodTtn4aNtK2SFOjlg64S9Iv9MXz3H+Ut3t1vgG1Jws
X-Received: by 10.182.247.102 with SMTP id yd6mr35641836obc.39.1436892376533;
        Tue, 14 Jul 2015 09:46:16 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id fh3sm748121obb.23.2015.07.14.09.46.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Jul 2015 09:46:15 -0700 (PDT)
Subject: [PATCH v2 0/8] Remove "weak" usage
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Jul 2015 11:46:13 -0500
Message-ID: <20150714164142.1541.92710.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

These patches don't fix any problem I'm aware of, but I think they make the
code easier to analyze, and they reduce the likelihood of issues if MIPS
ever builds a multi-platform kernel.

Weak function declarations in header files are hard to use safely because
they make every definition weak.  If the linker sees multiple weak
definitions, it silently chooses one based on link order.  That's not a
very obvious criterion, and it can easily lead to running the wrong
version.

These patches remove the weak attribute from function declarations and
rework the code to match.  I don't have any of these platforms, so I can't
test them, but my intent is that these should cause no functional change.

Changes from v1-v2:
  - Rework vpe_run() patch to simply drop "weak" and the test for definition
  - #include <asm/irq.h> in kernel/time.c instead of #ifdef MIPS_CPU_IRQ_BASE
  - Add Reviewed-by from James for unchanged patches

---

Bjorn Helgaas (8):
      MIPS: CPC: Remove "weak" from mips_cpc_phys_base() and make it static
      MIPS: Remove "weak" from platform_maar_init() declaration
      MIPS: MT: Remove "weak" from vpe_run() declaration
      MIPS: Remove "weak" from get_c0_perfcount_int() declaration
      MIPS: Remove "weak" from get_c0_compare_int() declaration
      MIPS: Remove "weak" from get_c0_fdc_int() declaration
      MIPS: Remove "weak" from mips_cdmm_phys_base() declaration
      MIPS: Remove "__weak" definition from arch-specific linkage.h


 arch/mips/include/asm/cdmm.h         |    4 ++--
 arch/mips/include/asm/irq.h          |    2 +-
 arch/mips/include/asm/linkage.h      |    1 -
 arch/mips/include/asm/maar.h         |    2 +-
 arch/mips/include/asm/mips-cpc.h     |   10 ----------
 arch/mips/include/asm/time.h         |    4 ++--
 arch/mips/include/asm/vpe.h          |    2 +-
 arch/mips/kernel/cevt-r4k.c          |   11 +++++++----
 arch/mips/kernel/mips-cpc.c          |    9 ++++++++-
 arch/mips/kernel/perf_event_mipsxx.c |    7 +------
 arch/mips/kernel/time.c              |    9 ++++++++-
 arch/mips/kernel/vpe.c               |    2 +-
 arch/mips/oprofile/op_model_mipsxx.c |    8 +-------
 drivers/bus/mips_cdmm.c              |   14 +++++++++++++-
 drivers/tty/mips_ejtag_fdc.c         |    9 ++++++---
 15 files changed, 52 insertions(+), 42 deletions(-)
