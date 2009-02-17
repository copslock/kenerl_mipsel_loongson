Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Feb 2009 20:51:06 +0000 (GMT)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:41680 "EHLO
	sj-iport-6.cisco.com") by ftp.linux-mips.org with ESMTP
	id S21366063AbZBQUvD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Feb 2009 20:51:03 +0000
X-IronPort-AV: E=Sophos;i="4.38,225,1233532800"; 
   d="scan'208";a="251336673"
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-6.cisco.com with ESMTP; 17 Feb 2009 20:50:44 +0000
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id n1HKohpa022057;
	Tue, 17 Feb 2009 12:50:43 -0800
Received: from xbh-rtp-211.amer.cisco.com (xbh-rtp-211.cisco.com [64.102.31.102])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id n1HKohQY009626;
	Tue, 17 Feb 2009 20:50:43 GMT
Received: from xmb-rtp-218.amer.cisco.com ([64.102.31.117]) by xbh-rtp-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 17 Feb 2009 15:50:43 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: cacheflush system call-MIPS
Date:	Tue, 17 Feb 2009 15:50:41 -0500
Message-ID: <FF038EB85946AA46B18DFEE6E6F8A2899E30B8@xmb-rtp-218.amer.cisco.com>
In-Reply-To: <20090217194509.GA16134@gate.ebshome.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cacheflush system call-MIPS
Thread-Index: AcmROGb9yqOYrNbLSiuqcc+e/OQPuAAA06nA
References: <f5a7b3810902100716t2658ce95t2dcc7f85634522@mail.gmail.com> <20090211131649.GA1365@linux-mips.org> <Pine.LNX.4.58.0902140002180.408@Indigo2.Peter> <20090213235603.GA32274@linux-mips.org> <Pine.LNX.4.58.0902150312460.459@Indigo2.Peter> <499AEE98.1010908@caviumnetworks.com> <20090217194509.GA16134@gate.ebshome.net>
From:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
To:	"Eugene Surovegin" <ebs@ebshome.net>,
	"David Daney" <ddaney@caviumnetworks.com>
Cc:	<post@pfrst.de>, "Ralf Baechle" <ralf@linux-mips.org>,
	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 17 Feb 2009 20:50:43.0294 (UTC) FILETIME=[665B6FE0:01C99141]
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1419; t=1234903843; x=1235767843;
	c=relaxed/simple; s=sjdkim4002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20=22David=20VomLehn=20(dvomlehn)=22=20<dvomlehn@cis
	co.com>
	|Subject:=20RE=3A=20cacheflush=20system=20call-MIPS
	|Sender:=20;
	bh=ohbDmGwN89Vu2BS4gIircPBZ2hoTSjBe8305JZvlHvQ=;
	b=nJMX9wGcLRaHl55pvaLJHp+ZMUdmV5kmWAZ8IHlpa15VawE0eh37D2KM8x
	S85LntM40zGrNJOtHEN8tcZe36WmIW/Mqi+C+XlPE4V/qKRuZNkjMcGCwprd
	7pEImHMz2Z;
Authentication-Results:	sj-dkim-4; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips


> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Eugene 
> Surovegin
> Sent: Tuesday, February 17, 2009 11:45 AM
> To: David Daney
> Cc: post@pfrst.de; Ralf Baechle; linux-mips@linux-mips.org
> Subject: Re: cacheflush system call-MIPS
> 
> On Tue, Feb 17, 2009 at 09:06:32AM -0800, David Daney wrote:
> > peter fuerst wrote:
> >>> Why does it need that flush?
> >> To prepare the update-area (in the Shadow-FB) for DMA to RE.
> >
> > And on systems where the root frame buffer is directly 
> manipulated by the 
> > CPU, the video system is continually using DMA to refresh 
> the display.  A 
> > cache flush can be required to eliminate transient visual glitches.
> 
> In this case using uncached fb access is the only way to avoid 
> glitches - you cannot control cache line evictions. And it's usually 
> faster to use uncached mappings for effectively write-only regions.

A far more appropriate caching mode for frame buffers, if your processor
supports it, is to use uncached accelerated
(_CACHED_UNCACHED_ACCELERATED in the kernel source). Unfortunately, at
least as far as I can tell, you'd need to write your own driver to do
the memory mapping so that it can set the cache coherency attributes to
get this behavior. Not especially hard if you are familiar with device
drivers, much harder if you are note.
