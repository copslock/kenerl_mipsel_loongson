Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jul 2005 20:34:49 +0100 (BST)
Received: from ns1.suse.de ([IPv6:::ffff:195.135.220.2]:56722 "EHLO
	mx1.suse.de") by linux-mips.org with ESMTP id <S8226431AbVGJTe2>;
	Sun, 10 Jul 2005 20:34:28 +0100
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 0BFBFEDFA;
	Sun, 10 Jul 2005 21:35:13 +0200 (CEST)
Date:	Sun, 10 Jul 2005 19:35:12 +0000
From:	Olaf Hering <olh@suse.de>
To:	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 4/82] remove linux/version.h include from arch/mips
Message-ID:  <20050710193512.4.TqwKKi2359.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS:	I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Return-Path: <olh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: olh@suse.de
Precedence: bulk
X-list: linux-mips


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

Signed-off-by: Olaf Hering <olh@suse.de>

arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.h |    1 -
arch/mips/pmc-sierra/yosemite/ht-irq.c            |    1 -
arch/mips/pmc-sierra/yosemite/ht.c                |    1 -
3 files changed, 3 deletions(-)

Index: linux-2.6.13-rc2-mm1/arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.h
+++ linux-2.6.13-rc2-mm1/arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.h
@@ -34,7 +34,6 @@
#include <linux/pci.h>
#include <linux/kernel.h>
#include <linux/slab.h>
-#include <linux/version.h>
#include <asm/pci.h>
#include <asm/io.h>
#include <linux/init.h>
Index: linux-2.6.13-rc2-mm1/arch/mips/pmc-sierra/yosemite/ht-irq.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/mips/pmc-sierra/yosemite/ht-irq.c
+++ linux-2.6.13-rc2-mm1/arch/mips/pmc-sierra/yosemite/ht-irq.c
@@ -26,7 +26,6 @@
#include <linux/types.h>
#include <linux/pci.h>
#include <linux/kernel.h>
-#include <linux/version.h>
#include <linux/init.h>
#include <asm/pci.h>

Index: linux-2.6.13-rc2-mm1/arch/mips/pmc-sierra/yosemite/ht.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/mips/pmc-sierra/yosemite/ht.c
+++ linux-2.6.13-rc2-mm1/arch/mips/pmc-sierra/yosemite/ht.c
@@ -28,7 +28,6 @@
#include <linux/pci.h>
#include <linux/kernel.h>
#include <linux/slab.h>
-#include <linux/version.h>
#include <asm/pci.h>
#include <asm/io.h>
