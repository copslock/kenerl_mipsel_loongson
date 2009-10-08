Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 23:07:23 +0200 (CEST)
Received: from cantor.suse.de ([195.135.220.2]:48242 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493652AbZJHVHQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Oct 2009 23:07:16 +0200
Received: from relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id AE3678D893;
	Thu,  8 Oct 2009 23:07:13 +0200 (CEST)
Date:	Thu, 8 Oct 2009 13:55:12 -0700
From:	Greg KH <gregkh@suse.de>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-usb@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/2] USB: Add USB HCD for Octeon SOCs.
Message-ID: <20091008205512.GA5605@suse.de>
References: <4ACD2EBF.8020901@caviumnetworks.com>
 <4ACE1CBD.6000106@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACE1CBD.6000106@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <gregkh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Thu, Oct 08, 2009 at 10:09:17AM -0700, David Daney wrote:
> David Daney wrote:
> > The subject line kind of says it all.
> > 
> > Some members of the Cavium Networks Octeon family of SOCs contain the
> > Synopsys DWC-OTG USB controller.  This patch set adds the
> > corresponding driver.
> > 
> > The first patch adds between zero and two Octeon platform devices.
> > The second is the driver.
> > 
> > I have done a little bit of clean-up on the driver code, but
> > undoubtedly the careful scrutiny of the USB maintainers will uncover
> > more opportunities for improvement.  I look foreword to seeing any
> > suggestions for how the code might be changed so that it could be
> > merged.
> > 
> > 
> > I will reply with the two patches.
> > 
> 
> I did in fact reply with the two patches.  However some spam filtering 
> seems to have stopped '[PATCH 2/2] USB: Add HCD for Octeon SOC' from 
> making it to the lists.
> 
> Ralf has released it to linux-mips@linux-mips.org, but 
> linux-usb@vger.kernel.org seems to have eaten it.
> 
> It had a Message-Id: 
> <1254960926-12185-2-git-send-email-ddaney@caviumnetworks.com>
> 
> I won't send it again as it seems likely that it would get eaten again, 
> but if the list controllers for linux-usb could release it, that would 
> be nice.

The message is probably gone into the ether, sorry.

I got it though.

Are you looking for this to go through the usb tree?  Or the mips tree?

thanks,

greg k-h
