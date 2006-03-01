Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 23:14:38 +0000 (GMT)
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:44768
	"EHLO aria.kroah.org") by ftp.linux-mips.org with ESMTP
	id S8133711AbWCAXOa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 23:14:30 +0000
Received: from press.kroah.org ([192.168.0.25] helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1FEadZ-00058S-7x; Wed, 01 Mar 2006 15:21:41 -0800
Date:	Wed, 1 Mar 2006 15:21:54 -0800
From:	Greg KH <greg@kroah.com>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	Jordan Crouse <jordan.crouse@amd.com>,
	linux-usb-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
	gregkh@suse.de
Subject: Re: [PATCH] Buglet in Alchemy OHCI driver
Message-ID: <20060301232154.GA13698@kroah.com>
References: <20060301183026.GL31957@cosmic.amd.com> <20060301183735.GA28491@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301183735.GA28491@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <greg@kroah.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
X-list: linux-mips

On Wed, Mar 01, 2006 at 06:37:35PM +0000, Martin Michlmayr wrote:
> * Jordan Crouse <jordan.crouse@amd.com> [2006-03-01 11:30]:
> > Martin Michlmayr spotted this potentially serious bug.  Please apply.
> 
> Please don't send patches as MIME attachments.  Here it is again (with
> a better summary too):
> 
> 
> [PATCH] Alchemy OCHI: return if right resources cannot be obtained
> 
> From: Jordan Crouse <jordan.crouse@amd.com>
> 
> Failure to get the right resources should immediately return.  Current
> code has the possiblity of running off into the weeds. Spotted by
> Martin Michlmayr.
> 
> Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

This patch is already in my tree, in the other patch from Jordan, so it
will make it in after 2.6.16-final is out.

thanks,

greg k-h
