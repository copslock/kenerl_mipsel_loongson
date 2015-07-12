Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 01:10:59 +0200 (CEST)
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38139 "EHLO
        mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010267AbbGLXK5OgYDe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 01:10:57 +0200
Received: by iggf3 with SMTP id f3so9259972igg.1
        for <linux-mips@linux-mips.org>; Sun, 12 Jul 2015 16:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=Ai+AfPvz2w0AO+qZ2RdRxsKUm6etDUawB9jMJ2QKEG4=;
        b=kGOsP5+Vw5qNCcdvLKkAewcVv31xgu2AFivM2jfhc6Njejyvm5GNe1zmGwYrZHyu/f
         RYXaG/bVex689EysGsl16RN4Yuq50nw4y13yoO49RhLMEf0BVBFMcCNXgeWYF2D56EWN
         EFhtDeiKqIcCrc7cYVJSsjr44/nI/fvcs71uZzgw2tZB6/ZJgHuivewGvew3SI0D8NKT
         rAtIgyRoh/I7qf2vDgDxIaCqTZ5O1z0Dwb8F9hAjHMeN9nccrYKYmqTODXMskWpAWbUv
         hLQ37DKu+XvOIAxd7T3CTOCsOTjezuAGx+o/WG3SBcjpfK03+R8Ua6DcviX6Zq61Addu
         qNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=Ai+AfPvz2w0AO+qZ2RdRxsKUm6etDUawB9jMJ2QKEG4=;
        b=Qr3IUDK975n1dr20ro3qst3924kH3ekAW7XyLQ3lKljxXM2xVY1GgBX8LDCf+pHe6P
         5sOyINbN0lsmSvGuv8raimnMd/1Wl7y8gfQ10CklLavk8BGI6j54xDhpZg/IpmZCJes3
         IBonqZkyVDFTHfYNzowqhyamZ7uQiAX4di1pv2BqhmD7vrQZR5bwZokuTUiEAayUlpoS
         P/dR05Kh/4HB+pTi3uhNCadFqpgWogLa/29bdRzNyI8ytp6sPVFNIWwRU8r+S/SrvRHA
         RvBH5JhLBQn6f+tXhsu/0lOhpC/Hl0dkyYcCaYGpjKi6rdTzyKUZbMla9Zn4FM45ae7/
         Pbyw==
X-Gm-Message-State: ALoCoQnexXxZH/3D3Ye+BpQtF1/SV0k9KyaX8qqEUZH+ga8dxzgrv2+1giU57dpDAc+M/8JdGnh8
X-Received: by 10.50.66.234 with SMTP id i10mr9757028igt.46.1436742651214;
        Sun, 12 Jul 2015 16:10:51 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id c41sm11385727iod.8.2015.07.12.16.10.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 16:10:49 -0700 (PDT)
Subject: [PATCH 0/9] MIPS: Remove "weak" usage
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 12 Jul 2015 18:10:47 -0500
Message-ID: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48203
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

---

Bjorn Helgaas (9):
      MIPS: CPC: Remove "weak" from mips_cpc_phys_base() and make it static
      MIPS: Remove "weak" from platform_maar_init() declaration
      MIPS: VPE: Exit vpe_release() early if vpe_run() isn't defined
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
 arch/mips/kernel/time.c              |   10 +++++++++-
 arch/mips/kernel/vpe.c               |    7 ++++++-
 arch/mips/oprofile/op_model_mipsxx.c |    8 +-------
 drivers/bus/mips_cdmm.c              |   14 +++++++++++++-
 drivers/tty/mips_ejtag_fdc.c         |    9 ++++++---
 15 files changed, 58 insertions(+), 42 deletions(-)
