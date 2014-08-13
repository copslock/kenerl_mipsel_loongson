Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2014 00:09:33 +0200 (CEST)
Received: from mail-la0-f44.google.com ([209.85.215.44]:42865 "EHLO
        mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6878444AbaHMWJQhiwHz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Aug 2014 00:09:16 +0200
Received: by mail-la0-f44.google.com with SMTP id el20so318986lab.17
        for <multiple recipients>; Wed, 13 Aug 2014 15:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rqayCjm9GvPbcaLZc6OHFDaOQfezNztQ+hDFhmQ9E5g=;
        b=cRI4hfvzRBf5rWriPXq4hiMVBOi9WpVOBmvfcQiZzw4yBPkFjeyMwtXoiSowiykIcJ
         ayXVHWSpjajCgWzdCgq2jwk3qHU7umBFzYc4tWL0qXGE9y0nkQYfZg+f/cnL8xJjr06p
         9hGROliEa67+4eLHHeXwUioSunzkm58ZPoYQrk4fNYMfqIGTGhO8/Mc5DtExhtuZU2Pt
         yeEax5g/1Qik7qp8ParO2fOIDmeCgCb/LeUGYvIySFXY1Q6DsgrnMDu6st2v1KF9Hia/
         P6+Q2vCdAOBtxjl9/dWHNNJyS2wd3gJp5IWLDH26W0oFuHkdTPjOtEahAGRsuKnQYPBe
         9DhA==
X-Received: by 10.152.45.8 with SMTP id i8mr738217lam.3.1407967747432;
        Wed, 13 Aug 2014 15:09:07 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id x10sm1927137lal.13.2014.08.13.15.09.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Aug 2014 15:09:06 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 0/2] MIPS: add common plat_irq_dispatch declaration
Date:   Thu, 14 Aug 2014 02:09:34 +0400
Message-Id: <1407967776-7320-1-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

This short series get rid of one nasty sparse warning "symbol
'plat_irq_dispatch' was not declared. Should it be static?"

Compile tested with following configs:
  ar7_defconfig
  ath79_defconfig
  bcm47xx_defconfig
  bcm63xx_defconfig
  bigsur_defconfig
  capcella_defconfig
  cavium_octeon_defconfig
  cobalt_defconfig
  db1xxx_defconfig
  decstation_defconfig
  e55_defconfig
  fuloong2e_defconfig
  gpr_defconfig
  ip22_defconfig
  ip27_defconfig
  ip32_defconfig
  jazz_defconfig
  jmr3927_defconfig
  lasat_defconfig
  lemote2f_defconfig
  loongson3_defconfig
  ls1b_defconfig
  maltaaprp_defconfig
  malta_defconfig
  malta_kvm_defconfig
  malta_kvm_guest_defconfig
  maltasmvp_defconfig
  maltaup_defconfig
  markeins_defconfig
  mips_paravirt_defconfig
  mpc30x_defconfig
  msp71xx_defconfig
  mtx1_defconfig
  pnx8335_stb225_defconfig
  qi_lb60_defconfig
  rb532_defconfig
  rbtx49xx_defconfig
  rm200_defconfig
  rt305x_defconfig
  sb1250_swarm_defconfig
  sead3_defconfig
  sead3micro_defconfig
  tb0219_defconfig
  tb0226_defconfig
  tb0287_defconfig
  workpad_defconfig
  xway_defconfig

Could not test following configs since compiller lacks and some macro redefinitions:
  ip28_defconfig
  maltasmvp_eva_defconfig
  nlm_xlp_defconfig
  nlm_xlr_defconfig

Sergey Ryazanov (2):
  MIPS: MSP71xx: remove unused plat_irq_dispatch() argument
  MIPS: add common plat_irq_dispatch declaration

 arch/mips/cavium-octeon/setup.c  | 1 -
 arch/mips/include/asm/irq.h      | 2 ++
 arch/mips/pmcs-msp71xx/msp_irq.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

-- 
1.8.1.5
