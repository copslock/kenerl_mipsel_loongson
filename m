Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2016 15:48:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27567 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993008AbcKNOsIpEHN2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Nov 2016 15:48:08 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 071FA188127E0;
        Mon, 14 Nov 2016 14:47:59 +0000 (GMT)
Received: from [10.20.78.88] (10.20.78.88) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Mon, 14 Nov 2016
 14:48:00 +0000
Date:   Mon, 14 Nov 2016 14:47:53 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 6/7] MIPS: memcpy: Use a3/$7 for source end address
In-Reply-To: <20161107111802.12071-7-paul.burton@imgtec.com>
Message-ID: <alpine.DEB.2.20.17.1611141435170.10580@tp.orcam.me.uk>
References: <20161107111802.12071-1-paul.burton@imgtec.com> <20161107111802.12071-7-paul.burton@imgtec.com>
User-Agent: Alpine 2.20.17 (DEB 179 2016-10-28)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.88]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, 7 Nov 2016, Paul Burton wrote:

> Instead of using the at/$1 register (which does not form part of the
> typical calling convention) to provide the end of the source region to
> __copy_user* functions, use the a3/$7 register. This prepares us for
> being able to call __copy_user* with a standard function call.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
> 
>  arch/mips/cavium-octeon/octeon-memcpy.S |  8 ++++----
>  arch/mips/include/asm/uaccess.h         | 21 ++++++++++++---------
>  arch/mips/lib/memcpy.S                  |  8 ++++----
>  3 files changed, 20 insertions(+), 17 deletions(-)
> 
[...]
> diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
> index 48684c4..5af9f03 100644
> --- a/arch/mips/lib/memcpy.S
> +++ b/arch/mips/lib/memcpy.S
> @@ -70,13 +70,13 @@
>  
>  /*
>   * The exception handler for loads requires that:
> - *  1- AT contain the address of the byte just past the end of the source
> + *  1- a3 contain the address of the byte just past the end of the source
>   *     of the copy,
> - *  2- src_entry <= src < AT, and
> + *  2- src_entry <= src < a3, and
>   *  3- (dst - src) == (dst_entry - src_entry),
>   * The _entry suffix denotes values when __copy_user was called.
>   *
> - * (1) is set up up by uaccess.h and maintained by not writing AT in copy_user
> + * (1) is set up up by uaccess.h and maintained by not writing a3 in copy_user
>   * (2) is met by incrementing src by the number of bytes copied
>   * (3) is met by not doing loads between a pair of increments of dst and src
>   *
> @@ -549,7 +549,7 @@
>  	 nop
>  	LOADK	t0, THREAD_BUADDR(t0)	# t0 is just past last good address
>  	 nop
> -	SUB	len, AT, t0		# len number of uncopied bytes
> +	SUB	len, a3, t0		# len number of uncopied bytes
>  	bnez	ta2, .Ldone\@	/* Skip the zeroing part if inatomic */
>  	/*
>  	 * Here's where we rely on src and dst being incremented in tandem,

 With the lone explicit use of $at gone from this code I think you can 
remove `.set noat/at=v1' pseudo-ops across this source file as well.

 I think it would be good actually to do both changes with a single patch 
as it will ensure that whoever comes across them in the future in a look 
through our repo history will know immediately that one is a direct 
consequence of the other (i.e. that we only have those `.set noat/at=v1' 
pseudo-ops because of the special use of $at in this code).

 Thanks for doing these clean-ups; I actually have found this use of $at 
here particularly irritating.

  Maciej
