Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 14:29:53 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:44549 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8134400AbWASO3d (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jan 2006 14:29:33 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0JEWUVD008563;
	Thu, 19 Jan 2006 14:32:30 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0JEWUW1008562;
	Thu, 19 Jan 2006 14:32:30 GMT
Date:	Thu, 19 Jan 2006 14:32:29 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: Fix SGI O2 Compile error in drivers/video/gbefb.c
Message-ID: <20060119143229.GB3398@linux-mips.org>
References: <43CF9F33.8000907@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CF9F33.8000907@gentoo.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 19, 2006 at 09:16:19AM -0500, Kumba wrote:

> Around line ~1247, a sysfs function call uses the wrong parameter, and thus 
> breaks a build on SGI O2 with current git.  The following patch fixes this.

Please send framebuffer stuff to:

FRAMEBUFFER LAYER
P:      Antonino Daplas
M:      adaplas@pol.net
L:      linux-fbdev-devel@lists.sourceforge.net
W:      http://linux-fbdev.sourceforge.net/
S:      Maintained

  Ralf
