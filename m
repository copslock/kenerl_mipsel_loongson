Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2009 22:08:32 +0000 (GMT)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:7782 "EHLO
	sj-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20808936AbZCEWI3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2009 22:08:29 +0000
X-IronPort-AV: E=Sophos;i="4.38,309,1233532800"; 
   d="scan'208";a="151553296"
Received: from rtp-dkim-1.cisco.com ([64.102.121.158])
  by sj-iport-1.cisco.com with ESMTP; 05 Mar 2009 22:08:21 +0000
Received: from rtp-core-1.cisco.com (rtp-core-1.cisco.com [64.102.124.12])
	by rtp-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id n25M8J3D005004;
	Thu, 5 Mar 2009 17:08:19 -0500
Received: from xbh-rtp-201.amer.cisco.com (xbh-rtp-201.cisco.com [64.102.31.12])
	by rtp-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id n25M8JnX016173;
	Thu, 5 Mar 2009 22:08:19 GMT
Received: from xmb-rtp-218.amer.cisco.com ([64.102.31.117]) by xbh-rtp-201.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 5 Mar 2009 17:08:19 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH, RFC] MIPS: Implement the getcontext API
Date:	Thu, 5 Mar 2009 17:08:18 -0500
Message-ID: <FF038EB85946AA46B18DFEE6E6F8A289BE0EF8@xmb-rtp-218.amer.cisco.com>
In-Reply-To: <Pine.LNX.4.64.0903052148500.12710@digraph.polyomino.org.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH, RFC] MIPS: Implement the getcontext API
Thread-Index: Acmd3Nkuz4Q900bBQfa7KqWkCfRlNAAAWe2w
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <49AD6139.60209@caviumnetworks.com> <alpine.DEB.1.10.0903051530080.6558@tp.orcam.me.uk> <49B004AA.8050006@caviumnetworks.com> <FF038EB85946AA46B18DFEE6E6F8A289BE0DC1@xmb-rtp-218.amer.cisco.com> <20090305213653.GB12355@linux-mips.org> <Pine.LNX.4.64.0903052148500.12710@digraph.polyomino.org.uk>
From:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
To:	"Joseph Myers" <joseph@codesourcery.com>,
	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	"David Daney" <ddaney@caviumnetworks.com>,
	"Maciej W. Rozycki" <macro@codesourcery.com>,
	<linux-mips@linux-mips.org>, <libc-ports@sourceware.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	"Richard Sandiford" <rdsandiford@googlemail.com>
X-OriginalArrivalTime: 05 Mar 2009 22:08:19.0261 (UTC) FILETIME=[E4239ED0:01C99DDE]
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1880; t=1236290899; x=1237154899;
	c=relaxed/simple; s=rtpdkim1001;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20=22David=20VomLehn=20(dvomlehn)=22=20<dvomlehn@cis
	co.com>
	|Subject:=20RE=3A=20[PATCH,=20RFC]=20MIPS=3A=20Implement=20
	the=20getcontext=20API
	|Sender:=20
	|To:=20=22Joseph=20Myers=22=20<joseph@codesourcery.com>,=0A
	=20=20=20=20=20=20=20=20=22Ralf=20Baechle=22=20<ralf@linux-m
	ips.org>;
	bh=vKwgj+ZUuHHGblUz09Hyc+6ZekVPHss3LRmLtMGe4dk=;
	b=nenzj3N3T8pwglFHjCQ0D0MwHthZoPL0rjljCO+bzmqZGmHvyPv3606oeh
	AqDkKsRHzwWuVLlotkJgZWa70bb6PddsvRjFydV+2tu6hU4PJ93d4MDsDrt+
	5osxkm5Iq1;
Authentication-Results:	rtp-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/rtpdkim1001 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

> -----Original Message-----
> From: Joseph Myers [mailto:joseph@codesourcery.com] 
> Sent: Thursday, March 05, 2009 1:53 PM
> To: Ralf Baechle
> Cc: David VomLehn (dvomlehn); David Daney; Maciej W. Rozycki; 
> linux-mips@linux-mips.org; libc-ports@sourceware.org; Maciej 
> W. Rozycki; Richard Sandiford
> Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
> 
> On Thu, 5 Mar 2009, Ralf Baechle wrote:
> 
> > stillborn EABI and NUBI variants.  Add various Linux and 
> GNU specific
> > enhancements and deviations from the previously mentioned 
> documents for
> > example for TLS.  Frequently the documentation really is 
> just in the code,
> > a mailing list archive or in the back of somebody's brain ...
> 
> (Although it took a while for the documentation to catch up with the 
> implementation and changes made in the course of patch 
> review, as far as I 
> know <http://www.linux-mips.org/wiki/NPTL> is now an accurate 
> description 
> of TLS for MIPS.)
> 
> > Somebody could probably earn a medal by writing a single 
> consolidated
> > and readable piece of documentation.
> 
> Anyone seriously wishing to produce a complete and current and 
> copyright-clean description of what the MIPS ABIs now are 
> might wish to 
> note that a similar project for (32-bit) Power Architecture 
> has been going 
> on since late 2006 and we still haven't quite got to the point of 
> releasing a public review draft.  There is a lot of work involved.

I spent two years as Chair of the MIPS ABI Group Technical Committee
working on the MIPS psABI and I can attest to how much work it is.
Still, if there were enough of people involved from the kernel,
compiler/library, and appropriate utility communities willing to try to
pull things together, I could see spending time on it.
