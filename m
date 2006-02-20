Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 00:12:35 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:62989 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133729AbWBTAMV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 00:12:21 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id ACD0564D3D; Mon, 20 Feb 2006 00:19:14 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 49D488D5D; Mon, 20 Feb 2006 00:19:07 +0000 (GMT)
Date:	Mon, 20 Feb 2006 00:19:07 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	Peter Horton <pdh@colonel-panic.org>
Subject: Re: Diff between Linus' and linux-mips git: tulip
Message-ID: <20060220001907.GC17967@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220000141.GX10266@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220000141.GX10266@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Anyone know what this change is good for?


--- linux-2.6.16-rc4/drivers/net/tulip/tulip_core.c	2006-02-19 20:09:12.000000000 +0000
+++ mips-2.6.16-rc4/drivers/net/tulip/tulip_core.c	2006-02-19 20:15:27.000000000 +0000
@@ -1495,8 +1495,8 @@
                if ((pdev->bus->number == 0) && (PCI_SLOT(pdev->devfn) == 4)) {
                        /* DDB5477 MAC address in first EEPROM locations. */
                        sa_offset = 0;
-                       /* No media table either */
-                       tp->flags &= ~HAS_MEDIA_TABLE;
+		       /* Ensure our media table fixup get's applied */
+		       memcpy(ee_data + 16, ee_data, 8);
                }
 #endif
 #ifdef CONFIG_MIPS_COBALT

-- 
Martin Michlmayr
http://www.cyrius.com/
