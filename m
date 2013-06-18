Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 21:14:07 +0200 (CEST)
Received: from mail-pb0-f42.google.com ([209.85.160.42]:32962 "EHLO
        mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827468Ab3FRTNLuc8zR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jun 2013 21:13:11 +0200
Received: by mail-pb0-f42.google.com with SMTP id un1so4221681pbc.1
        for <multiple recipients>; Tue, 18 Jun 2013 12:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lvOm7UZcQGjX2V7f/bd29nGblcURxNGU+cvKOgDGch8=;
        b=q78QU9fTuCS1Fv+YrdiE3itxN6QH2BQNjMpHZHKVnnrR2X5DoztW1PQfc7jYWXbxGH
         WZOlvzCuBzdhsfRhZvcCq78Nc/1FvDg+kk/Q0qoLtBeoi1nhrWDxQw+ppEF5kAeQDQfO
         eZH/vt/yl5LTRt0pcpWqKQFE9/nqqhYkcn5avjvLIs52CkZPEDBdK/da6Dl3e/LOn8W+
         1mpYBVeCLjDWktE3Dq8ZTkaiVSrbJgP181bH5BDRlf0VQmgBUoyMJOil5SjIGt3wMrm+
         j1pciv0ofQKtqqwTNGUA5S8LBkSy7ZCqb7EdOuX+1SRV3urrxUa5voubuPE9M2J53aHp
         j7ZA==
X-Received: by 10.66.228.34 with SMTP id sf2mr3369757pac.134.1371582784916;
        Tue, 18 Jun 2013 12:13:04 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id v7sm19457209pbq.32.2013.06.18.12.13.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 12:13:03 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5IJD1Gj012183;
        Tue, 18 Jun 2013 12:13:01 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5IJD1uM012182;
        Tue, 18 Jun 2013 12:13:01 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Jamie Iles <jamie@jamieiles.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 1/5] Revert "MIPS: Octeon: Fix build error if CONFIG_SERIAL_8250=n"
Date:   Tue, 18 Jun 2013 12:12:51 -0700
Message-Id: <1371582775-12141-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36991
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

From: David Daney <david.daney@cavium.com>

This reverts commit fc0fcde2ea9740944acf6134d2c84983d1297bc1.
---
 arch/mips/cavium-octeon/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 643809f..e3fd50c 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -12,13 +12,12 @@
 CFLAGS_octeon-platform.o = -I$(src)/../../../scripts/dtc/libfdt
 CFLAGS_setup.o = -I$(src)/../../../scripts/dtc/libfdt
 
-obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o
+obj-y := cpu.o setup.o serial.o octeon-platform.o octeon-irq.o csrc-octeon.o
 obj-y += dma-octeon.o
 obj-y += octeon-memcpy.o
 obj-y += executive/
 
 obj-$(CONFIG_MTD)		      += flash_setup.o
-obj-$(CONFIG_SERIAL_8250)	      += serial.o
 obj-$(CONFIG_SMP)		      += smp.o
 obj-$(CONFIG_OCTEON_ILM)	      += oct_ilm.o
 
-- 
1.7.11.7
