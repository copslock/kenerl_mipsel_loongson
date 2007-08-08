Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2007 14:22:11 +0100 (BST)
Received: from real.realitydiluted.com ([66.43.201.61]:418 "EHLO
	real.realitydiluted.com") by ftp.linux-mips.org with ESMTP
	id S20026894AbXHHNWD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Aug 2007 14:22:03 +0100
Received: from sjhill by real.realitydiluted.com with local (Exim 4.67)
	(envelope-from <sjhill@real.realitydiluted.com>)
	id 1IIlTQ-0003Is-9h; Wed, 08 Aug 2007 08:21:16 -0500
Date:	Wed, 8 Aug 2007 08:21:16 -0500
From:	"Steven J. Hill" <sjhill@realitydiluted.com>
To:	Mohamed Bamakhrama <bamakhrama@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Problems with NFS boot
Message-ID: <20070808132116.GB12598@real.realitydiluted.com>
References: <40378e40708080318w7dc0f0b7s4c94c98acd72ec2c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40378e40708080318w7dc0f0b7s4c94c98acd72ec2c@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <sjhill@real.realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

On Wed, Aug 08, 2007 at 12:18:51PM +0200, Mohamed Bamakhrama wrote:
> 
> I start the kernel with the following command:
> go . nfsroot=192.168.1.1/mnt/danube_rootfs ip=192.168.1.4:192.168.1.1:::
> 
Also you might try adding 'root=/dev/nfs' to your kernel command line
too for fun.

-Steve
