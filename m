Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2009 18:23:49 +0000 (GMT)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:64519 "EHLO
	sj-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S21366256AbZCESXp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2009 18:23:45 +0000
X-IronPort-AV: E=Sophos;i="4.38,308,1233532800"; 
   d="scan'208";a="151416825"
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-1.cisco.com with ESMTP; 05 Mar 2009 18:23:35 +0000
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id n25INZ3w021876;
	Thu, 5 Mar 2009 10:23:35 -0800
Received: from xbh-rtp-201.amer.cisco.com (xbh-rtp-201.cisco.com [64.102.31.12])
	by sj-core-5.cisco.com (8.13.8/8.13.8) with ESMTP id n25INPBR003744;
	Thu, 5 Mar 2009 18:23:35 GMT
Received: from xmb-rtp-218.amer.cisco.com ([64.102.31.117]) by xbh-rtp-201.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 5 Mar 2009 13:23:32 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH, RFC] MIPS: Implement the getcontext API
Date:	Thu, 5 Mar 2009 13:23:31 -0500
Message-ID: <FF038EB85946AA46B18DFEE6E6F8A289BE0DC1@xmb-rtp-218.amer.cisco.com>
In-Reply-To: <49B004AA.8050006@caviumnetworks.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH, RFC] MIPS: Implement the getcontext API
Thread-Index: Acmds9qK4urogWtGSdKC7Amxa4hzaQACwSEw
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <49AD6139.60209@caviumnetworks.com> <alpine.DEB.1.10.0903051530080.6558@tp.orcam.me.uk> <49B004AA.8050006@caviumnetworks.com>
From:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
To:	"David Daney" <ddaney@caviumnetworks.com>,
	"Maciej W. Rozycki" <macro@codesourcery.com>
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
	<libc-ports@sourceware.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	"Richard Sandiford" <rdsandiford@googlemail.com>
X-OriginalArrivalTime: 05 Mar 2009 18:23:32.0808 (UTC) FILETIME=[7D963480:01C99DBF]
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1321; t=1236277415; x=1237141415;
	c=relaxed/simple; s=sjdkim2002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20=22David=20VomLehn=20(dvomlehn)=22=20<dvomlehn@cis
	co.com>
	|Subject:=20RE=3A=20[PATCH,=20RFC]=20MIPS=3A=20Implement=20
	the=20getcontext=20API
	|Sender:=20;
	bh=l5AIuFnITfSmQxyIpC/Jpt1DHipPwNOu4ok08B1NLcY=;
	b=oY/rLoVg/rTy8kE0LSKiKW98eC5OtzvgSLnvVsYq8qMjLeggESqUQbGkU4
	3mHj9rY9KZaXIJW5GgC2YU5Q7aB+YsZGr5hDWz4KCTpdi10JzhIZH6OBqrRP
	yIu6ch12tb;
Authentication-Results:	sj-dkim-2; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of David Daney
> Sent: Thursday, March 05, 2009 8:58 AM
> To: Maciej W. Rozycki
> Cc: Ralf Baechle; linux-mips@linux-mips.org; 
> libc-ports@sourceware.org; Maciej W. Rozycki; Richard Sandiford
> Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
> 
> Adding Richard S. as he may be interested...
> 
> Maciej W. Rozycki wrote:
> > On Tue, 3 Mar 2009, David Daney wrote:
> > 
> >> Note the libgcc currently makes the assumption that the 
> layout of the stack
> >> for signal handlers is fixed.  The DWARF2 unwinder needs 
> this information to
> >> be able to unwind through signal frames (see 
> gcc/config/mips/linux-unwind.h),
> >> so it is already a de facto part of the ABI.
> > 
> >  I do hope it was agreed upon at some point.
> 
> As with many things, there was no formal agreement.

To the best of my knowledge, there is no formal ABI for MIPS Linux,
period. The closest we have is the MIPS psABI, which documented the o32
ABI as it stood ten years ago. What we have now does not conform to that
document in some subtle, but non-trivial, ways. If I'm wrong, I'd love
to know where I could find documentation.

David VomLehn
