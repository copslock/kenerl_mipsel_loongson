Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Nov 2002 23:30:22 +0100 (CET)
Received: from gateway-1237.mvista.com ([12.44.186.158]:49658 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1123920AbSKFWaV>;
	Wed, 6 Nov 2002 23:30:21 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gA6MTsN15929;
	Wed, 6 Nov 2002 14:29:54 -0800
Date: Wed, 6 Nov 2002 14:29:54 -0800
From: Jun Sun <jsun@mvista.com>
To: "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>
Cc: "'Ralf Baechle'" <ralf@linux-mips.org>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>,
	jsun@mvista.com
Subject: Re: NFS Root failure in 2.4.18 - Traced to 256k COLOUR_ALIGN
Message-ID: <20021106142954.C15363@mvista.com>
References: <CBD6266EA291D5118144009027AA63350A68F189@xboi05.boi.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <CBD6266EA291D5118144009027AA63350A68F189@xboi05.boi.hp.com>; from roger_twede@hp.com on Fri, Nov 01, 2002 at 01:28:32PM -0800
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Nov 01, 2002 at 01:28:32PM -0800, TWEDE,ROGER (HP-Boise,ex1) wrote:
> 
> Several questions that arise:
> - In the nfs case, should the file structure have its
> file->f_op->get_unmapped_area() member assigned, causing a file specific
> get_unmapped_area to be called instead of this arch_get_unmapped_area?

Don't really know about this question.

But in general if the pages are going to be shared, you will hit cache 
aliasing problem.  Then you need to implement something like cache 
coloring, which must be an unique one for the whole system, which naturally
means you need to use arch_get_unmapped_area().

> - Or should the mapping request pass in a requested address which already
> has valid 256k alignment?

Not necessarily, as long as caller is prepared for a possibly different
return value.

> - Or should requested addresses that are misaligned be handled well by the
> calling code once the translated/aligned address is returned to the calller?
>

I don't think so.

 
> And generally:
> - Why does nfsroot booting cause apecific non-zero virtual addresses to be
> requested, whereas in the ide disk booting case, addressed are left
> unspecified (0x0) (no requested mapping)?
>

I am curious too.  At least it should move along fine once it is given the
the new aligned address.

Jun
