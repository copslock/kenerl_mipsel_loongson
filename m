Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Aug 2012 01:56:22 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:60918 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903551Ab2HQXzu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Aug 2012 01:55:50 +0200
Received: by pbbrq8 with SMTP id rq8so4323319pbb.36
        for <multiple recipients>; Fri, 17 Aug 2012 16:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=yR2IE6lhxP8aP0BbpaFTi3OaIHa+JvS2bYjFrdanyDU=;
        b=SdWDVXd7fiVnzIIQNYWILGr7/22Tig+bHvge3y4uj30CZ4WRDJ169XIeNH1007G+gS
         78zjUzHyILtn/6OD4NzByM/XugqvPXjTXhkbACi/M1rpe5HycFjsOf1GUUu4dE5E8Tet
         +bq0SuNrAUQMV/6HrRsptEC1xxsq3xB+Zpx6GPvyDiqlGyG6zZMvFYtnmIaz50cSQV12
         Okwy7xRVrz02qOt4FNFgEbx0Hcwigzp/SHHeTcZ/NErQx8AeK/PDp2PzQssyPRyeJgAK
         9s4dlQteYXmAdcADd8utMPv9Cet5Q2NiEyk4nLF5Ohz6wAvoWUQN0css3abA4yR8hY/N
         Zrgw==
Received: by 10.68.196.193 with SMTP id io1mr15752817pbc.17.1345247743222;
        Fri, 17 Aug 2012 16:55:43 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id kp3sm5831018pbc.64.2012.08.17.16.55.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 16:55:42 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id q7HNseHu025122;
        Fri, 17 Aug 2012 16:54:40 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id q7HNsa2c025120;
        Fri, 17 Aug 2012 16:54:36 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     ralf@linux-mips.org, linux-ide@vger.kernel.org,
        Jeff Garzik <jgarzik@pobox.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 0/2] ata: Updates for pata_octeon_cf driver.
Date:   Fri, 17 Aug 2012 16:54:31 -0700
Message-Id: <1345247673-25086-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.2
X-archive-position: 34270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

The main update is conversion to device tree.  Now the the OCTEON
device tree prerequisites are upstream, we can convert the
pata_octeon_cf driver.

The second change allows the driver to function when the kernel is
built for little-endian operation.

The only real change in the MIPS portion of the tree is deletion of
crap.

There is a dependence on patches Ralf has queued in linux-next so it
may be best to merge via the MIPS tree (as pata_octeon_cf only exists
in MIPS based OCTEON SOCs).  But the ata tree would be fine by me too.
In any even we may need some cross sub-system Acked-bys.

David Daney (2):
  MIPS/OCTEON/ata: Convert pata_octeon_cf.c to use device tree.
  ata: pata_octeon_cf: Use correct byte order for DMA in when built
    little-endian.

 arch/mips/cavium-octeon/octeon-irq.c           |   1 -
 arch/mips/cavium-octeon/octeon-platform.c      | 102 ------
 arch/mips/include/asm/mach-cavium-octeon/irq.h |   1 -
 arch/mips/include/asm/octeon/octeon.h          |   7 -
 drivers/ata/pata_octeon_cf.c                   | 423 +++++++++++++++++--------
 5 files changed, 288 insertions(+), 246 deletions(-)

-- 
1.7.11.2
