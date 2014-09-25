Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2014 03:33:24 +0200 (CEST)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:34809 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009242AbaIYBdWMGfo9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2014 03:33:22 +0200
X-IronPort-AV: E=Sophos;i="5.04,593,1406617200"; 
   d="scan'208";a="46534366"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw3-out.broadcom.com with ESMTP; 24 Sep 2014 18:34:19 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Wed, 24 Sep 2014 18:33:14 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Wed, 24 Sep 2014 18:33:15 -0700
Received: from jayachandranc.netlogicmicro.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 40EDD41015;    Wed, 24 Sep 2014 18:33:10 -0700 (PDT)
Date:   Thu, 25 Sep 2014 06:55:15 +0530
From:   Jayachandran C. <jchandra@broadcom.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     <linux-mips@linux-mips.org>, <ganesanr@broadcom.com>
Subject: Re: [PATCH 0/2] MIPS: Netlogic: modular build fixes
Message-ID: <20140925012514.GA3703@jayachandranc.netlogicmicro.com>
References: <1411581311-6458-1-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1411581311-6458-1-git-send-email-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

On Wed, Sep 24, 2014 at 10:55:09AM -0700, Florian Fainelli wrote:
> Hello Ralf, Jayachandran, Ganesan
> 
> Here are two small fixes for modular USB and AHCI builds that I encountered
> while playing with a FVP board.
> 
> These are based off upstream-sfr/mips-for-linux-next

We have a slightly different fix for this in our internal repository, I
was planning to submit it soon:


index be358a8..5c876d3 100644
--- a/arch/mips/netlogic/xlp/Makefile
+++ b/arch/mips/netlogic/xlp/Makefile
@@ -1,6 +1,6 @@
 obj-y				+= setup.o nlm_hal.o cop2-ex.o dt.o
 obj-$(CONFIG_SMP)		+= wakeup.o
-obj-$(CONFIG_USB)		+= usb-init.o
-obj-$(CONFIG_USB)		+= usb-init-xlp2.o
-obj-$(CONFIG_SATA_AHCI)		+= ahci-init.o
-obj-$(CONFIG_SATA_AHCI)		+= ahci-init-xlp2.o
+obj-$(subst m,y,$(CONFIG_USB))	+= usb-init.o
+obj-$(subst m,y,$(CONFIG_USB))	+= usb-init-xlp2.o
+obj-$(subst m,y,$(CONFIG_SATA_AHCI))	+= ahci-init.o
+obj-$(subst m,y,$(CONFIG_SATA_AHCI))	+= ahci-init-xlp2.o

This will add the init code when USB or SATA is enabled as module or
is built-in, so I think this is be a better solution.

JC.
