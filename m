Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 03:59:48 +0200 (CEST)
Received: from jeeves.momenco.com ([64.169.228.99]:35858 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1122987AbSIRB7r>; Wed, 18 Sep 2002 03:59:47 +0200
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g8I1xd604821;
	Tue, 17 Sep 2002 18:59:39 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Matthew Dharm" <mdharm@momenco.com>,
	"Linux-MIPS" <linux-mips@linux-mips.org>
Subject: RE: bug with 512MB of RAM?
Date: Tue, 17 Sep 2002 18:59:39 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAIOEAKCJAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIAEPPCIAA.mdharm@momenco.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Return-Path: <mdharm@momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

So, I went digging into this....

It seems that the RM7k cache routines for DMA managment don't like it
if the addr+size runs up to the end of kseg0 (addr 0xa0000000).  A
quick if() to test the 'end' variable in c-rm7k.c and make sure we
never call {flush|invalidate}_{s|d}cache_line() with an address in
kseg1 makes boards with 512MByte of memory work.

Of course, this has me wondering how CONFIG_HIGHMEM works... from a
quick scan of mm/init.c, it looks like DMA-able memory is only
allocated out of kseg0... but I'm not a memory-management expert.
Actually, I'm something of a rookie here... I'm trying to wrap my
brain around the concept of 'zones', and it looks like everything
should 'just work'....

But I'm wondering if:
(a) Someone will confirm my analysis that DMA-able memory is allocated
with kseg0 addresses, thus no 'highmem' will be used
(b) Someone has a primer on the memory-managment system?

If I'm right, I'll be submitting a patch to fix c-rm7k.c for 2.4 and
2.5

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Matthew Dharm
> Sent: Monday, September 16, 2002 2:36 PM
> To: Linux-MIPS
> Subject: bug with 512MB of RAM?
>
>
> A long time ago, there was a bug somewhere that only affected boards
> with 512MB of memory with RM7000 processors.  Apparently, there were
> problems in the cache-managment code causing a problem working with
> memory near the end of kseg0.  I don't recall all the details -- by
> the time I got to looking at it the first time, someone
> already had a
> fix.
>
> I was told this was fixed... but I'm seeing some symptoms that this
> was not fixed.  Does anyone actually recall if this was
> fixed or not?
> If it was, I need to look elsewhere.  But, if it wasn't actually
> fixed....
>
> Matt
>
> --
> Matthew D. Dharm                            Senior Software Designer
> Momentum Computer Inc.                      1815 Aston Ave.
>  Suite 107
> (760) 431-8663 X-115                        Carlsbad, CA 92008-7310
> Momentum Works For You                      www.momenco.com
>
>
