Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 19:19:45 +0100 (BST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:6470 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024473AbZEFSTj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2009 19:19:39 +0100
X-IronPort-AV: E=Sophos;i="4.40,303,1238976000"; 
   d="scan'208";a="181793362"
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-1.cisco.com with ESMTP; 06 May 2009 18:19:31 +0000
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id n46IJVI5028340;
	Wed, 6 May 2009 11:19:31 -0700
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id n46IJVEV002025;
	Wed, 6 May 2009 18:19:31 GMT
Date:	Wed, 6 May 2009 11:19:31 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] mips:powertv: Make kernel command line size
	configurable (resend)
Message-ID: <20090506181931.GA14025@cuplxvomd02.corp.sa.net>
References: <20090504225719.GA22417@cuplxvomd02.corp.sa.net> <20090506163518.GA19624@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090506163518.GA19624@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=952; t=1241633971; x=1242497971;
	c=relaxed/simple; s=sjdkim4002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH=202/3]=20mips=3Apowertv=3A=20Mak
	e=20kernel=20command=20line=20size=0A=09configurable=20(rese
	nd)
	|Sender:=20;
	bh=uCRvPkOKTgL0B1ozvd1pT1DQrs1lC4lN2WWG/xBWiUc=;
	b=taUUxi+UaY3zjdoYEycI995WF8Ua1ZQWBeCbSTDBId5ttOc8feT8GpLGQv
	L9v73tkrpsr2LB0gxfsNyWa5B25BwCpKxr6fuAi3iLQMnNOFyI6x/GTf7mSC
	GkIHb8WuHh;
Authentication-Results:	sj-dkim-4; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Wed, May 06, 2009 at 05:35:18PM +0100, Ralf Baechle wrote:
> On Mon, May 04, 2009 at 03:57:19PM -0700, David VomLehn wrote:
> 
> > Most platforms can get by perfectly well with the default command line size,
> > but some platforms need more. This patch allows the command line size to
> > be configured for those platforms that need it. The default remains 256
> > characters.
> > 
> > Signed-off-by: David VomLehn <dvomlehn@cisco.com>
> 
> How big of a command line do you need?  For no scientific reason other
> than there not being any obvious need for a larger size MIPS is using 256
> and I think unless you're asking for a huge number it will be better to
> just raise that constant.

The answer depends on the platform, but it's at 438 characters on a typical
platform. If I *had* to pick a number, I'd probably go for 512 characters; I
just hate to force others to use memory they aren't going to use.

>   Ralf

David
