Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2007 10:15:56 +0100 (BST)
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:48913 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S20023314AbXDZJPy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Apr 2007 10:15:54 +0100
Received: from flint.arm.linux.org.uk ([2002:d993:5cf9:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.62)
	(envelope-from <rmk@arm.linux.org.uk>)
	id 1Hh01c-0000so-VX; Thu, 26 Apr 2007 10:12:29 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.62)
	(envelope-from <rmk@flint.arm.linux.org.uk>)
	id 1Hh01Y-0005w9-4v; Thu, 26 Apr 2007 10:12:24 +0100
Date:	Thu, 26 Apr 2007 10:12:22 +0100
From:	Russell King <rmk+lkml@arm.linux.org.uk>
To:	"Aeschbacher, Fabrice" <Fabrice.Aeschbacher@siemens.com>
Cc:	lkml <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
Subject: Re: pcmcia - failed to initialize IDE interface
Message-ID: <20070426091222.GA16723@flint.arm.linux.org.uk>
Mail-Followup-To: "Aeschbacher, Fabrice" <Fabrice.Aeschbacher@siemens.com>,
	lkml <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
References: <20070425190753.fb8c272d.akpm@linux-foundation.org> <D7810733513F4840B4EBAAFA64D9C6A4012D6148@stgw002a.ww002.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7810733513F4840B4EBAAFA64D9C6A4012D6148@stgw002a.ww002.siemens.net>
User-Agent: Mutt/1.4.2.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk+lkml@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Thu, Apr 26, 2007 at 10:48:09AM +0200, Aeschbacher, Fabrice wrote:
> __request_resource: new=ide0[10200e-10200e], root=PCI IO[1000-fffffffff]
> __request_resource: new=ide0[102000-102007], root=PCI IO[1000-fffffffff]
> 
> I added some printk() only for debugging raisons (for example in
> __request_resource, as you can see)

You might want to also dump the resource flags as well.  The two I show
above (from the PCMCIA calls in ide_config) should not mark the resources
busy.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
