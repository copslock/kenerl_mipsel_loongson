Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Nov 2004 13:17:59 +0000 (GMT)
Received: from pD956202C.dip.t-dialin.net ([IPv6:::ffff:217.86.32.44]:51493
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224896AbUKQNRy>; Wed, 17 Nov 2004 13:17:54 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iAHDHolk023723;
	Wed, 17 Nov 2004 14:17:50 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iAHDHfPr023722;
	Wed, 17 Nov 2004 14:17:41 +0100
Date: Wed, 17 Nov 2004 14:17:41 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH]: Rewrite of arch/mips/ramdisk/
Message-ID: <20041117131741.GA23041@linux-mips.org>
References: <4196FE7C.9040309@gentoo.org> <20041114085202.GA30480@lst.de> <419794FB.6020104@gentoo.org> <4197B286.4060503@gentoo.org> <20041115180507.GA23952@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115180507.GA23952@lst.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 15, 2004 at 07:05:07PM +0100, Christoph Hellwig wrote:

> You could include a loop-back mountable filesystem image.  But that's
> not even nessecary.  The kernel will call /init of the files in the
> initramfs, and you could just store everything you'd store in the
> loopback filesystem directly in the initramfs image.

Right.  So this means CONFIG_EMBEDDED_RAMDISK and
CONFIG_EMBEDDED_RAMDISK_IMAGE have become obsolete.  So unless somebody
delivers a convincing argument I'm going to remove these options.

  Ralf
