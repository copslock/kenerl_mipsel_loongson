Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Oct 2002 12:18:22 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:9639 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123891AbSJAKSW>;
	Tue, 1 Oct 2002 12:18:22 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g91AICrZ001889;
	Tue, 1 Oct 2002 03:18:12 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA20712;
	Tue, 1 Oct 2002 03:17:48 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g91AHIb02750;
	Tue, 1 Oct 2002 12:17:21 +0200 (MEST)
Message-ID: <3D99762D.4E6A7F85@mips.com>
Date: Tue, 01 Oct 2002 12:17:17 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Murphy <brian@murphy.dk>
CC: linux-mips <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2.4] Re: ide-dma bug (cache flushing)
References: <3D7FAB4A.4010802@murphy.dk> <3D80F5CF.1040905@murphy.dk>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Ralf, could you please apply the patch below.
Please also apply it to include/asm-mips64/pci.h (the 64-bit version).

/Carsten



Brian Murphy wrote:

> It seems like this problem is (yet again) caused by lack of cache flushing.
> The attached patch adds a  dma_cache_wback_inv to pci_map_sg in pci.h
> to the if fork in which sg->address is not set.
>
> This fixes my problem.
>
> Can someone with commit access please apply this patch?
>
> /Brian
>
>   ------------------------------------------------------------------------
> Index: include/asm-mips/pci.h
> ===================================================================
> RCS file: /cvs/linux-mips/include/asm-mips/pci.h,v
> retrieving revision 1.1.1.2
> diff -u -r1.1.1.2 pci.h
> --- include/asm-mips/pci.h      19 Aug 2002 18:00:29 -0000      1.1.1.2
> +++ include/asm-mips/pci.h      12 Sep 2002 20:06:31 -0000
> @@ -200,9 +200,13 @@
>                         dma_cache_wback_inv((unsigned long)sg->address,
>                                             sg->length);
>                         sg->dma_address = bus_to_baddr(hwdev, __pa(sg->address));
> -               } else
> +               } else {
>                         sg->dma_address = page_to_bus(sg->page) +
>                                           sg->offset;
> +                       dma_cache_wback_inv(
> +                               (unsigned long)(page_address(sg->page)+
> +                                               sg->offset), sg->length);
> +               }
>         }
>
>         return nents;

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
