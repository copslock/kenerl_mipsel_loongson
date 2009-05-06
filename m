Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 19:33:44 +0100 (BST)
Received: from sj-iport-3.cisco.com ([171.71.176.72]:27205 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024471AbZEFSdh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2009 19:33:37 +0100
X-IronPort-AV: E=Sophos;i="4.40,303,1238976000"; 
   d="scan'208";a="159454157"
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-3.cisco.com with ESMTP; 06 May 2009 18:33:29 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id n46IXTOY030207;
	Wed, 6 May 2009 11:33:29 -0700
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id n46IXTOd024170;
	Wed, 6 May 2009 18:33:29 GMT
Date:	Wed, 6 May 2009 11:33:30 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	Jon Fraser <jfraser@broadcom.com>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/3] mips:powertv: Make kernel command line size
	configurable (resend)
Message-ID: <20090506183330.GC14025@cuplxvomd02.corp.sa.net>
References: <20090504225719.GA22417@cuplxvomd02.corp.sa.net> <20090506163518.GA19624@linux-mips.org> <20090506181931.GA14025@cuplxvomd02.corp.sa.net> <4A01D5C7.4090900@caviumnetworks.com> <1241634456.10498.11.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1241634456.10498.11.camel@chaos.ne.broadcom.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1745; t=1241634809; x=1242498809;
	c=relaxed/simple; s=sjdkim4002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH=202/3]=20mips=3Apowertv=3A=20Mak
	e=20kernel=20command=20line=20size=0A=09configurable=20(rese
	nd)
	|Sender:=20;
	bh=8ZXHmQk3H1UE+UuS8Edh4dyQflXyhFvjhNKCuKnctzo=;
	b=kqVJQ68uAfW+bd3q3yRCIFBINfLu7kfRuBkw3aQJUT9lFinFwHGTS3clfx
	RbPprWxmOw8rMKxJskuDkrFFGHOcxH5SMCrrINr3h6QU2TmHerzcL2Es+45i
	jgJUhbwkw4;
Authentication-Results:	sj-dkim-4; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Wed, May 06, 2009 at 02:27:36PM -0400, Jon Fraser wrote:
> 
> 
> On Wed, 2009-05-06 at 11:24 -0700, David Daney wrote:
> > David VomLehn wrote:
> > > On Wed, May 06, 2009 at 05:35:18PM +0100, Ralf Baechle wrote:
> > >> On Mon, May 04, 2009 at 03:57:19PM -0700, David VomLehn wrote:
> > >>
> > >>> Most platforms can get by perfectly well with the default command line size,
> > >>> but some platforms need more. This patch allows the command line size to
> > >>> be configured for those platforms that need it. The default remains 256
> > >>> characters.
> > >>>
> > >>> Signed-off-by: David VomLehn <dvomlehn@cisco.com>
> > >> How big of a command line do you need?  For no scientific reason other
> > >> than there not being any obvious need for a larger size MIPS is using 256
> > >> and I think unless you're asking for a huge number it will be better to
> > >> just raise that constant.
> > > 
> > > The answer depends on the platform, but it's at 438 characters on a typical
> > > platform. If I *had* to pick a number, I'd probably go for 512 characters; I
> > > just hate to force others to use memory they aren't going to use.
> > > 
> > 
> > I wonder if the memory could be dynamically allocated.  It would of 
> > course be a much larger patch.
> > 
> > David Daney
> 
> A bit of a chicken and egg problem if your command line arguments
> set the memory configuration.
> 
> Jon Fraser

You could wait for a final copy of the command line until *after* you have at
least the boot memory allocator working. Then other buffers used to hold
the command line would be __initdata.  Sounds like a bit of work, though, and
it might be kind of fragile for such a small gain in memory.

David VomLehn
