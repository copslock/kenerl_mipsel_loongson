Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Feb 2008 15:03:46 +0000 (GMT)
Received: from ra.tuxdriver.com ([70.61.120.52]:54542 "EHLO ra.tuxdriver.com")
	by ftp.linux-mips.org with ESMTP id S28591247AbYB1PDn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 Feb 2008 15:03:43 +0000
Received: from ra.tuxdriver.com (ra.tuxdriver.com [127.0.0.1])
	by ra.tuxdriver.com (8.14.0/8.13.7) with ESMTP id m1SF1x27029163
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Feb 2008 10:02:14 -0500
Received: (from uucp@localhost)
	by ra.tuxdriver.com (8.14.0/8.14.0/Submit) with UUCP id m1SEk4se029014;
	Thu, 28 Feb 2008 09:46:04 -0500
Received: from linville-t43.mobile (localhost.localdomain [127.0.0.1])
	by linville-t43.mobile (8.14.1/8.13.8) with ESMTP id m1SEfw1v002361;
	Thu, 28 Feb 2008 09:41:58 -0500
Received: (from linville@localhost)
	by linville-t43.mobile (8.14.1/8.14.1/Submit) id m1SEfwwX002360;
	Thu, 28 Feb 2008 09:41:58 -0500
Date:	Thu, 28 Feb 2008 09:41:58 -0500
From:	"John W. Linville" <linville@tuxdriver.com>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	Michael Buesch <mb@bu3sch.de>, Adrian Bunk <bunk@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [SSB] PCI core driver: use new SPROM data structure
Message-ID: <20080228144158.GC3063@tuxdriver.com>
References: <20080217200947.GH1403@cs181133002.pp.htv.fi> <20080218100126.GA22519@hall.aurel32.net> <20080218100257.GB22519@hall.aurel32.net> <200802181910.46581.mb@bu3sch.de> <47C6C10E.9000300@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47C6C10E.9000300@aurel32.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <linville@tuxdriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linville@tuxdriver.com
Precedence: bulk
X-list: linux-mips

On Thu, Feb 28, 2008 at 03:11:26PM +0100, Aurelien Jarno wrote:
> Michael Buesch a écrit :
> > On Monday 18 February 2008 11:02:57 Aurelien Jarno wrote:
> >> Switch the SSB PCI core driver to the new SPROM data structure now that
> >> the old one has been removed.
> >>
> >> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > 
> > Acked-by: Michael Buesch <mb@bu3sch.de>
> > 
> > John, can you please apply this?
> 
> John, any news about this patch?

I'm sorry, I must have missed it.  I have to respin the pull request
I sent to Dave M. yesterday anyway, so I'll include it in that.

Thanks for reminding me!

John
-- 
John W. Linville
linville@tuxdriver.com
