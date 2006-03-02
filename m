Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2006 16:21:52 +0000 (GMT)
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:7897 "EHLO
	aria.kroah.org") by ftp.linux-mips.org with ESMTP id S8133795AbWCBQVm
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Mar 2006 16:21:42 +0000
Received: from press.kroah.org ([192.168.0.25] helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1FEqff-0007m0-HV; Thu, 02 Mar 2006 08:28:55 -0800
Date:	Thu, 2 Mar 2006 08:28:51 -0800
From:	Greg KH <gregkh@suse.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Jordan Crouse <jordan.crouse@amd.com>,
	linux-usb-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
	tbm@cyrius.com
Subject: Re: [PATCH] Buglet in Alchemy OHCI driver
Message-ID: <20060302162851.GA30455@suse.de>
References: <20060301183026.GL31957@cosmic.amd.com> <20060302153344.GA8487@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060302153344.GA8487@linux-mips.org>
User-Agent: Mutt/1.5.11
Return-Path: <greg@kroah.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Thu, Mar 02, 2006 at 03:33:44PM +0000, Ralf Baechle wrote:
> On Wed, Mar 01, 2006 at 11:30:26AM -0700, Jordan Crouse wrote:
> > Date:	Wed, 1 Mar 2006 11:30:26 -0700
> > From:	"Jordan Crouse" <jordan.crouse@amd.com>
> > To:	linux-usb-devel@lists.sourceforge.net
> > cc:	linux-mips@linux-mips.org, gregkh@suse.de, tbm@cyrius.com
> > Subject: [PATCH] Buglet in Alchemy OHCI driver
> > Content-Type: multipart/mixed;
> >  boundary=5vNYLRcllDrimb99
> > 
> > Martin Michlmayr spotted this potentially serious bug.  Please apply.
> 
> Ehh...  This problem doesn't exist on kernel.org.  Greg, can you ignore
> this one, please?

Consider it ignored :)

thanks,

greg k-h
