Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Nov 2008 12:10:03 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:40838 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S23391432AbYKHMIw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Nov 2008 12:08:52 +0000
Received: (qmail 14703 invoked from network); 8 Nov 2008 13:06:30 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 8 Nov 2008 13:06:30 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Florian Fainelli <florian@openwrt.org>,
	Bruno Randolf <bruno.randolf@4g-systems.biz>,
	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 3/3] Alchemy: allow boards to override default reset/poweroff functions.
Date:	Sat,  8 Nov 2008 13:08:50 +0100
Message-Id: <96acd0ad43befb07726bada5ff84ee252050a435.1226143942.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.3
In-Reply-To: <b66aea73a24b5eb990339845892f4a43ccd7efaa.1226143942.git.mano@roarinelk.homelinux.net>
References: <cover.1226143942.git.mano@roarinelk.homelinux.net>
 <0b1dcd4090411d59e2272ca94da0fb4f5a4bbceb.1226143942.git.mano@roarinelk.homelinux.net>
 <b66aea73a24b5eb990339845892f4a43ccd7efaa.1226143942.git.mano@roarinelk.homelinux.net>
In-Reply-To: <cover.1226143942.git.mano@roarinelk.homelinux.net>
References: <cover.1226143942.git.mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Not all boards may want to use the alchemy reset/poweroff functions;
set the defaults before calling board init code so boards can override
them if necessary.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/common/setup.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index cd94985..b533d91 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -51,6 +51,10 @@ void __init plat_mem_setup(void)
 	set_cpuspec();
 	sp = cur_cpu_spec[0];
 
+	_machine_restart = au1000_restart;
+	_machine_halt = au1000_halt;
+	pm_power_off = au1000_power_off;
+
 	board_setup();  /* board specific setup */
 
 	prid = read_c0_prid();
@@ -78,10 +82,6 @@ void __init plat_mem_setup(void)
 		/* Clear to obtain best system bus performance */
 		clear_c0_config(1 << 19); /* Clear Config[OD] */
 
-	_machine_restart = au1000_restart;
-	_machine_halt = au1000_halt;
-	pm_power_off = au1000_power_off;
-
 	/* IO/MEM resources. */
 	set_io_port_base(0);
 	ioport_resource.start = IOPORT_RESOURCE_START;
-- 
1.6.0.3
