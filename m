Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 23:41:47 +0000 (GMT)
Received: from p508B7C81.dip.t-dialin.net ([80.139.124.129]:2216 "EHLO
	p508B7C81.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225241AbSLKXlr>; Wed, 11 Dec 2002 23:41:47 +0000
Received: from mallaury.noc.nerim.net ([IPv6:::ffff:62.4.17.82]:12305 "EHLO
	mallaury.noc.nerim.net") by ralf.linux-mips.org with ESMTP
	id <S868621AbSLKXlq>; Thu, 12 Dec 2002 00:41:46 +0100
Received: from melkor (vivienc.net1.nerim.net [213.41.134.233])
	by mallaury.noc.nerim.net (Postfix) with ESMTP
	id 5DA7062F00; Thu, 12 Dec 2002 00:41:42 +0100 (CET)
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.36 #1 (Debian))
	id 18MGU8-00029Z-00; Thu, 12 Dec 2002 00:41:48 +0100
Date: Thu, 12 Dec 2002 00:41:48 +0100 (CET)
From: Vivien Chappelier <vivienc@nerim.net>
X-Sender: glaurung@melkor
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Ilya Volynets <ilya@theIlya.com>
Subject: Re: [PATCH 2.5] SGI O2 framebuffer driver
In-Reply-To: <1039648548.18587.52.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0212120004330.2300-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <vivienc@nerim.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vivienc@nerim.net
Precedence: bulk
X-list: linux-mips

On 11 Dec 2002, Alan Cox wrote:

> Since vmalloc is physically non linear is there any reason you can't
> just use get_free_page() a lot ?

I'm not using vmalloc directly. I'm indeed using many get_free_pages of 64kB,
as the O2 FB device has a TLB of it's own and can handle a non physically
linear framebuffer (up to 8MB with 64kB granularity). I'm then remapping
all those pages to one virtual region obtained from get_vm_area so that
1. caching attributes can be set to cacheable write-through no WA
2. the fbcon-cfb* code can be used as it sees the framebuffer as linear.
3. 64kB chuncks can be dynamically allocated and freed depending on the
framebuffer resolution, keeping memory optimally shared between apps and
framebuffer (compared to the static bootmem allocation).

However, as it is implemented currently, there are only 1024 kernel
virtual->physical mappings available (include/asm-mips64/pgtable.h),
that is only 4MB can be mapped. Maybe something like fixmap would help
but it's not yet there for mips64.

regards,
Vivien.
