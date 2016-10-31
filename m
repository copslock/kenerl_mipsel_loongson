Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2016 22:17:07 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34692 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992544AbcJaVQ6oeXB0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2016 22:16:58 +0100
Received: by mail-pf0-f195.google.com with SMTP id y68so3793347pfb.1;
        Mon, 31 Oct 2016 14:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gdQHXG0VZ+kMPhyqzwWw45SJ+bRmTpUvIYjEsv3yYGw=;
        b=qAa7TrzKEZ3AEMZGxtjumU0z5Dql0Fii8elKdI7RhYzdyw9T/1IF/IYraNflo8isto
         K+ktFgwScxnTosayMIYsmB9fa1E3XP3KPucP/1BuVOSUKHYZe2Z75x54+Lffmqt1l4QC
         kpPyHvJs6B5YKDVv1CdEBh9D8bj/r+lGl4gbjKDH6Es6zo618AZ9TdHh0XsMbhtjVCHR
         tgMG7eMAa4dn1v6Feu9w/vG/45mR6AWAZhYspqJejluxuFSx7VeGTmFXfxBvXDCYxMCl
         //y7RAxXvpLuOthN+jKxEux74NtPwvuZx/nHiZAV8W8v1wU27MYIEnQlcfHvvzsk8Rfz
         IhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gdQHXG0VZ+kMPhyqzwWw45SJ+bRmTpUvIYjEsv3yYGw=;
        b=ifI2M6TotWsjxw8iRN3/A1HTXRJ07LnjE9ndUnQsPGfSCCIrWcFHWovk17758rqlET
         ge2QpVLX8fwha0Mqw/VOVmaTEcBcOuoJ/k0bR2anSVGMnK74Sjoo+XsjTDGW/MtYDfJI
         NpNONmHQX01yhnqkIsFStFa1aWFek5rC1cxDFmEHeq1D0PtxONiRFZsvmP5HFrjuj0gT
         wW/xQh9ugk6haMm2EXckuByLyaQO2ZUo4HalOyGN8YTN1HJVo30K6emcbm5SUTSPX1lV
         q3Uo/WtvlqRkvnRnhAbliLZSP/vBlYThnCSdyY8mdpcXEBKeiAXkXfDB+fI1ot/+7S7B
         lDag==
X-Gm-Message-State: ABUngveTjVVOkvYLzgPU0b2WctazqfFKDgKNCbHb8ovohPSw/4Jzs1GOjZQrOshVm9vTGQ==
X-Received: by 10.98.85.135 with SMTP id j129mr52670967pfb.28.1477948612794;
        Mon, 31 Oct 2016 14:16:52 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id a7sm37628013pan.34.2016.10.31.14.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Oct 2016 14:16:52 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jaedon.shin@gmail.com,
        justinpopo6@gmail.com, tglx@linuxtronix.de, marc.zyngier@arm.com,
        jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/2] MIPS: BMIPS: Fix interrupt affinity migration
Date:   Mon, 31 Oct 2016 14:16:45 -0700
Message-Id: <1477948607-12899-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55622
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

Hi,

These two patches are against Thomas' irq/core branch as of today:

4cd13c21b207e80ddb1144c576500098f2d5f882 ("softirq: Let ksoftirqd do its job")

Patches can be taken indepdently or together, your call.

Florian Fainelli (2):
  irqchip/bcm7038-l1: Implement irq_cpu_offline
  MIPS: BMIPS: Migrate interrupts during bmips_cpu_disable

 arch/mips/kernel/smp-bmips.c     |  2 ++
 drivers/irqchip/irq-bcm7038-l1.c | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.7.4
