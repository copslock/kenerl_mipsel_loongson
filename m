Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Feb 2008 21:07:06 +0000 (GMT)
Received: from sj-iport-4.cisco.com ([171.68.10.86]:42971 "EHLO
	sj-iport-4.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28586490AbYBZVHE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Feb 2008 21:07:04 +0000
X-IronPort-AV: E=Sophos;i="4.25,409,1199692800"; 
   d="scan'208";a="7195959"
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-4.cisco.com with ESMTP; 26 Feb 2008 13:06:57 -0800
Received: from sj-core-3.cisco.com (sj-core-3.cisco.com [171.68.223.137])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id m1QL6vgL013877
	for <linux-mips@linux-mips.org>; Tue, 26 Feb 2008 13:06:57 -0800
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-3.cisco.com (8.12.10/8.12.6) with ESMTP id m1QL6uJ9004630
	for <linux-mips@linux-mips.org>; Tue, 26 Feb 2008 21:06:56 GMT
Received: from [127.0.0.1] ([64.100.148.129]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id VAA03330 for <linux-mips@linux-mips.org>; Tue, 26 Feb 2008 21:06:55 GMT
Message-ID: <47C47F6D.7070305@cisco.com>
Date:	Tue, 26 Feb 2008 13:06:53 -0800
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Does HIGHMEM work on 32-bit MIPS ports?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1063; t=1204060017; x=1204924017;
	c=relaxed/simple; s=sjdkim2002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20Does=20HIGHMEM=20work=20on=2032-bit=20M
	IPS=20ports?
	|Sender:=20;
	bh=XunnJNi9gBvw6oLEjE+8SnH79ArU+Zed4tfQjeuCvP4=;
	b=UcwjtCKTzRHfTcC4cMptw2TrabKJMz6ZWc9Og7xdmYygJJG1hq6RKqSKoS
	OAFkxPx7ALwfKoD5znrmciltFkkMM8d3S4kOQGiSMEVyF5tgz/EXeVh5JH8N
	wV0FnGiNMF;
Authentication-Results:	sj-dkim-2; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

> On Wed, 20 Feb 2008, David VomLehn wrote:
>
> > Hmm, this is not good. I've got a MIPS 24Kc processor with a very
> > awkward memory layout. Any hints?
>
>  What does it mean "very awkward"?  What sort of problems do you have 
> that you are trying to solve?
>
>   Maciej
Specifically, we have two banks of memory. The first starts at 
0x10000000, which is no big deal (other than wasting the page map 
entries for the first chunk of memory). The second starts at 0x60000000, so:

   1. We have to access it with high memory, and
   2. There is a huge section of unused page map entries.

As it turns out, it is starting to look like we're making progress with 
the problem with high memory: In __flush_dcache_page, nothing is done if 
PageHighMem() returns true. Not surprisingly, this leads to Bad 
Things(tm). What we are working through now is making sure that we 
understand exactly what *should* be happening.

-- 
David VomLehn, dvomlehn@cisco.com
The opinions expressed herein are likely mine, but might not be my employer's...
