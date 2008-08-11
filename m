Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2008 00:19:29 +0100 (BST)
Received: from sj-iport-2.cisco.com ([171.71.176.71]:28641 "EHLO
	sj-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28591036AbYHKXTY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Aug 2008 00:19:24 +0100
X-IronPort-AV: E=Sophos;i="4.32,192,1217808000"; 
   d="scan'208";a="74204059"
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-2.cisco.com with ESMTP; 11 Aug 2008 23:19:05 +0000
Received: from sj-core-3.cisco.com (sj-core-3.cisco.com [171.68.223.137])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id m7BNJ5XA021386;
	Mon, 11 Aug 2008 16:19:05 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-3.cisco.com (8.13.8/8.13.8) with ESMTP id m7BNJ5Kq010693;
	Mon, 11 Aug 2008 23:19:05 GMT
Received: from [127.0.0.1] ([64.101.20.200]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id XAA00764; Mon, 11 Aug 2008 23:19:04 GMT
Message-ID: <48A0C8E7.6080506@cisco.com>
Date:	Mon, 11 Aug 2008 16:19:03 -0700
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	jfraser@broadcom.com
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	michael.sundius@sciatl.com
Subject: Re: Anyone noticed that there are a lot of cache flushes after kunmap/kunmap_atomic
 is called?
References: <489A5975.1000401@cisco.com> <20080808082404.GA27519@linux-mips.org> <1218206499.20791.152.camel@chaos.ne.broadcom.com>
In-Reply-To: <1218206499.20791.152.camel@chaos.ne.broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=811; t=1218496745; x=1219360745;
	c=relaxed/simple; s=sjdkim4002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20Anyone=20noticed=20that=20there=20are=2
	0a=20lot=20of=20cache=20flushes=20after=20kunmap/kunmap_atom
	ic=0A=20is=20called?
	|Sender:=20;
	bh=YWJB99ODmosBVmb5EqmSa6QtO8Rq8I+sc/suC7/NWb4=;
	b=D538ufA7PLxROvSp4JKKuoz5Fo8EmgiYg87UBhi6711wBif+cajnzuWwRy
	+k3uaxVZJ6ThjWvoMKgFCvMaP0mrmBaKxzbRZFYjOLW5Ng08hGB1BkbFlKMX
	m/wCqdF5tL;
Authentication-Results:	sj-dkim-4; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Jon Fraser wrote:
> David,
> 
>   I'm battling this now.  Our mips 24k has a virtually indexed cache.
> We're definitely seeing issues where the cache hasn't been flushed
> for highmem pages.  I thought I had this fixed, but I'm still seeing
> some problems.

As I understand it, you have the most difficult combination of things:
o You are using high memory
o You have a virtually indexed cache
o You have data cache aliases

Fortunately, we have only the first two of those in our system. We should 
probably put together a coherent set of patches for people who want high memory. 
So far as I can tell, the 32-bit MIPS architecture has a long way to go before it 
runs out of steam in the embedded world. I expect more people will need MIPS 
highmem support in the next few years.

David
