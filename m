Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2003 23:53:00 +0100 (BST)
Received: from [IPv6:::ffff:66.121.16.190] ([IPv6:::ffff:66.121.16.190]:12210
	"EHLO trid-mail1.tridentmicro.com") by linux-mips.org with ESMTP
	id <S8225214AbTGYWw6> convert rfc822-to-8bit; Fri, 25 Jul 2003 23:52:58 +0100
content-class: urn:content-classes:message
Subject: RE: mmap'ed memory cacheable or uncheable
Date: Fri, 25 Jul 2003 15:52:33 -0700
Message-ID: <61F6477DE6BED311B69F009027C3F58403AA396F@EXCHANGE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mmap'ed memory cacheable or uncheable
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Thread-Index: AcNS+GFAtXxthcdyRB2ywR1T0NJ4DAABsVlA
From: "Teresa Tao" <Teresat@tridentmicro.com>
To: "Jun Sun" <jsun@mvista.com>,
	"Teresa Tao" <Teresat@tridentmicro.com>
Cc: <linux-mips@linux-mips.org>
Return-Path: <Teresat@tridentmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Teresat@tridentmicro.com
Precedence: bulk
X-list: linux-mips

How about if I specify the following flags in my mmap routine just like what the pgprot_noncached micro did.
	pgprot_val(vma->vm_page_prot) &= ~_CACHE_MASK;
	pgprot_val(vma->vm_page_prot) |= _CACHE_UNCACHED;

Will this have kernel make the mmap'd memory non-cacheable? Or is there a mmap non-cacheable patch?

Thanks in advance!

Teresa



-----Original Message-----
From: Jun Sun [mailto:jsun@mvista.com]
Sent: Friday, July 25, 2003 3:02 PM
To: Teresa Tao
Cc: linux-mips@linux-mips.org; jsun@mvista.com
Subject: Re: mmap'ed memory cacheable or uncheable


On Thu, Jul 24, 2003 at 08:26:59PM -0700, Teresa Tao wrote:
> Hi there,
> 
> I got a question regarding the mmap'ed memory. Is the mmap'ed memory cacheable or uncheable? My driver just use the remap_page_range to map a reserved physical memory.
>

I am pretty much sure it is cached, although I can't pin down exactly
where in the mm subsystem it does so - I have had cache bugs related
to mmap().

Jun
