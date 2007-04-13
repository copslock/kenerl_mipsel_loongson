Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2007 18:33:05 +0100 (BST)
Received: from 70-89-178-179-BusName-Oregon.hfc.comcastbusiness.net ([70.89.178.179]:49832
	"EHLO hawaii.site") by ftp.linux-mips.org with ESMTP
	id S20022015AbXDMRdE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Apr 2007 18:33:04 +0100
Received: by hawaii.site (Postfix, from userid 500)
	id E32245484C9; Fri, 13 Apr 2007 10:32:25 -0700 (PDT)
Date:	Fri, 13 Apr 2007 10:32:25 -0700
From:	Mark Mason <mmason@upwardaccess.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Add missing silicon revisions for BCM112x
Message-ID: <20070413173225.GA4207@upwardaccess.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <mmason@upwardaccess.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mmason@upwardaccess.com
Precedence: bulk
X-list: linux-mips


Recent versions of the BCM112X processors aren't recognized by Linux
(preventing Linux from booting on those processors).  This patch adds
support for those that are missing.

Signed-off-by: Mark Mason <mason@broadcom.com>
---
 arch/mips/sibyte/sb1250/setup.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/mips/sibyte/sb1250/setup.c b/arch/mips/sibyte/sb1250/setup.c
index 87188f0..f4a6169 100644
--- a/arch/mips/sibyte/sb1250/setup.c
+++ b/arch/mips/sibyte/sb1250/setup.c
@@ -141,6 +141,18 @@ static int __init setup_bcm112x(void)
 		periph_rev = 3;
 		pass_str = "A2";
 		break;
+	case K_SYS_REVISION_BCM112x_A3:
+		periph_rev = 3;
+		pass_str = "A3";
+		break;
+	case K_SYS_REVISION_BCM112x_A4:
+		periph_rev = 3;
+		pass_str = "A4";
+		break;
+	case K_SYS_REVISION_BCM112x_B0:
+		periph_rev = 3;
+		pass_str = "B0";
+		break;
 	default:
 		printk("Unknown %s rev %x\n", soc_str, soc_pass);
 		ret = 1;
-- 
1.1.6.g9c88
