Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 15:16:20 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.191]:8132 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037784AbWJKOQO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Oct 2006 15:16:14 +0100
Received: by nf-out-0910.google.com with SMTP id a25so197364nfc
        for <linux-mips@linux-mips.org>; Wed, 11 Oct 2006 07:16:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=OrdZMahQLd2h1zq2hBR2/Pn1LOTUMRBaWjvOjp6SfjzD3bV6HSG4bOcfb+ZCEKm08tbt9G5AnBbKt1bGNDNidJbQZlgNVuFcVkP6/QTYqXLrTf8ECvA8XcDXVdbLpmSDNVoDsG4Z7fLXrJhpv0DhvgaOonwVDbqOHnQOUvjk1BQ=
Received: by 10.48.254.10 with SMTP id b10mr3251032nfi;
        Wed, 11 Oct 2006 07:15:56 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id x24sm118827nfb.2006.10.11.07.15.55;
        Wed, 11 Oct 2006 07:15:56 -0700 (PDT)
Message-ID: <452CFC95.1080806@innova-card.com>
Date:	Wed, 11 Oct 2006 16:15:49 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org, ths@networkno.de,
	linux-mips@linux-mips.org, fbuihuu@gmail.com
Subject: Re: [PATCH 1/5] Make __pa() uses CPHYSADDR() if really needed
References: <1160568525897-git-send-email-fbuihuu@gmail.com>	<11605685251014-git-send-email-fbuihuu@gmail.com> <20061011.223352.126573442.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061011.223352.126573442.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

Atsushi Nemoto wrote:
> On Wed, 11 Oct 2006 14:08:41 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> -#define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
>> +#if defined(CONFIG_64BITS) && !defined(CONFIG_BUILD_ELF64)
>> +#define __pa(x)			CPHYSADDR(x)
>> +#else
>> +#define __pa(x)			((unsigned long)(x) - PAGE_OFFSET)
>> +#endif
>>  #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
> 
> Please do not do this.  CONFIG_BUILD_ELF64=n does not mean we only
> have less then 512MB memory.  We can have large flat area at
> PAGE_OFFSET (0x9800000000000000) in 64-bit kernel, so __pa() should
> accepct a value such as 0x9800000020000000.
> 

To deal with such address there's virt_to_phys() routine. __pa() is
normally used during early bootmem init (as CPHYSADDR(), BTW). At early
bootmem, we normally deal with address in KSEG0. Once we have switched
to XKPHYS address, I agree we should use virt_to_phys().

If we look at how to convert a virtual address into a physical one,
we have:

	CPHYSADDR()
	__pa()
	virt_to_phys()

What definition would you give to each of them ?

BTW, if you grep for __pa() you'll notice that it's almost not used
by the kernel. I suspect that's because of CPHYSADDR() existence which
is really confusing.

		Franck
