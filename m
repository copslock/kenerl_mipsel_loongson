Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2007 17:44:13 +0100 (BST)
Received: from astra.telenet-ops.be ([195.130.132.58]:35732 "EHLO
	astra.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20022989AbXGTQoL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jul 2007 17:44:11 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by astra.telenet-ops.be (Postfix) with SMTP id C31AA380FD;
	Fri, 20 Jul 2007 18:44:10 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by astra.telenet-ops.be (Postfix) with ESMTP id 62EF2380EE;
	Fri, 20 Jul 2007 18:44:10 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-7) with ESMTP id l6KGiA9b020066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 20 Jul 2007 18:44:10 +0200
Received: (from geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) id l6KGi9cr020065;
	Fri, 20 Jul 2007 18:44:09 +0200
Message-Id: <20070720164324.097994947@mail.of.borg>
References: <20070720164043.523003359@mail.of.borg>
User-Agent: quilt/0.46-1
Date:	Fri, 20 Jul 2007 18:40:46 +0200
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org
Subject: [patch 3/3] scsi: wd33c93 needs <asm/irq.h>
Content-Disposition: inline; filename=m68k-wd33c93-needs-asm-irq.diff
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

wd33c93 SCSI needs <asm/irq.h> on m68k

drivers/scsi/wd33c93.c: In function 'wd33c93_host_reset':
drivers/scsi/wd33c93.c:1582: error: implicit declaration of function 'disable_irq'
drivers/scsi/wd33c93.c:1603: error: implicit declaration of function 'enable_irq'

The driver still compiles on MIPS (CONFIG_SGIWD93_SCSI=y)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/scsi/wd33c93.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/wd33c93.c
+++ b/drivers/scsi/wd33c93.c
@@ -89,6 +89,8 @@
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
 
+#include <asm/irq.h>
+
 #include "wd33c93.h"
 
 #define optimum_sx_per(hostdata) (hostdata)->sx_table[1].period_ns

-- 
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
