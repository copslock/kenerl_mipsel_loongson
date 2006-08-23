Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2006 17:23:33 +0100 (BST)
Received: from web31507.mail.mud.yahoo.com ([68.142.198.136]:41909 "HELO
	web31507.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20037639AbWHWQXb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Aug 2006 17:23:31 +0100
Received: (qmail 43029 invoked by uid 60001); 23 Aug 2006 16:23:24 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=oSG0S88rt9gxZLE3D+jaNmQZhQt+ck7/N/axhK3bM5TLA6kltd34bT/x541p0o4oFVrGyZf4Hirhm5nsjPhwg2tvPw1Wp4IU57zK1MDLXZq5iTpuIb6mmz1jHM0OHjhwl4AjZ0J1dgFb9M/Q0bMef4rUNOfE7C5jv4y9cvsSG3E=  ;
Message-ID: <20060823162324.43027.qmail@web31507.mail.mud.yahoo.com>
Received: from [70.103.67.194] by web31507.mail.mud.yahoo.com via HTTP; Wed, 23 Aug 2006 09:23:24 PDT
Date:	Wed, 23 Aug 2006 09:23:24 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Re: [PATCH] 64K page size
To:	Thiemo Seufer <ths@networkno.de>,
	Peter Watkins <treestem@gmail.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <20060823160011.GE20395@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

I am extremely interested in big pages (64K, etc), and
the sooner the better. If there is anything not
considered OK for immediate inclusion in the Linux
MIPS git tree, I would love to have a copy anyway.
Large pages will be necessary for some high-priority
work I'm doing, although stability at this point seems
to be an optional extra. (Hence why the patches are
much more important than whether they're actually
finished yet.)

Jonathan

--- Thiemo Seufer <ths@networkno.de> wrote:

> Peter Watkins wrote:
> > Hello,
> > 
> > There are a number of changes required to support
> larger page sizes, but 
> > this one I thought worth sending up right away.
> > 
> > The code in pgtable-64.h assumes TASK_SIZE is
> always bigger than a first 
> > level PGDIR_SIZE. This is not the case for 64K
> pages, where task size is 
> > 40 bits (1TB) and a pgd entry can map 42 bits.
> This leads to 
> > USER_PTRS_PER_PGD being zero for 64K pages.
> > 
> > If there is interest in other changes for 64K
> pages, I can send more.
> 
> Please do so. :-)
> 
> 
> Thiemo
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
