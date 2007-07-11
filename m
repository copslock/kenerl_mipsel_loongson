Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 21:21:57 +0100 (BST)
Received: from nic.NetDirect.CA ([216.16.235.2]:31630 "EHLO
	rubicon.netdirect.ca") by ftp.linux-mips.org with ESMTP
	id S20021815AbXGKUVy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 21:21:54 +0100
X-Originating-Ip: 72.143.66.27
Received: from [192.168.1.102] (CPE0018396a01fc-CM001225dbafb6.cpe.net.cable.rogers.com [72.143.66.27])
	(authenticated bits=0)
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id l6BKLUUi002222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jul 2007 16:21:47 -0400
Date:	Wed, 11 Jul 2007 16:19:46 -0400 (EDT)
From:	"Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To:	linux-mips@linux-mips.org
cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS:  Remove reference to obsolete HYDROGEN3.
Message-ID: <Pine.LNX.4.64.0707111617480.17440@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck:	not spam, SpamAssassin (not cached,
	score=-36.723, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, INIT_RECVD_OUR_AUTH -20.00, TW_GP 0.08)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Return-Path: <rpjday@mindspring.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@mindspring.com
Precedence: bulk
X-list: linux-mips


Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

diff --git a/arch/mips/au1000/common/setup.c b/arch/mips/au1000/common/setup.c
index 13fe187..fdf2b85 100644
--- a/arch/mips/au1000/common/setup.c
+++ b/arch/mips/au1000/common/setup.c
@@ -100,9 +100,6 @@ void __init plat_mem_setup(void)
         argptr = prom_getcmdline();
         /* default panel */
         /*strcat(argptr, " video=au1100fb:panel:Sharp_320x240_16");*/
-#ifdef CONFIG_MIPS_HYDROGEN3
-         strcat(argptr, " video=au1100fb:panel:Hydrogen_3_NEC_panel_320x240,nohwcursor");
-#endif
     }
 #endif

-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://fsdev.net/wiki/index.php?title=Main_Page
========================================================================
