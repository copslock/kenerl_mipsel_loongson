Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:36:40 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:55567 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133820AbWCTEbL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 04:31:11 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 624C864D3D; Mon, 20 Mar 2006 04:40:48 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 210CB66ED5; Mon, 20 Mar 2006 04:40:17 +0000 (GMT)
Date:	Mon, 20 Mar 2006 04:40:17 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	akpm@osdl.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org
Subject: [PATCH 7/12] [IDE] Set CFLAGS only for au1xxx-ide
Message-ID: <20060320044017.GG20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320043802.GA20389@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Set CFLAGS only for au1xxx-ide since swarm does not reference any
include files from drivers/ide.  This brings drivers/ide/mips/Makefile
in sync with the linux-mips tree.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- linux-2.6/drivers/ide/mips/Makefile	2006-03-05 19:35:03.000000000 +0000
+++ mips.git/drivers/ide/mips/Makefile	2006-03-05 18:51:15.000000000 +0000
@@ -1,4 +1,4 @@
 obj-$(CONFIG_BLK_DEV_IDE_SWARM)		+= swarm.o
 obj-$(CONFIG_BLK_DEV_IDE_AU1XXX)	+= au1xxx-ide.o
 
-EXTRA_CFLAGS    := -Idrivers/ide
+CFLAGS_au1xxx-ide.o := -Idrivers/ide

-- 
Martin Michlmayr
http://www.cyrius.com/
