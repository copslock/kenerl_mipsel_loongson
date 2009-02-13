Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2009 18:42:03 +0000 (GMT)
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:4807 "EHLO
	rtp-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S21103516AbZBMSmA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Feb 2009 18:42:00 +0000
X-IronPort-AV: E=Sophos;i="4.38,203,1233532800"; 
   d="scan'208";a="37021183"
Received: from rtp-dkim-1.cisco.com ([64.102.121.158])
  by rtp-iport-1.cisco.com with ESMTP; 13 Feb 2009 18:41:53 +0000
Received: from rtp-core-2.cisco.com (rtp-core-2.cisco.com [64.102.124.13])
	by rtp-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id n1DIfrAu003501;
	Fri, 13 Feb 2009 13:41:53 -0500
Received: from xbh-rtp-211.amer.cisco.com (xbh-rtp-211.cisco.com [64.102.31.102])
	by rtp-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id n1DIfrVE008828;
	Fri, 13 Feb 2009 18:41:53 GMT
Received: from xmb-rtp-218.amer.cisco.com ([64.102.31.117]) by xbh-rtp-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 13 Feb 2009 13:41:53 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] MIPS: Allocate exception vector on 64 KiB boundary
Date:	Fri, 13 Feb 2009 13:41:52 -0500
Message-ID: <FF038EB85946AA46B18DFEE6E6F8A2899E2896@xmb-rtp-218.amer.cisco.com>
In-Reply-To: <1234532640.711.63.camel@sakura.staff.proxad.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] MIPS: Allocate exception vector on 64 KiB boundary
Thread-Index: AcmN4SwSSf7Q833JSEe/nf8vSv/UKgAKYM+w
References:  <FF038EB85946AA46B18DFEE6E6F8A28982392E@xmb-rtp-218.amer.cisco.com> <1234532640.711.63.camel@sakura.staff.proxad.net>
From:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
To:	<mbizon@freebox.fr>
Cc:	<linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
	"David Daney" <ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 13 Feb 2009 18:41:53.0546 (UTC) FILETIME=[BD6A7EA0:01C98E0A]
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1118; t=1234550513; x=1235414513;
	c=relaxed/simple; s=rtpdkim1001;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20=22David=20VomLehn=20(dvomlehn)=22=20<dvomlehn@cis
	co.com>
	|Subject:=20RE=3A=20[PATCH]=20MIPS=3A=20Allocate=20exceptio
	n=20vector=20on=2064=20KiB=20boundary
	|Sender:=20
	|To:=20<mbizon@freebox.fr>;
	bh=iWrHvyW+ZEt+AGXGzeM9r4JM8JAegK2p7Xs/gNvvZRU=;
	b=U7thLNw8nQy4hoOh29tqUIVD0mffy6hg8wyCUDbYkkS7kOWM9NVE1B1Fx1
	stB/HnVH1Yz7lAM5pOH0pX8cBAyWUpkJkSZ9XFG2Kkj+dDHltUncwUVhTjwY
	RFYe+BL3OX;
Authentication-Results:	rtp-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/rtpdkim1001 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

> From: Maxime Bizon [mailto:mbizon@freebox.fr] 
> Sent: Friday, February 13, 2009 5:44 AM
> To: David VomLehn (dvomlehn)
> Cc: linux-mips@linux-mips.org; ralf@linux-mips.org; David Daney
> Subject: Re: [PATCH] MIPS: Allocate exception vector on 64 
> KiB boundary
> 
> 
> On Fri, 2009-01-30 at 13:43 -0500, David VomLehn (dvomlehn) wrote:
> 
> > Fix problem with code that incorrectly modifies ebase.
> > 
> > Commit 566f74f6b2f8b85d5b8d6caaf97e5672cecd3e3e had a change that
> > incorrectly
> > modified ebase. This backs out the lines that modified 
> ebase and then
> > modified
> 
> I confirm this commit prevents my 4kec board from booting.
> 
> My c0_ebase is set to 0x90000000.
> 
> In trap_init() ebase is first set to CAC_BASE => 0x80000000, then
> 0x90000000 after adding c0_ebase offset.
> 
> set_uncached_handler() starts with uncached_ebase sets to
> KSEG1ADDR(ebase) => 0xb0000000, which is already the correct 
> value, but
> it then add the c0_ebase offset again => 0xc0000000 => boom.

Can you confirm that the patch fixes your problem?
