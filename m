Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2007 08:51:18 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:58991 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20021972AbXEHHvR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 May 2007 08:51:17 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 8 May 2007 16:51:15 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 60F174209F;
	Tue,  8 May 2007 16:50:49 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 5539B204C3;
	Tue,  8 May 2007 16:50:49 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l487omW0072627;
	Tue, 8 May 2007 16:50:48 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 08 May 2007 16:50:48 +0900 (JST)
Message-Id: <20070508.165048.96687706.nemoto@toshiba-tops.co.jp>
To:	sknauert@wesleyan.edu
Cc:	linux-mips@linux-mips.org
Subject: Re: PCI video card on SGI O2
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1978.129.133.142.66.1178605460.squirrel@webmail.wesleyan.edu>
References: <1978.129.133.142.66.1178605460.squirrel@webmail.wesleyan.edu>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 8 May 2007 02:24:20 -0400 (EDT), sknauert@wesleyan.edu wrote:
> 3) I tried a Voodoo 1, ATI Mach 64, S3 Virge DX, GX, etc., I actually have
> a Millenium I but it won't fit in the O2. I mention these since they were
> listed here http://www.linux-mips.org/wiki/PCI_graphics_cards as
> potentially working. I'm assuming I need more kernel support?

IIRC, patch for ATI Rage XL without BIOS was floating around a while
ago (kernel 2.4 era?), but never merged to mainline in good shape.
And the halfway codes are removed at kernel 2.6.16.

commit cb639258f92b2407c50f79a95364f42932481389
Author: Antonino A. Daplas <adaplas@gmail.com>
Date:   Mon Jan 9 20:53:13 2006 -0800

    [PATCH] fbdev: atyfb: Remove BIOS-less booting
    
    CONFIG_ATYFB_XL_INIT option is broken for a long time.  It will always cause a
    kernel hang.
    
    Since no one has fixed this problem for some time now, remove it from atyfb.


---
Atsushi Nemoto
