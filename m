Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2014 19:25:54 +0100 (CET)
Received: from mail-ig0-f179.google.com ([209.85.213.179]:52137 "EHLO
        mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816288AbaAUSZvlpTSY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jan 2014 19:25:51 +0100
Received: by mail-ig0-f179.google.com with SMTP id c10so11610693igq.0
        for <multiple recipients>; Tue, 21 Jan 2014 10:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=qTzdaY7r10iP8M3+Fwp8OPqdHpbPLVFfkGtr9HqFaHM=;
        b=fzAOqfNp7IJx+D3q1A1/CmgijC/wfJIuHhZ7D1A3VDHU3gOGBWHHSt+8RNyZNwW5fg
         5DbVavDC0eQ5o991ebZNGEtkXMwm+N/vUifKGAqF82aU7yn8WOk6o9hpFQgHxmCgOxRT
         tUZnl/Wv8/rKEYIBrSa2HUsh2wbKvBUVXOmbRu15aItQ3b9+rtRKXktSNxio7rgUx7HC
         svP8aYC4F1/Uw08D4UCS+pAhzHlFV5fy4d24gYxiqDduCQAZqJsbHiqi3EtbHEO0O060
         r/89j6dJPcwLhsO0cf1RmYJ4RqbYILY2cboZAgEdkNxBZ6XONqeN3iQH8q3C7OdbeaMz
         ydfw==
X-Received: by 10.50.30.166 with SMTP id t6mr19559565igh.7.1390328745076;
        Tue, 21 Jan 2014 10:25:45 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id s4sm38090920ige.0.2014.01.21.10.25.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jan 2014 10:25:44 -0800 (PST)
Message-ID: <52DEBBA6.9070701@gmail.com>
Date:   Tue, 21 Jan 2014 10:25:42 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: lib: Optimize partial checksum ops using prefetching.
References: <1390321122-25634-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1390321122-25634-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 01/21/2014 08:18 AM, Steven J. Hill wrote:
> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>
> Use the PREF instruction to optimize partial checksum operations.
>
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>

NACK.  The proper latench and cacheline stride vary by CPU, you cannot 
just hard code them for 32-byte cacheline size with some random latency.

This will make some CPUs slower.

> ---
>   arch/mips/lib/csum_partial.S | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
> index a6adffb..272820e 100644
> --- a/arch/mips/lib/csum_partial.S
> +++ b/arch/mips/lib/csum_partial.S
> @@ -417,13 +417,19 @@ FEXPORT(csum_partial_copy_nocheck)
>   	 *
>   	 * If len < NBYTES use byte operations.
>   	 */
> +	PREF(	0, 0(src))
> +	PREF(	1, 0(dst))
>   	sltu	t2, len, NBYTES
>   	and	t1, dst, ADDRMASK
>   	bnez	t2, .Lcopy_bytes_checklen
> +	PREF(	0, 32(src))
> +	PREF(	1, 32(dst))
>   	 and	t0, src, ADDRMASK
>   	andi	odd, dst, 0x1			/* odd buffer? */
>   	bnez	t1, .Ldst_unaligned
>   	 nop
> +	PREF(	0, 2*32(src))
> +	PREF(	1, 2*32(dst))
>   	bnez	t0, .Lsrc_unaligned_dst_aligned
>   	/*
>   	 * use delay slot for fall-through
> @@ -434,6 +440,8 @@ FEXPORT(csum_partial_copy_nocheck)
>   	beqz	t0, .Lcleanup_both_aligned # len < 8*NBYTES
>   	 nop
>   	SUB	len, 8*NBYTES		# subtract here for bgez loop
> +	PREF(	0, 3*32(src))
> +	PREF(	1, 3*32(dst))
>   	.align	4
>   1:
>   EXC(	LOAD	t0, UNIT(0)(src),	.Ll_exc)
> @@ -464,6 +472,8 @@ EXC(	STORE	t7, UNIT(7)(dst),	.Ls_exc)
>   	ADDC(sum, t7)
>   	.set	reorder				/* DADDI_WAR */
>   	ADD	dst, dst, 8*NBYTES
> +	PREF(	0, 8*32(src))
> +	PREF(	1, 8*32(dst))
>   	bgez	len, 1b
>   	.set	noreorder
>   	ADD	len, 8*NBYTES		# revert len (see above)
> @@ -569,8 +579,10 @@ EXC(	STFIRST t3, FIRST(0)(dst),	.Ls_exc)
>
>   .Lsrc_unaligned_dst_aligned:
>   	SRL	t0, len, LOG_NBYTES+2	 # +2 for 4 units/iter
> +	PREF(	0, 3*32(src))
>   	beqz	t0, .Lcleanup_src_unaligned
>   	 and	rem, len, (4*NBYTES-1)	 # rem = len % 4*NBYTES
> +	PREF(	1, 3*32(dst))
>   1:
>   /*
>    * Avoid consecutive LD*'s to the same register since some mips
>
