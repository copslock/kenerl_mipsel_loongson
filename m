Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 20:55:12 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.197]:16827 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8225196AbVINTyq>;
	Wed, 14 Sep 2005 20:54:46 +0100
Received: by zproxy.gmail.com with SMTP id v1so19804nzb
        for <linux-mips@linux-mips.org>; Wed, 14 Sep 2005 12:54:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=O0vkB9E6MafExzywIoEW6oI9BlGunFOj+Ux77zfFSASTikfd5uqJDbaKkcuzdz3voiuNkcpiyyBxmv+neQBGjrxO1/tMLL6rCCWQaxB5LEdi+zjyTgk/BTlketSZwI8uLJOcANBrXn5chNWjNgFfCzCVCUJz119OT50IkBrI2VY=
Received: by 10.36.41.6 with SMTP id o6mr438148nzo;
        Wed, 14 Sep 2005 12:54:33 -0700 (PDT)
Received: from gmail.com ( [217.10.38.130])
        by mx.gmail.com with ESMTP id 6sm154505nzn.2005.09.14.12.54.26;
        Wed, 14 Sep 2005 12:54:31 -0700 (PDT)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Thu, 15 Sep 2005 00:04:49 +0400 (MSD)
Date:	Thu, 15 Sep 2005 00:04:43 +0400
From:	Alexey Dobriyan <adobriyan@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Domen Puncer <domen@coderock.org>
Subject: [PATCH] Remove arch/mips/pmc-sierra/yosemite/ht-irq.c
Message-ID: <20050914200442.GI19491@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Return-Path: <adobriyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adobriyan@gmail.com
Precedence: bulk
X-list: linux-mips

From: Domen Puncer <domen@coderock.org>

Remove nowhere referenced file (grep ht-irq -r . didn't find anything).

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/mips/pmc-sierra/yosemite/ht-irq.c |   53 ---------------------------------
 1 files changed, 53 deletions(-)

--- a/arch/mips/pmc-sierra/yosemite/ht-irq.c	2005-09-14 19:05:25.000000000 +0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,53 +0,0 @@
-/*
- * Copyright 2003 PMC-Sierra
- * Author: Manish Lachwani (lachwani@pmc-sierra.com)
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/version.h>
-#include <linux/init.h>
-#include <asm/pci.h>
-
-/*
- * HT Bus fixup for the Titan
- * XXX IRQ values need to change based on the board layout
- */
-void __init titan_ht_pcibios_fixup_bus(struct pci_bus *bus)
-{
-        struct pci_bus *current_bus = bus;
-        struct pci_dev *devices;
-        struct list_head *devices_link;
-
-	list_for_each(devices_link, &(current_bus->devices)) {
-                devices = pci_dev_b(devices_link);
-                if (devices == NULL)
-                        continue;
-	}
-
-	/*
-	 * PLX and SPKT related changes go here
-	 */
-
-}
