Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Dec 2006 12:04:02 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:4113 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S28582465AbWLTMCA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Dec 2006 12:02:00 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 85CB4FE2C0;
	Wed, 20 Dec 2006 13:01:50 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ibb28xyd8BhJ; Wed, 20 Dec 2006 13:01:49 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id BC100FE2B5;
	Wed, 20 Dec 2006 13:01:49 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id kBKC1w7K010567;
	Wed, 20 Dec 2006 13:01:58 +0100
Date:	Wed, 20 Dec 2006 12:01:55 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 2.6.20-rc1 05/10] if_fddi.h: Add a missing inclusion
Message-ID: <Pine.LNX.4.64N.0612201113410.11005@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.7/2360/Wed Dec 20 07:24:09 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 This is a change to include <linux/netdevice.h> in <linux/if_fddi.h> 
which is needed for "struct fddi_statistics".

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-if_fddi-netdev-0
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/include/linux/if_fddi.h linux-mips-2.6.18-20060920/include/linux/if_fddi.h
--- linux-mips-2.6.18-20060920.macro/include/linux/if_fddi.h	2006-09-20 20:51:20.000000000 +0000
+++ linux-mips-2.6.18-20060920/include/linux/if_fddi.h	2006-12-14 04:36:58.000000000 +0000
@@ -103,6 +103,8 @@ struct fddihdr
 	} __attribute__ ((packed));
 
 #ifdef __KERNEL__
+#include <linux/netdevice.h>
+
 /* Define FDDI statistics structure */
 struct fddi_statistics {
 
