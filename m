Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2009 21:46:40 +0000 (GMT)
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:31021 "EHLO
	rtp-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S21365904AbZAPVqh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Jan 2009 21:46:37 +0000
X-IronPort-AV: E=Sophos;i="4.37,278,1231113600"; 
   d="scan'208";a="34065900"
Received: from rtp-dkim-2.cisco.com ([64.102.121.159])
  by rtp-iport-1.cisco.com with ESMTP; 16 Jan 2009 21:46:30 +0000
Received: from rtp-core-2.cisco.com (rtp-core-2.cisco.com [64.102.124.13])
	by rtp-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id n0GLkUE0019361
	for <linux-mips@linux-mips.org>; Fri, 16 Jan 2009 16:46:30 -0500
Received: from sausatlsmtp1.sciatl.com (sausatlsmtp1.cisco.com [192.133.217.33])
	by rtp-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id n0GLkU3m007724
	for <linux-mips@linux-mips.org>; Fri, 16 Jan 2009 21:46:30 GMT
Received: from default.com ([192.133.217.33]) by sausatlsmtp1.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Jan 2009 16:46:27 -0500
Received: from sausatlbhs02.corp.sa.net ([192.133.216.42]) by sausatlsmtp1.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Jan 2009 16:46:24 -0500
Received: from CUPLXSUNDISM01.corp.sa.net ([64.101.21.60]) by sausatlbhs02.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Jan 2009 16:46:24 -0500
Message-ID: <4971002D.2090907@cisco.com>
Date:	Fri, 16 Jan 2009 13:46:21 -0800
From:	Michael Sundius <msundius@cisco.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Christoph Lameter <cl@linux-foundation.org>
CC:	Dave Hansen <dave@linux.vnet.ibm.com>,
	Randy Dunlap <rdunlap@xenotime.net>,
	"Sundius, Michael" <Michael.sundius@sciatl.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mm@kvack.org, linux-mips@linux-mips.org,
	jfraser@broadcom.com, Andy Whitcroft <apw@shadowen.org>,
	msundius@sundius.com
Subject: Re: sparsemem support for mips with highmem
References: <48A4AC39.7020707@sciatl.com>	<1218753308.23641.56.camel@nimitz>	 <48A4C542.5000308@sciatl.com>	<20080815080331.GA6689@alpha.franken.de>	 <1218815299.23641.80.camel@nimitz>	<48A5AADE.1050808@sciatl.com>	 <20080815163302.GA9846@alpha.franken.de>	<48A5B9F1.3080201@sciatl.com>	 <1218821875.23641.103.camel@nimitz>	<48A5C831.3070002@sciatl.com>	 <20080818094412.09086445.rdunlap@xenotime.net>	 <48A9E89C.4020408@linux-foundation.org> <1219094865.23641.118.camel@nimitz> <48A9EAA9.1080909@linux-foundation.org>
In-Reply-To: <48A9EAA9.1080909@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jan 2009 21:46:24.0324 (UTC) FILETIME=[E08C2840:01C97823]
X-ST-MF-Message-Resent:	1/16/2009 16:46
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=2460; t=1232142390; x=1233006390;
	c=relaxed/simple; s=rtpdkim2001;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=msundius@cisco.com;
	z=From:=20Michael=20Sundius=20<msundius@cisco.com>
	|Subject:=20Re=3A=20sparsemem=20support=20for=20mips=20with
	=20highmem
	|Sender:=20
	|To:=20Christoph=20Lameter=20<cl@linux-foundation.org>;
	bh=okOxMMyILXhoHPpyJ22h2rSlK4WI+Fu9ej9H9Pb4gSw=;
	b=nqLHTii4OXSx9+1HNnhLebvVIoyuzwbvzH+jEE/rcazDXBUsd0C2+/a+rE
	Tduh7QlMkvOEsOwTz9cNOf2G1C+Bz0RP9M52hIw3zygb5gIbTKntIKU8Snni
	IWcE/jmBz/;
Authentication-Results:	rtp-dkim-2; header.From=msundius@cisco.com; dkim=pass (
	sig from cisco.com/rtpdkim2001 verified; ); 
Return-Path: <msundius@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: msundius@cisco.com
Precedence: bulk
X-list: linux-mips

Christoph Lameter wrote:
>
> Dave Hansen wrote:
> > On Mon, 2008-08-18 at 16:24 -0500, Christoph Lameter wrote:
> >> This overhead can be avoided by configuring sparsemem to use a 
> virtual vmemmap
> >> (CONFIG_SPARSEMEM_VMEMMAP). In that case it can be used for non 
> NUMA since the
> >> overhead is less than even FLATMEM.
> >
> > Is that all it takes these days, or do you need some other arch-specific
> > code to help out?
>
> Some information is in mm/sparse-vmemmap.c. Simplest configuration is 
> to use
> vmalloc for the populate function. Otherwise the arch can do what it 
> wants to
> reduce the overhead of virtual mappings (in the x86 case we use a 2M TLB
> entry, and since 2M TLBs are also used for the 1-1 physical mapping the
> overhead is the same as for 1-1 mappings).
>
>
Well, I finally gotten around to turning the vmemmap on for our 
sparsemem on Mips.

I have a question about what you said above and how that applies to mips.

you said that the simplest configuration is to use vmalloc for the 
populate function.
could you expand on that? (i didn't see that the populate function used 
vmalloc or maybe
we are talking about a different populate function).

I've noticed that from looking at the kernel, only 64 bit processors or 
at least processors
that use a 3 level page table have the vmemmap_populate() function 
implemented.

in looking at the function vmemmap_populate_basepages() (called by most 
vmemmap_populate funcs)
it seems to create a 3 level
page table. not sure what my question here is, but maybe what do I have 
to do to make
this work w/ mips which i understand uses only 2 levels can I just take 
out the part of
the function that sets up the middle level table?

Has anyone done this on mips?

mike





     - - - - -                              Cisco                            - - - - -         
This e-mail and any attachments may contain information which is confidential, 
proprietary, privileged or otherwise protected by law. The information is solely 
intended for the named addressee (or a person responsible for delivering it to 
the addressee). If you are not the intended recipient of this message, you are 
not authorized to read, print, retain, copy or disseminate this message or any 
part of it. If you have received this e-mail in error, please notify the sender 
immediately by return e-mail and delete it from your computer.
