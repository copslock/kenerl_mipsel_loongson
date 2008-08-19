Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2008 00:40:16 +0100 (BST)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:61103 "EHLO
	sj-iport-5.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28581510AbYHSXkK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Aug 2008 00:40:10 +0100
X-IronPort-AV: E=Sophos;i="4.32,238,1217808000"; 
   d="scan'208";a="42294996"
Received: from sj-dkim-3.cisco.com ([171.71.179.195])
  by sj-iport-5.cisco.com with ESMTP; 19 Aug 2008 23:40:01 +0000
Received: from sj-core-3.cisco.com (sj-core-3.cisco.com [171.68.223.137])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id m7JNe1PT030225;
	Tue, 19 Aug 2008 16:40:01 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-3.cisco.com (8.13.8/8.13.8) with ESMTP id m7JNe1da019420;
	Tue, 19 Aug 2008 23:40:01 GMT
Received: from [127.0.0.1] ([64.101.20.200]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id XAA19070; Tue, 19 Aug 2008 23:39:22 GMT
Message-ID: <48AB5959.6090609@cisco.com>
Date:	Tue, 19 Aug 2008 16:38:01 -0700
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Christoph Lameter <cl@linux-foundation.org>
CC:	Randy Dunlap <rdunlap@xenotime.net>,
	C Michael Sundius <Michael.sundius@sciatl.com>,
	Dave Hansen <dave@linux.vnet.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mm@kvack.org, linux-mips@linux-mips.org,
	jfraser@broadcom.com, Andy Whitcroft <apw@shadowen.org>
Subject: Re: sparsemem support for mips with highmem
References: <48A4AC39.7020707@sciatl.com>	<1218753308.23641.56.camel@nimitz>	<48A4C542.5000308@sciatl.com>	<20080815080331.GA6689@alpha.franken.de>	<1218815299.23641.80.camel@nimitz>	<48A5AADE.1050808@sciatl.com>	<20080815163302.GA9846@alpha.franken.de>	<48A5B9F1.3080201@sciatl.com>	<1218821875.23641.103.camel@nimitz>	<48A5C831.3070002@sciatl.com> <20080818094412.09086445.rdunlap@xenotime.net> <48A9E89C.4020408@linux-foundation.org> <48A9F047.7050906@cisco.com> <48AAC54D.8020609@linux-foundation.org>
In-Reply-To: <48AAC54D.8020609@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1811; t=1219189201; x=1220053201;
	c=relaxed/simple; s=sjdkim3002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20sparsemem=20support=20for=20mips=20with
	=20highmem
	|Sender:=20;
	bh=UXuqUmf+il1NZ+BZtKDRhiAyRx/1S8fcPVS42tPhaik=;
	b=Tg/95VJWZDPdB8folyLejXwfApf5XYQ+SfYuWSiAqYByX8DqvPKHwkjA4L
	FA+70/ivEOyXjqlKmzcVEGjY3HUZFZNDta6k8e7iHs/HuhXKP++hbJ6iQsM2
	0I+1Uv6k4l;
Authentication-Results:	sj-dkim-3; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Christoph Lameter wrote:
> David VomLehn wrote:
> 
>> On MIPS processors, the kernel runs in unmapped memory, i.e. the TLB
>> isn't even
>> used, so I don't think you can use that trick. So, this comment doesn't
>> apply to
>> all processors.
> 
> In that case you have a choice between the overhead of sparsemem lookups in
> every pfn_to_page or using TLB entries to create a virtually mapped memmap
> which may create TLB pressure.
> 
> The virtually mapped memmap results in smaller code and is typically more
> effective since the processor caches the TLB entries.

I'm pretty ignorant on this subject, but I think this is worth discussing. On a 
MIPS processor, access to low memory bypasses the TLB entirely. I think what you 
are suggesting is to use mapped addresses to make all of low memory virtually 
contiguous. On a MIPS processor, we could do this by allocating a "wired" TLB 
entry for each physically contiguous block of memory. Wired TLB entries are never 
replaced, so they are very efficient for long-lived mappings such as this. Using 
the TLB in this way does increase TLB pressure, but most platforms probably have 
a very small number of "holes" in their memory. So, this may be a small overhead.

If we took this approach, we could then have a single, simple memmap array where 
pfn_to_page looks just about the same as it looks with a flat memory model.

If I'm understand what you are suggesting correctly (a big if), the downside is 
that we'd pay the cost of a TLB match for each non-cached low memory data access. 
It seems to me that would be a higher cost than having the occasional, more 
expensive, sparsemem lookup in pfn_to_page.

Anyone with more in-depth MIPS processor architecture knowledge care to weigh in 
on this?
--
David VomLehn
