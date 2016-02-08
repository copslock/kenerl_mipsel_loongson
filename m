Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 00:36:44 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:59525 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012296AbcBHXgnXJIg8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 00:36:43 +0100
Received: from akpm3.mtv.corp.google.com (unknown [104.132.0.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3D4D0E53;
        Mon,  8 Feb 2016 23:36:36 +0000 (UTC)
Date:   Mon, 8 Feb 2016 15:36:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Decotigny <ddecotig@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mips@linux-mips.org,
        fcoe-devel@open-fcoe.org, Tejun Heo <tj@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Decotigny <decot@googlers.com>
Subject: Re: [PATCH net-next v7 01/19] lib/bitmap.c: conversion routines
 to/from u32 array
Message-Id: <20160208153635.67df5ac2576138088a859087@linux-foundation.org>
In-Reply-To: <1454893743-6285-2-git-send-email-ddecotig@gmail.com>
References: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
        <1454893743-6285-2-git-send-email-ddecotig@gmail.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Sun,  7 Feb 2016 17:08:45 -0800 David Decotigny <ddecotig@gmail.com> wrote:

> From: David Decotigny <decot@googlers.com>
> 
> Aimed at transferring bitmaps to/from user-space in a 32/64-bit agnostic
> way.
> 
> Tested:
>   unit tests (next patch) on qemu i386, x86_64, ppc, ppc64 BE and LE,
>   ARM.
> 
> @@ -1060,6 +1062,90 @@ int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
>  EXPORT_SYMBOL(bitmap_allocate_region);
>  
>  /**
> + * bitmap_from_u32array - copy the contents of a u32 array of bits to bitmap
> + *	@bitmap: array of unsigned longs, the destination bitmap, non NULL
> + *	@nbits: number of bits in @bitmap
> + *	@buf: array of u32 (in host byte order), the source bitmap, non NULL
> + *	@nwords: number of u32 words in @buf
> + *
> + * copy min(nbits, 32*nwords) bits from @buf to @bitmap, remaining
> + * bits between nword and nbits in @bitmap (if any) are cleared. In
> + * last word of @bitmap, the bits beyond nbits (if any) are kept
> + * unchanged.
> + */

This will leave the caller not knowing how many valid bits are actually
present in the resulting bitmap.  To determine that, the caller will
need to perform (duplicated) math on `nbits' and `nwords'.

> +void bitmap_from_u32array(unsigned long *bitmap, unsigned int nbits,
> +			  const u32 *buf, unsigned int nwords)

So how about we make this return the number of valid bits in *bitmap?

> +/**
> + * bitmap_to_u32array - copy the contents of bitmap to a u32 array of bits
> + *	@buf: array of u32 (in host byte order), the dest bitmap, non NULL
> + *	@nwords: number of u32 words in @buf
> + *	@bitmap: array of unsigned longs, the source bitmap, non NULL
> + *	@nbits: number of bits in @bitmap
> + *
> + * copy min(nbits, 32*nwords) bits from @bitmap to @buf. Remaining
> + * bits after nbits in @buf (if any) are cleared.
> + */
> +void bitmap_to_u32array(u32 *buf, unsigned int nwords,
> +			const unsigned long *bitmap, unsigned int nbits)

Ditto.
