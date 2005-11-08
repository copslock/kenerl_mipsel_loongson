Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2005 17:49:54 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.199]:50803 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8135892AbVKHRta (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Nov 2005 17:49:30 +0000
Received: by nproxy.gmail.com with SMTP id l36so201507nfa
        for <linux-mips@linux-mips.org>; Tue, 08 Nov 2005 09:50:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=NZJ8dU6Sbh5fBCi0Z8gSwu6ALdlpJeI+6W5HXLX8/M1E0wDFRTMYN8EdRD0Eh6n8k7xJwnNkMPPIXrN14zC8XDwjZIOQO7KvUmdYpVXMnTVa51j8eTDvmgC0ZcdJYKKCwp3k+kV3N2DLKNXChL6MJ2nsNroe2DbKsFr4DQh6qx4=
Received: by 10.48.229.12 with SMTP id b12mr1906742nfh;
        Tue, 08 Nov 2005 09:50:49 -0800 (PST)
Received: from gmail.com ( [217.10.38.130])
        by mx.gmail.com with ESMTP id c28sm291831nfb.2005.11.08.09.50.47;
        Tue, 08 Nov 2005 09:50:49 -0800 (PST)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Tue,  8 Nov 2005 21:04:15 +0300 (MSK)
Date:	Tue, 8 Nov 2005 21:04:13 +0300
From:	Alexey Dobriyan <adobriyan@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Domen Puncer <domen@coderock.org>, linux-mips@linux-mips.org,
	Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Remove arch/mips/pmc-sierra/yosemite/ht-irq.c
Message-ID: <20051108180413.GG7631@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Return-Path: <adobriyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adobriyan@gmail.com
Precedence: bulk
X-list: linux-mips

From: Domen Puncer <domen@coderock.org>

Remove nowhere referenced file ("grep ht-irq -r ." didn't find anything).

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Index: linux-kj/arch/mips/pmc-sierra/yosemite/ht-irq.c
===================================================================
--- linux-kj.orig/arch/mips/pmc-sierra/yosemite/ht-irq.c	2005-11-08 20:46:25.000000000 +0300
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,52 +0,0 @@
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
