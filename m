Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2017 20:22:32 +0100 (CET)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:40450
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993910AbdAaTTljyDqa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2017 20:19:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=armlinux.org.uk; s=pandora-2014;
        h=Date:Sender:Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:In-Reply-To; bh=CYRWAbMobk+JZXMuUgW+OscWJnwdrjSarop3sSNhJag=;
        b=PzTT5/TURqaAbXBAKG8chvW/jsIdFH4yu2V4zLdzWvSKwo+Dxk5nfrF+iKwzt4YgB+NS4P4D76hf8gynNGje0wbhH1jOTBeY6/KFDZaB1C2fbsEApJcXBTbw7TXUsOwVauVT/sdSwyPz/kYtckA6blRRaNFdDXCwWyQOoIK4b28=;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:48802 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1cYdxd-0000jy-Om; Tue, 31 Jan 2017 19:19:26 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1cYdxS-0000Wy-EM; Tue, 31 Jan 2017 19:19:14 +0000
In-Reply-To: <20170131191704.GA8281@n2100.armlinux.org.uk>
References: <20170131191704.GA8281@n2100.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     linux-mips@linux-mips.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.10-rc3 10/13] MIPS: Octeon: Remove unnecessary MODULE_*()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1cYdxS-0000Wy-EM@rmk-PC.armlinux.org.uk>
Date:   Tue, 31 Jan 2017 19:19:14 +0000
Return-Path: <rmk+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk+kernel@armlinux.org.uk
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

octeon-platform.c can not be built as a module for two reasons:

(a) the Makefile doesn't allow it:
    obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o

(b) the multiple *_initcall() statements, each of which are translated
    to a module_init() call when attempting a module build, become
    aliases to init_module().  Having more than one alias will cause a
    build error.

Hence, rather than adding a linux/module.h include, remove the redundant
MODULE_*() from this file.

Acked-by: David Daney <david.daney@cavium.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/mips/cavium-octeon/octeon-platform.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 37a932d9148c..8297ce714c5e 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -1060,7 +1060,3 @@ static int __init octeon_publish_devices(void)
 	return of_platform_bus_probe(NULL, octeon_ids, NULL);
 }
 arch_initcall(octeon_publish_devices);
-
-MODULE_AUTHOR("David Daney <ddaney@caviumnetworks.com>");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Platform driver for Octeon SOC");
-- 
2.7.4
