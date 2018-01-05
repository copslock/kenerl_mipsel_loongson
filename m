Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jan 2018 00:29:03 +0100 (CET)
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35717 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992956AbeAEXVDW-IEF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Jan 2018 00:21:03 +0100
Received: by mail-ot0-f195.google.com with SMTP id q5so5186855oth.2;
        Fri, 05 Jan 2018 15:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gPh36+LQhwL90gfCj7Ap+1ndjdTQNnzER8hqnXo0k8g=;
        b=hNIAj5iIHhOs3jaI9iuOqY5N4JrHdO7bsSmezHKvbLOUeBfBgW7smksmhvLFn8bqE7
         s2eDqMCkoP6/xuG+AOGqkTR/oT3uhkpGpcehk9pu5Fv+ry/P3K4tobyoU5ffkWeHJiuq
         5UWX5npiE9tSKdTgSHvqQM9cAi8AWujEyMPxT3HT6kHnUp0xo+8dEBl0qPvAIST8vNkS
         DwRj/OprnW2alZL7/A2W0rcrUN1qM6/JScTGmSE4Zsrp8kedqJ5Qi498Z0KBHTVhDIyc
         30260rsGUys6qqYbExr87WuEzMdJdbKk2LdJuNT/6OTJ0CFKr+2xB8nvAuyFIENc+PWR
         srCA==
X-Gm-Message-State: AKwxytcTB9JDEbfTEH02Ikeqw/fq/u6DdV3ElKQB0qV8t2k2US5LpsBo
        1VdxpPreMffOadeeJrTj5g==
X-Google-Smtp-Source: ACJfBotXDd3VPbyWOV5o4PgDAx0hvjDKS+UfcY94vmkh+xe0kcTBY0LabZmvaVsVSi6PQ7yf1keQ6Q==
X-Received: by 10.157.34.12 with SMTP id o12mr2833372ota.309.1515194457535;
        Fri, 05 Jan 2018 15:20:57 -0800 (PST)
Received: from xps15.usacommunications.tv (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.googlemail.com with ESMTPSA id u1sm1969998otc.3.2018.01.05.15.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2018 15:20:55 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        linux-cris-kernel@axis.com
Subject: [PATCH 0/7] DT: consolidate bootmem support
Date:   Fri,  5 Jan 2018 17:20:47 -0600
Message-Id: <20180105232054.27394-1-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

This series adds support for bootmem to the DT core code and removes the
remaining arch specific early_init_dt_alloc_memory_arch implementations.

Compile tested only on arm64, mips, x86, and xtensa.

Rob

Rob Herring (7):
  of/fdt: use memblock_virt_alloc for early alloc
  cris: remove arch specific early DT functions
  metag: remove arch specific early DT functions
  mips: remove arch specific early_init_dt_alloc_memory_arch
  nios2: remove arch specific early_init_dt_alloc_memory_arch
  x86: remove arch specific early_init_dt_alloc_memory_arch
  xtensa: remove arch specific early DT functions

 arch/cris/kernel/Makefile     | 19 -------------------
 arch/cris/kernel/devicetree.c | 15 ---------------
 arch/metag/kernel/devtree.c   | 14 --------------
 arch/mips/kernel/prom.c       |  5 -----
 arch/nios2/kernel/prom.c      |  5 -----
 arch/x86/kernel/devicetree.c  |  6 ------
 arch/xtensa/kernel/setup.c    | 12 ------------
 drivers/of/fdt.c              | 16 ++++------------
 drivers/of/unittest.c         | 11 ++++++++---
 include/linux/of_fdt.h        |  1 -
 10 files changed, 12 insertions(+), 92 deletions(-)
 delete mode 100644 arch/cris/kernel/devicetree.c

--
2.14.1
