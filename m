Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Nov 2007 14:27:07 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:23571 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20033924AbXKYO07 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Nov 2007 14:26:59 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id E259AD8E0; Sun, 25 Nov 2007 14:26:21 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 651CE544F2; Sun, 25 Nov 2007 15:26:03 +0100 (CET)
Date:	Sun, 25 Nov 2007 15:26:03 +0100
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	manoj.ekbote@broadcom.com, mark.e.mason@broadcom.com
Subject: BigSur: io_map_base not set for PCI bus 0000:00
Message-ID: <20071125142603.GQ20922@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

When I put a SATA/PATA PCI card into the first PCI slot of my BigSur,
I get the following with current git:

io_map_base of root PCI bus 0000:00 unset.  Trying to continue but you better
fix this issue or report it to linux-mips@linux-mips.org or your vendor.
Kernel panic - not syncing: To avoid data corruption io_map_base MUST be set with multiple PCI domains.

This doesn't happen in any of the other PCI slots but in this case the
kernel doesn't seem to see the card (CFE does).

CFE says:
PCI[0] bus 0 slot 1/0: unknown vendor 0x1106 product 0x3249 (RAID mass storage, rev 0x50)

This is with CFE 1.4.2 in LE mode.
-- 
Martin Michlmayr
http://www.cyrius.com/
