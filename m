Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:31:12 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:43791 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133393AbWCTE2l (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 04:28:41 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 29D7064D3D; Mon, 20 Mar 2006 04:38:19 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 0A37266ED5; Mon, 20 Mar 2006 04:38:03 +0000 (GMT)
Date:	Mon, 20 Mar 2006 04:38:03 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	akpm@osdl.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Bring mainline in sync with the linux-mips tree
Message-ID: <20060320043802.GA20389@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

The following is a series of twelve patches to bring mainline in
sync with the linux-mips tree.  These are changes that have to be
made in mainline.  Another series has already been posted to
the linux-mips list to bring linux-mips in sync with Linus' tree
where necessary.

[PATCH 1/12] [MIPS] Improve description of VR41xx based machines
[PATCH 2/12] [MIPS] Cosmetic updates to sync with linux-mips
[PATCH 3/12] [MIPS] Remove tb0287_defconfig
[PATCH 4/12] [NET] Improve description of MV643XX_ETH
[PATCH 5/12] [NET] Bring declance.c in sync with linux-mips tree
[PATCH 6/12] [NET] Support the BCM1x55 and BCM1x80 chips
[PATCH 7/12] [IDE] Set CFLAGS only for au1xxx-ide
[PATCH 8/12] [MTD] Re-add module description for ms02-nv to Kconfig
[PATCH 9/12] [MTD] Fix #else directive in the docprobe driver
[PATCH 10/12] [MTD] LASAT depends on MTD_CFI
[PATCH 11/12] [USB] Cosmetic changes to bring ohci-au1xxx.c in sync with linux-mips
[PATCH 12/12] [SCSI] mem_start is a physical address already

-- 
Martin Michlmayr
http://www.cyrius.com/
