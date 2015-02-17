Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Feb 2015 03:09:35 +0100 (CET)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:46252 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013016AbbBQCJeRd35c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Feb 2015 03:09:34 +0100
Received: by pabkx10 with SMTP id kx10so2557571pab.13
        for <linux-mips@linux-mips.org>; Mon, 16 Feb 2015 18:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=KlHsbx+9Mh4uPZ2h0m+x0nBsjYrX06qixo3486Aa/CA=;
        b=cA7cEN1j8Y/Fj1pSr54niFxeuddLUIpmVS1qrb3s6GXhlRiyD+ApvtKYVeU3TsxFJF
         JQeSc3CvPwEtHZG1lFZaxOKIuLoYGOg1uozP+HAWINoTOKqhXo+uQcAH8hh8yj6/uj88
         duhKKwu7T6+rHVITzfJZFtxsQzXa6XNcLS2Lp0kBaUvnHUWW25rMXdOyHwu4ex75Ar0g
         ghQEML1uXAfzLalSG/NVXb858JkEpvWu/Vb5zc9qg+5ZbMa0CuDB6PV92UGq4P9y0faA
         +3g9r/XuUKJGDTFDoDMb1G85n99tJWiOgBz/aRgqnkIzPayY5oMttMkPCUicgdfn2lxW
         bSEA==
X-Received: by 10.68.172.98 with SMTP id bb2mr44571914pbc.156.1424138967879;
        Mon, 16 Feb 2015 18:09:27 -0800 (PST)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id cq5sm13624562pbc.79.2015.02.16.18.09.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Feb 2015 18:09:26 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mpm@selenic.com, herbert@gondor.apana.org.au, wsa@the-dreams.de,
        cernekee@gmail.com, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/4] hw_random: bcm63xx-rng: misc cleanups and reorg
Date:   Mon, 16 Feb 2015 18:09:12 -0800
Message-Id: <1424138956-11563-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45834
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

This patchset prepares the driver to be built on non-MIPS bcm63xx architectures
such as the ARM bcm63xx variants, thanks!

Although patch 3 touches a MIPS header file, there should be little to no
conflicts there if all patches went through the hw_random tree (is there one?)

Thanks!

Florian Fainelli (4):
  hw_random: bcm63xx-rng: drop bcm_{readl,writel} macros
  hw_random: bcm63xx-rng: move register definitions to driver
  MIPS: BCM63xx: remove RSET_RNG register definitions
  hw_random: bcm63xx-rng: use devm_* helpers

 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h | 14 --------
 drivers/char/hw_random/bcm63xx-rng.c              | 43 +++++++++++------------
 2 files changed, 21 insertions(+), 36 deletions(-)

-- 
2.1.0
