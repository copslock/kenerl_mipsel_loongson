Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Jan 2009 21:50:56 +0000 (GMT)
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:43293 "EHLO
	rtp-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S21365236AbZAYVus convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Jan 2009 21:50:48 +0000
X-IronPort-AV: E=Sophos;i="4.37,323,1231113600"; 
   d="scan'208";a="34796660"
Received: from rtp-dkim-1.cisco.com ([64.102.121.158])
  by rtp-iport-2.cisco.com with ESMTP; 25 Jan 2009 21:50:27 +0000
Received: from rtp-core-1.cisco.com (rtp-core-1.cisco.com [64.102.124.12])
	by rtp-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id n0PLoRrj014113;
	Sun, 25 Jan 2009 16:50:27 -0500
Received: from xbh-rtp-211.amer.cisco.com (xbh-rtp-211.cisco.com [64.102.31.102])
	by rtp-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id n0PLoRR1018130;
	Sun, 25 Jan 2009 21:50:27 GMT
Received: from xmb-rtp-218.amer.cisco.com ([64.102.31.117]) by xbh-rtp-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 25 Jan 2009 16:50:26 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.28 will not boot on 24K processor, ebase incorrectly modified in set_uncached_handler
Date:	Sun, 25 Jan 2009 16:50:25 -0500
Message-ID: <FF038EB85946AA46B18DFEE6E6F8A28976828C@xmb-rtp-218.amer.cisco.com>
In-Reply-To: <497C3C6F.3000209@paralogos.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.28 will not boot on 24K processor, ebase incorrectly modified in set_uncached_handler
Thread-Index: Acl+1kXP3jArc75MQT+Qvx8eRtjzGgAYEbsQ
References: <FF038EB85946AA46B18DFEE6E6F8A28976825D@xmb-rtp-218.amer.cisco.com> <497C3C6F.3000209@paralogos.com>
From:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	<linux-mips@linux-mips.org>,
	"Dezhong Diao (dediao)" <dediao@cisco.com>,
	"Victor Williams Jr (williavi)" <williavi@cisco.com>,
	"Michael Sundius -X (msundius - Yoh Services LLC at Cisco)" 
	<msundius@cisco.com>
X-OriginalArrivalTime: 25 Jan 2009 21:50:26.0804 (UTC) FILETIME=[EECB6B40:01C97F36]
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1754; t=1232920227; x=1233784227;
	c=relaxed/simple; s=rtpdkim1001;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20=22David=20VomLehn=20(dvomlehn)=22=20<dvomlehn@cis
	co.com>
	|Subject:=20RE=3A=202.6.28=20will=20not=20boot=20on=2024K=2
	0processor,=20ebase=20incorrectly=20modified=20in=20set_unca
	ched_handler
	|Sender:=20
	|To:=20=22Kevin=20D.=20Kissell=22=20<kevink@paralogos.com>;
	bh=BXqohsHEWbPE2dT/MTS0xpFkavViVUpDSf92xFRsphQ=;
	b=rdKPFDedOx+xMcc/4pslfCUjlcnoyQAlA6US4sXVWZyiEjMPHtROV8hpt4
	cSqI+tPKvycp7wCHIv4TVQR4RMTkC930fUyIu6QrqG0raIyO2QB5AmQfSJTL
	gnyb4mAM8q;
Authentication-Results:	rtp-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/rtpdkim1001 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

> From: Kevin D. Kissell [mailto:kevink@paralogos.com] 
> Sent: Sunday, January 25, 2009 2:18 AM
> To: David VomLehn (dvomlehn)
> Cc: linux-mips@linux-mips.org; Dezhong Diao (dediao); Victor 
> Williams Jr (williavi); Michael Sundius -X (msundius - Yoh 
> Services LLC at Cisco)
> Subject: Re: 2.6.28 will not boot on 24K processor, ebase 
> incorrectly modified in set_uncached_handler
> 
> David VomLehn (dvomlehn) wrote:
> > The 2.6.28 kernel dies in memcpy when called from 
> set_vi_srs_handler on
> > a
> > 24K processor. The problem is that ebase has an invalid value. The
> > original
> > value of ebase comes from a bootmem allocation, but the 
> following code
> > in
> > set_uncached_handler takes a perfectly good kseg0 address 
> and turns it
> > into
> > an invalid kseg1 address.
> >
> > 	if (cpu_has_mips_r2)
> > 		ebase += (read_c0_ebase() & 0x3ffff000);
> >
> > This code was added in commit 
> 566f74f6b2f8b85d5b8d6caaf97e5672cecd3e3e.
> >   
> I remember worrying about why it was "+=" and not "=" when others had 
> problems with that patch. See the thread "NXP STB225 board 
> support" from 
> January 8 or so.  When I asked about that, I got a comment 
> that the add 
> operation was correct, but that patch *should* have said 
> "uncached_ebase 
> += (read_c0_ebase() & 0x3ffff000);"  I guess uncache_ebase is 
> assumed to 
> contain something interesting in some non-address bits. Try 
> pre-pending 
> "uncached_" to that "ebase"...

Just adding uncached_ to the ebase doesn't appear to work. Looking at
the git
log makes it a bit unclear as to exactly who made this change, but it
would
be helpful to know what was intended.
