Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2007 14:20:45 +0100 (BST)
Received: from real.realitydiluted.com ([66.43.201.61]:65441 "EHLO
	real.realitydiluted.com") by ftp.linux-mips.org with ESMTP
	id S20026893AbXHHNUg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Aug 2007 14:20:36 +0100
Received: from sjhill by real.realitydiluted.com with local (Exim 4.67)
	(envelope-from <sjhill@real.realitydiluted.com>)
	id 1IIlRz-0003Ik-LT; Wed, 08 Aug 2007 08:19:47 -0500
Date:	Wed, 8 Aug 2007 08:19:47 -0500
From:	"Steven J. Hill" <sjhill@realitydiluted.com>
To:	Mohamed Bamakhrama <bamakhrama@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Problems with NFS boot
Message-ID: <20070808131947.GA12598@real.realitydiluted.com>
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
X-archive-position: 16133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> I have a Malta board for which I was able to build the kernel, load it
> and start it. The problem comes when it tries to boot through the NFS.
> 
> The kernel starts up and I get the following output:
> 
You did not provide your kernel config file, so I assume you have these
options set in your kernel:

CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_ROOT_NFS=y

If not, then make sure you enable these.

-Steve
