Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2009 03:39:50 +0000 (GMT)
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:50047 "EHLO
	rtp-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S21365766AbZA3Djr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2009 03:39:47 +0000
X-IronPort-AV: E=Sophos;i="4.37,348,1231113600"; 
   d="scan'208";a="35366717"
Received: from rtp-dkim-2.cisco.com ([64.102.121.159])
  by rtp-iport-1.cisco.com with ESMTP; 30 Jan 2009 03:39:38 +0000
Received: from rtp-core-1.cisco.com (rtp-core-1.cisco.com [64.102.124.12])
	by rtp-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id n0U3dcnw017766;
	Thu, 29 Jan 2009 22:39:38 -0500
Received: from xbh-rtp-211.amer.cisco.com (xbh-rtp-211.cisco.com [64.102.31.102])
	by rtp-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id n0U3dcUA029388;
	Fri, 30 Jan 2009 03:39:38 GMT
Received: from xmb-rtp-218.amer.cisco.com ([64.102.31.117]) by xbh-rtp-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 29 Jan 2009 22:39:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: memcpy and prefetch
Date:	Thu, 29 Jan 2009 22:39:37 -0500
Message-ID: <FF038EB85946AA46B18DFEE6E6F8A2898237E1@xmb-rtp-218.amer.cisco.com>
In-Reply-To: <20090129155854.GC29521@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: memcpy and prefetch
Thread-Index: AcmCKpIrQPWnNMO0Tsqxqvphv6Zt2wAYO6Kg
References: <20090128103753.GC2234@linux-mips.org> <20090129.002850.118974677.anemo@mba.ocn.ne.jp> <20090128183047.GA1691@linux-mips.org> <20090129.213613.128618730.anemo@mba.ocn.ne.jp> <20090129155854.GC29521@linux-mips.org>
From:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Cc:	<ddaney@caviumnetworks.com>,
	"Michael Sundius -X (msundius - Yoh Services LLC at Cisco)" 
	<msundius@cisco.com>, <linux-mips@linux-mips.org>,
	<msundius@sundius.com>
X-OriginalArrivalTime: 30 Jan 2009 03:39:37.0964 (UTC) FILETIME=[604FBAC0:01C9828C]
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1659; t=1233286778; x=1234150778;
	c=relaxed/simple; s=rtpdkim2001;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20=22David=20VomLehn=20(dvomlehn)=22=20<dvomlehn@cis
	co.com>
	|Subject:=20RE=3A=20memcpy=20and=20prefetch
	|Sender:=20
	|To:=20=22Ralf=20Baechle=22=20<ralf@linux-mips.org>,=0A=20=
	20=20=20=20=20=20=20=22Atsushi=20Nemoto=22=20<anemo@mba.ocn.
	ne.jp>;
	bh=Kq0jYqdl+9SUjeFYBjG4WzRAu6mBBgSxMUs0J7R7a+8=;
	b=vTXeMBHhAF2vQUxvTn5KcDUuWRngS9nePdpDYkAyCd43JqacwVuWy07Yyt
	5e2leTCSmSoxZjjqE2eb3FkePazgjB3A9lOZvohJGn1kCkIBgJmAKah8WF0W
	B5TEz00hYp;
Authentication-Results:	rtp-dkim-2; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/rtpdkim2001 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

> The idea here is that we have two issues with prefetching:
> 
>  o Prefetching beyond the end of the source or destination range on a
>    in-coherent range might bring back stale values from a DMA I/O
>    buffer resulting in data corruption.  Hardware DMA coherency will
>    avoid this issue.
> 
>  o IP27 has full blown hardware coherency.  Historically 
> CONFIG_DMA_COHERENT
>    was not able to cope with something of the complexity of IP27, so
>    there was a separate CONFIG_DMA_IP27 and the broken logic 
> expression
>    was meant to treat CONFIG_DMA_COHERENT and CONFIG_DMA_IP27 the same
>    as for prefetching.
> 
>  o Prefetching beyond the end of physical memory can cause 
> exceptions on
>    some systems.  The Malta has this problem.
> 
> Thus no prefetching on Malta or non-coherent systems.
> 
>   Ralf

It seems to me as though we could avoid the first and third problems
with a memcpy that doesn't prefetch past the end of the buffer, the
thought being that if we are reading or writing a memory region, we
really shouldn't be doing DMA to or from that location. This would
probably be slightly suboptimal, performance-wise, for those systems
that do have DMA coherence. It seems as though we could have two
mutually exclusive versions, selectable via the CONFIG_DMA_COHERENT
flag. For those of us without DMA coherence, it would probably give our
memcpy performance a bit of a kick in the pants over using no prefetch
at all.

If this makes sense, we might be able to sign up to do the work. Anyone
have a good, caching-aware memcpy test?
--
David VomLehn, dvomlehn@cisco.com
