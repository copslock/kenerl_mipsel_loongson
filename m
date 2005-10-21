Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2005 01:56:51 +0100 (BST)
Received: from mail.kroah.org ([69.55.234.183]:4561 "EHLO perch.kroah.org")
	by ftp.linux-mips.org with ESMTP id S8133377AbVJUA4e (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Oct 2005 01:56:34 +0100
Received: from [192.168.0.10] (c-24-22-115-24.hsd1.or.comcast.net [24.22.115.24])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j9L0uVw07015;
	Thu, 20 Oct 2005 17:56:31 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1ESkp7-4nU-00; Thu, 20 Oct 2005 17:31:53 -0700
Date:	Thu, 20 Oct 2005 17:31:53 -0700
From:	Greg KH <greg@kroah.com>
To:	David Daney <ddaney@avtrex.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: Patch: ATI Xilleon port 4/11 Xilleon PCI IDs
Message-ID: <20051021003152.GC18404@kroah.com>
References: <17239.13300.410843.465349@dl2.hq2.avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17239.13300.410843.465349@dl2.hq2.avtrex.com>
User-Agent: Mutt/1.5.11
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
X-list: linux-mips

On Wed, Oct 19, 2005 at 11:06:44PM -0700, David Daney wrote:
> This is the fourth part of my Xilleon port.
> 
> I am sending the full set of patches to linux-mips@linux-mips.org
> which is archived at: http://www.linux-mips.org/archives/
> 
> Only the patches that touch generic parts of the kernel are coming
> here.
> 
> This patch adds some PCI ids for ATI's Xilleon family of SOCs.

Does your driver need all of these ids?  If not, please only include the
ones needed, we are removing all of the unused ids, as we don't need to
keep a file with all possible pci ids in the kernel tree.

thanks,

greg k-h
