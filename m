Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2006 01:43:07 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:25362 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133753AbWBXBm6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Feb 2006 01:42:58 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id E7D5964D3E; Fri, 24 Feb 2006 01:50:13 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id C18DA8DC5; Fri, 24 Feb 2006 01:49:57 +0000 (GMT)
Date:	Fri, 24 Feb 2006 01:49:57 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: tulip
Message-ID: <20060224014957.GB26157@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220000141.GX10266@deprecation.cyrius.com> <20060220001907.GC17967@deprecation.cyrius.com> <20060220230349.GB1122@colonel-panic.org> <20060224011324.GN9704@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224011324.GN9704@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-02-24 01:13]:
>  - should the CONFIG_DDB5477 change be reverted (probably)

OK, I managed to track down when this change was introduced, namely in
the merge with Linux 2.6.13-rc1.  See
http://www.linux-mips.org/git?p=linux.git;a=blobdiff;h=e6781ea5ba055ec445f35c734a59db24e748be3a;hp=cfc346e72d6234ae37ee11b794791ee99fcec24e;hb=aa5fcc48f9ae2887b6c570411e73ef965f72a746;f=drivers/net/tulip/tulip_core.c

Ralf, please apply this to the mips-tree only (not for-linus).


[MIPS] Revert bogus tulip_core/DDB5477 change introduced in 2.6.13-rc1 merge

Merging with 2.6.13-rc1 introduced a change in the DDB5477 section of
tulip_core.c that was really meant for Cobalt (and was there already).
Revert this change, thereby syncing with Linus' tree.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

--- mips.git/drivers/net/tulip/tulip_core.c	2006-02-23 22:05:30.000000000 +0000
+++ linux.git/drivers/net/tulip/tulip_core.c	2006-02-03 03:07:03.000000000 +0000
@@ -1495,8 +1495,8 @@
                if ((pdev->bus->number == 0) && (PCI_SLOT(pdev->devfn) == 4)) {
                        /* DDB5477 MAC address in first EEPROM locations. */
                        sa_offset = 0;
-		       /* Ensure our media table fixup get's applied */
-		       memcpy(ee_data + 16, ee_data, 8);
+                       /* No media table either */
+                       tp->flags &= ~HAS_MEDIA_TABLE;
                }
 #endif
 #ifdef CONFIG_MIPS_COBALT

-- 
Martin Michlmayr
http://www.cyrius.com/
