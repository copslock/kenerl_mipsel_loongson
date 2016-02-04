Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 03:15:04 +0100 (CET)
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35503 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012433AbcBDCPDKkl0x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 03:15:03 +0100
Received: by mail-pf0-f170.google.com with SMTP id 65so26902810pfd.2;
        Wed, 03 Feb 2016 18:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cln4+EQAU7wftDh+P0PRYZNePXLcyke9mixiFFwhzbg=;
        b=HKKUEyXau4RqpqnWv4gdS+5WiodZ3LUaJKEv8VGjYT5Ni65Y7dzU2KEEDQeFSSb2qf
         EIWIta+1wrrUDGfM0b7oIhKLmdzusO5RxXExC1OiDDVvfHBZbEw4a3LMaOOzLSGz3dF3
         PBFBbcxxJid0FxAwgOxa5t2fvaUEeYZtxYfjxufU78HZjv/3X1PoonyEBcI3YnmlJGBK
         Z6QAsgjxis4dpeYfXLSYNx8//taqZzyvNIsOEq+ItVCsX0DSQJ5Y0oU87iGGSVKOcRjE
         2pyvXkB/0kB+OKPgjG0KG91ux3dqBSeIrarSwjEqSgwB43kPceuAQysHA75YzXtRvBoj
         DezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cln4+EQAU7wftDh+P0PRYZNePXLcyke9mixiFFwhzbg=;
        b=MO5Was3Gum1WDdTbFWp9GXXatH5BEZ4coNzbxHgji4TpMChZtd38Gx3Grej7rx9Ji2
         zcpk1v+JabhbjI/dMSPZW88/rmminALY7SewCOjfg+gUpzOnUpAahtNhmTb5Ta9q2Z+Z
         eUMc7+/b1M9I+IVdLhGSMLfD018RVYh0Tr3luaBFxxoJ9Auw2MUDoP0EnH4wzmmmW5L4
         qhTIf2zBYW1O5dxCo+ZJegHZAcTEeoKclE3Vxht2WL+GAULZ1n9sHKtaGwlv2K5ZWkW+
         VWJL1KffsMa7zK2NlHrBBNU6f3xOlX/Vog0wTDxuEWux71DmPf9RJq6U4bnrSaD9jpvQ
         3kIQ==
X-Gm-Message-State: AG10YOQXrsR3RUMxXv0boSWBQ4HIAuhIKsuB1jNVuuk/89Dsetb72cAEwOoQhaR/SVDrFw==
X-Received: by 10.98.40.131 with SMTP id o125mr7335309pfo.83.1454552096526;
        Wed, 03 Feb 2016 18:14:56 -0800 (PST)
Received: from stb-bld-03.irv.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id l14sm12646282pfb.73.2016.02.03.18.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 18:14:55 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, jaedon.shin@gmail.com,
        dragan.stancevic@gmail.com, jogo@openwrt.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/4] MIPS: BMIPS5200 SMP support
Date:   Wed,  3 Feb 2016 18:14:49 -0800
Message-Id: <1454552093-17897-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51712
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

This patch series adds BCM7435/BMIPS52000 SMP support, it builds
on top of the series submitted here:

https://www.linux-mips.org/archives/linux-mips/2016-01/msg00737.html

Florian Fainelli (4):
  MIPS: BMIPS: Add Whirlwind (BMIPS5200) initialization code
  MIPS: BMIPS: Add missing 7038 L1 register cells to BCM7435
  MIPS: BMIPS: Remove maxcpus from BCM97435SVMB DTS
  MIPS: BMIPS: Fill in current_cpu_data.core

 arch/mips/boot/dts/brcm/bcm7435.dtsi     |   5 +-
 arch/mips/boot/dts/brcm/bcm97435svmb.dts |   2 +-
 arch/mips/kernel/Makefile                |   2 +-
 arch/mips/kernel/bmips_5xxx_init.S       | 753 +++++++++++++++++++++++++++++++
 arch/mips/kernel/bmips_vec.S             |  41 +-
 arch/mips/kernel/smp-bmips.c             |   1 +
 6 files changed, 797 insertions(+), 7 deletions(-)
 create mode 100644 arch/mips/kernel/bmips_5xxx_init.S

-- 
2.1.0
