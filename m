Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 21:56:09 +0100 (CET)
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34859 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011766AbcBIU4IBAgSb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 21:56:08 +0100
Received: by mail-pf0-f171.google.com with SMTP id c10so66654714pfc.2;
        Tue, 09 Feb 2016 12:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9du2nxUDZkIH9Ushc8LzVTkG87i52mSCDfcqK2NO664=;
        b=0YKTalr9DOLm4KPu95ZmwdWYSS89shpeDoR/IEswoVzPEbz6HAUHcgiXeCswqZqnOJ
         NZArt1k3tzZrjGonlnXCte7Bw/TBaLYXRBlJIvvRfefAHDIIjyzlh2PFjmDeuoBPruOj
         oA0ual+2SCVFeB2a0yUET+A7QYxusjKP8dcmFinan3yfK7R+fk1HL9ysQ8v9nyHx5zh5
         R+hx4LE4E86VkcR5UrJpIqrNVlasA9YXOYpl+5XV+tbF97wNBwv76K2hXtim8dPn2KOV
         YvA9/JXY4/H160qnOW1lSQF6jxWYarfUwaQ/ZQAgx0yTiNuPo6lwY2tvdPSOng48ivA+
         TxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9du2nxUDZkIH9Ushc8LzVTkG87i52mSCDfcqK2NO664=;
        b=Rpl9jRFIBlUrIeeMatm/BL1hmhvbxyBU19O9UaffRR1TnpgvmZoebL19SEt0wd4BdD
         0CZdtBoJpB5HVoK78aW9EyREJsiY3ZamFhF3ICndY9w/6KNRtajjJVju5+kWM6Ivs7f8
         XkxP7iGwxQMCdnehX1//z7LqvrU5eaTICVude9HvDaIWWpmdCmTqxeJBmlhLG4S52HbN
         JzxDcL92vOeA5q2HuuZGdQU8PI1+hm3vVRBxz8cMZh3Ht8vx4byOHsgCDbrxsMF+GPFK
         CM8UkxAKe2fcx6UCXGN3097uKFvp0M8ZO7cJPwgG8uJE5rb62N/yYupf9Nuc9FNpA7AO
         gfyw==
X-Gm-Message-State: AG10YOTdwGLLHXEL1f4Uix2djQsqyRvvhok8mBv5sRu9LBp5sLdw9tObw6tR3lCxREQG5g==
X-Received: by 10.98.0.135 with SMTP id 129mr53219211pfa.156.1455051361970;
        Tue, 09 Feb 2016 12:56:01 -0800 (PST)
Received: from stb-bld-03.irv.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id n4sm52684059pfi.3.2016.02.09.12.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 12:56:01 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, pgynther@google.com,
        paul.burton@imgtec.com, ddaney.cavm@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/6] MIPS: BMIPS: RIXI and workarounds support
Date:   Tue,  9 Feb 2016 12:55:48 -0800
Message-Id: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Hi all,

This patch series contains some workarounds for some bug with pref30 on
Broadcom BMIPS5000 CPUs in 7344, 7346 and 7425 chips, and some other changes
to allow the use of RIXI/rotr on BMIPS4380 and BMIPS5000.

Finally, the last patch adds a debugfs entry for current_cpu_data.options since
it might be useful to debug that at a time where we set on the final CPU
options.

This is on top of mips-for-linux-next as of
a13d2abd8e617a96d235c0a528a742b347650853 ("MIPS: highmem: Turn
flush_cache_kmaps into a no-op.")

Thanks!

Florian Fainelli (6):
  MIPS: BMIPS: Disable pref 30 for buggy CPUs
  MIPS: BMIPS: Add early CPU initialization code
  MIPS: Allow RIXI to be used on non-R2 or R6 cores
  MIPS: Move RIXI exception enabling after vendor-specific cpu_probe
  MIPS: BMIPS: BMIPS4380 and BMIPS5000 support RIXI
  MIPS: Expose current_cpu_data.options through debugfs

 arch/mips/Kconfig                    |  7 +++
 arch/mips/bmips/setup.c              | 17 +++++++
 arch/mips/include/asm/bmips.h        |  1 +
 arch/mips/include/asm/pgtable-bits.h | 11 ++---
 arch/mips/kernel/cpu-probe.c         | 41 ++++++++++++-----
 arch/mips/kernel/smp-bmips.c         | 87 ++++++++++++++++++++++++++++++++++++
 arch/mips/mm/tlbex.c                 |  2 +-
 7 files changed, 150 insertions(+), 16 deletions(-)

-- 
2.1.0
