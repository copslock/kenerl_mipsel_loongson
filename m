Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2004 18:51:19 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:27638 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225288AbUDTRvS>;
	Tue, 20 Apr 2004 18:51:18 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i3KHpGx6027959;
	Tue, 20 Apr 2004 10:51:16 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i3KHpGPK027957;
	Tue, 20 Apr 2004 10:51:16 -0700
Date: Tue, 20 Apr 2004 10:51:16 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20040420105116.C22846@mvista.com>
References: <20040420163230Z8225288-1530+99@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040420163230Z8225288-1530+99@linux-mips.org>; from sjhill@linux-mips.org on Tue, Apr 20, 2004 at 05:32:25PM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Apr 20, 2004 at 05:32:25PM +0100, sjhill@linux-mips.org wrote:
> 
> CVSROOT:	/home/cvs
> Module name:	linux
> Changes by:	sjhill@ftp.linux-mips.org	04/04/20 17:32:25
> 
> Modified files:
> 	arch/mips      : Tag: linux_2_4 config-shared.in 
> 
> Log message:
> 	Do not allow CONFIG_PCI_AUTO to be selectable to discourage new users
> 	from using this b0rked code.
> 

CONFIG_PCI_AUTO was meant to a board attribute.  It should not be changed
to be a choice at the first place.

And, the code is not bOrked.  In 2.4 it is a life saver for most MIPS boards
whose firmware do not do a proper or full PCI resource assignment.

Jun
