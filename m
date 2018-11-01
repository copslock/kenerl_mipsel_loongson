Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2018 02:20:06 +0100 (CET)
Received: from mail-pl1-x642.google.com ([IPv6:2607:f8b0:4864:20::642]:38371
        "EHLO mail-pl1-x642.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990700AbeKABSgZ7sRr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2018 02:18:36 +0100
Received: by mail-pl1-x642.google.com with SMTP id p7-v6so8119370plk.5;
        Wed, 31 Oct 2018 18:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n3Bh4lDkQM3Br0JLy4DpJFofWnoGLP42GY3kTHRT33o=;
        b=kh7jvFiiYrNaYdRxA22GXMxicQ4XL37GU1izGenSeZfIrOxFEHwxx52TM5R5xs+t0K
         zNIdPda74jGD7K4ch8Tzd1hydQ/NM8s0cAO1jnkCFoho88uz5FOT8icH8FFaxZsRL8x/
         f36W+a+1I6MsJrQcRhXiSoosakIpKTN0sBmebFVLR/6w0sf7Unoo8Pst0jNwy/tEwo25
         62xtaejBE6LUEvPLj+OugA2udpvVYAIDVZ5cyFaNj5XBB1iOF9EBTv0OHZ1EES084vxW
         jWimDsL+Xsol8TybqI4+14RoH+7hOWFqXrZ1c9yw0zEr6R34Qk530Me1X+J7g9qOoLqy
         IzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n3Bh4lDkQM3Br0JLy4DpJFofWnoGLP42GY3kTHRT33o=;
        b=pYghNH5L8qJ4X6/JNOo45gCkVQ86ffC3MmEPmZB2gTHtpL/yaNQfwa3f9phngd5KwG
         wP8OMvl4Zu6pkS1fzBQB/fbgKQQoMpub/qBWscGFJXWBdeprCDIzhOkS7wQq06E4ZBuU
         e1nxKDsnzniu7aBO4pBaqJqZEbbLyhn/1PQtySxG2Js/N9cniq53AOvHkyptmV9aHONv
         MIZg7e0LIl2vQOM6CHN73m/wsuvSALwjsSSVk+Q58addnugFknmhZMushXSJbEXdAtG3
         mmr5O7v3Mp+QLGm9CYRhiTWE22AlSmeRDBto6blJsq2HGo5EM6RN928xpSWvs9PpdYyw
         zkEA==
X-Gm-Message-State: AGRZ1gLqEwTV6ppF+cMkU0EvfN2JlJg2OP0BFa58Q7inl9s9y7hHE8ur
        kdzLu6azUGbNVZ6hFd65bzs=
X-Google-Smtp-Source: AJdET5ec5YG8IUh4/wh7u5tE4ba72B0CSdBCvCtwCb9E6eYNeunK+bJNlmujB618k673+97QTrd3qQ==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63-v6mr5613333plb.241.1541035115186;
        Wed, 31 Oct 2018 18:18:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v37sm153818pgn.5.2018.10.31.18.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 18:18:34 -0700 (PDT)
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
To:     Paul Burton <paul.burton@mips.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
 <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
 <20181031220253.GA15505@roeck-us.net>
 <20181031233235.qbedw3pinxcuk7me@pburton-laptop>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <291af20b-820e-e848-cf75-730024612117@roeck-us.net>
Date:   Wed, 31 Oct 2018 18:18:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181031233235.qbedw3pinxcuk7me@pburton-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 10/31/18 4:32 PM, Paul Burton wrote:
> (Copying SunRPC & net maintainers.)
> 
> Hi Guenter,
> 
> On Wed, Oct 31, 2018 at 03:02:53PM -0700, Guenter Roeck wrote:
>> The alternatives I can see are
>> - Do not use cmpxchg64() outside architecture code (ie drop its use from
>>    the offending driver, and keep doing the same whenever the problem comes
>>    up again).
>> or
>> - Introduce something like ARCH_HAS_CMPXCHG64 and use it to determine
>>    if cmpxchg64 is supported or not.
>>
>> Any preference ?
> 
> My preference would be option 1 - avoiding cmpxchg64() where possible in
> generic code. I wouldn't be opposed to the Kconfig option if there are
> cases where cmpxchg64() can really help performance though.
> 
> The last time I'm aware of this coming up the affected driver was
> modified to avoid cmpxchg64() [1].
> 
> In this particular case I have no idea why
> net/sunrpc/auth_gss/gss_krb5_seal.c is using cmpxchg64() at all. It's
> essentially reinventing atomic64_fetch_inc() which is already provided
> everywhere via CONFIG_GENERIC_ATOMIC64 & the spinlock approach. At least
> for atomic64_* functions the assumption that all access will be
> performed using those same functions seems somewhat reasonable.
> 
> So how does the below look? Trond?
> 

For my part I agree that this would be a much better solution. The argument
that it is not always absolutely guaranteed that atomics don't wrap doesn't
really hold for me because it looks like they all do. On top of that, there
is an explicit atomic_dec_if_positive() and atomic_fetch_add_unless(),
which to me strongly suggests that they _are_ supposed to wrap.
Given the cost of adding a comparison to each atomic operation to
prevent it from wrapping, anything else would not really make sense to me.

So ... please consider my patch abandoned. Thanks for looking into this!

Guenter

> Thanks,
>      Paul
> 
> [1] https://patchwork.ozlabs.org/cover/891284/
> 
> ---
> diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
> index 131424cefc6a..02c0412e368c 100644
> --- a/include/linux/sunrpc/gss_krb5.h
> +++ b/include/linux/sunrpc/gss_krb5.h
> @@ -107,8 +107,8 @@ struct krb5_ctx {
>   	u8			Ksess[GSS_KRB5_MAX_KEYLEN]; /* session key */
>   	u8			cksum[GSS_KRB5_MAX_KEYLEN];
>   	s32			endtime;
> -	u32			seq_send;
> -	u64			seq_send64;
> +	atomic_t		seq_send;
> +	atomic64_t		seq_send64;
>   	struct xdr_netobj	mech_used;
>   	u8			initiator_sign[GSS_KRB5_MAX_KEYLEN];
>   	u8			acceptor_sign[GSS_KRB5_MAX_KEYLEN];
> @@ -118,9 +118,6 @@ struct krb5_ctx {
>   	u8			acceptor_integ[GSS_KRB5_MAX_KEYLEN];
>   };
>   
> -extern u32 gss_seq_send_fetch_and_inc(struct krb5_ctx *ctx);
> -extern u64 gss_seq_send64_fetch_and_inc(struct krb5_ctx *ctx);
> -
>   /* The length of the Kerberos GSS token header */
>   #define GSS_KRB5_TOK_HDR_LEN	(16)
>   
> diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
> index 7f0424dfa8f6..eab71fc7af3e 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_mech.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
> @@ -274,6 +274,7 @@ get_key(const void *p, const void *end,
>   static int
>   gss_import_v1_context(const void *p, const void *end, struct krb5_ctx *ctx)
>   {
> +	u32 seq_send;
>   	int tmp;
>   
>   	p = simple_get_bytes(p, end, &ctx->initiate, sizeof(ctx->initiate));
> @@ -315,9 +316,10 @@ gss_import_v1_context(const void *p, const void *end, struct krb5_ctx *ctx)
>   	p = simple_get_bytes(p, end, &ctx->endtime, sizeof(ctx->endtime));
>   	if (IS_ERR(p))
>   		goto out_err;
> -	p = simple_get_bytes(p, end, &ctx->seq_send, sizeof(ctx->seq_send));
> +	p = simple_get_bytes(p, end, &seq_send, sizeof(seq_send));
>   	if (IS_ERR(p))
>   		goto out_err;
> +	atomic_set(&ctx->seq_send, seq_send);
>   	p = simple_get_netobj(p, end, &ctx->mech_used);
>   	if (IS_ERR(p))
>   		goto out_err;
> @@ -607,6 +609,7 @@ static int
>   gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
>   		gfp_t gfp_mask)
>   {
> +	u64 seq_send64;
>   	int keylen;
>   
>   	p = simple_get_bytes(p, end, &ctx->flags, sizeof(ctx->flags));
> @@ -617,14 +620,15 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
>   	p = simple_get_bytes(p, end, &ctx->endtime, sizeof(ctx->endtime));
>   	if (IS_ERR(p))
>   		goto out_err;
> -	p = simple_get_bytes(p, end, &ctx->seq_send64, sizeof(ctx->seq_send64));
> +	p = simple_get_bytes(p, end, &seq_send64, sizeof(seq_send64));
>   	if (IS_ERR(p))
>   		goto out_err;
> +	atomic64_set(&ctx->seq_send64, seq_send64);
>   	/* set seq_send for use by "older" enctypes */
> -	ctx->seq_send = ctx->seq_send64;
> -	if (ctx->seq_send64 != ctx->seq_send) {
> -		dprintk("%s: seq_send64 %lx, seq_send %x overflow?\n", __func__,
> -			(unsigned long)ctx->seq_send64, ctx->seq_send);
> +	atomic_set(&ctx->seq_send, seq_send64);
> +	if (seq_send64 != atomic_read(&ctx->seq_send)) {
> +		dprintk("%s: seq_send64 %llx, seq_send %x overflow?\n", __func__,
> +			seq_send64, atomic_read(&ctx->seq_send));
>   		p = ERR_PTR(-EINVAL);
>   		goto out_err;
>   	}
> diff --git a/net/sunrpc/auth_gss/gss_krb5_seal.c b/net/sunrpc/auth_gss/gss_krb5_seal.c
> index b4adeb06660b..48fe4a591b54 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_seal.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_seal.c
> @@ -123,30 +123,6 @@ setup_token_v2(struct krb5_ctx *ctx, struct xdr_netobj *token)
>   	return krb5_hdr;
>   }
>   
> -u32
> -gss_seq_send_fetch_and_inc(struct krb5_ctx *ctx)
> -{
> -	u32 old, seq_send = READ_ONCE(ctx->seq_send);
> -
> -	do {
> -		old = seq_send;
> -		seq_send = cmpxchg(&ctx->seq_send, old, old + 1);
> -	} while (old != seq_send);
> -	return seq_send;
> -}
> -
> -u64
> -gss_seq_send64_fetch_and_inc(struct krb5_ctx *ctx)
> -{
> -	u64 old, seq_send = READ_ONCE(ctx->seq_send);
> -
> -	do {
> -		old = seq_send;
> -		seq_send = cmpxchg64(&ctx->seq_send64, old, old + 1);
> -	} while (old != seq_send);
> -	return seq_send;
> -}
> -
>   static u32
>   gss_get_mic_v1(struct krb5_ctx *ctx, struct xdr_buf *text,
>   		struct xdr_netobj *token)
> @@ -177,7 +153,7 @@ gss_get_mic_v1(struct krb5_ctx *ctx, struct xdr_buf *text,
>   
>   	memcpy(ptr + GSS_KRB5_TOK_HDR_LEN, md5cksum.data, md5cksum.len);
>   
> -	seq_send = gss_seq_send_fetch_and_inc(ctx);
> +	seq_send = atomic_fetch_inc(&ctx->seq_send);
>   
>   	if (krb5_make_seq_num(ctx, ctx->seq, ctx->initiate ? 0 : 0xff,
>   			      seq_send, ptr + GSS_KRB5_TOK_HDR_LEN, ptr + 8))
> @@ -205,7 +181,7 @@ gss_get_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *text,
>   
>   	/* Set up the sequence number. Now 64-bits in clear
>   	 * text and w/o direction indicator */
> -	seq_send_be64 = cpu_to_be64(gss_seq_send64_fetch_and_inc(ctx));
> +	seq_send_be64 = cpu_to_be64(atomic64_fetch_inc(&ctx->seq_send64));
>   	memcpy(krb5_hdr + 8, (char *) &seq_send_be64, 8);
>   
>   	if (ctx->initiate) {
> diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
> index 962fa84e6db1..5cdde6cb703a 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
> @@ -228,7 +228,7 @@ gss_wrap_kerberos_v1(struct krb5_ctx *kctx, int offset,
>   
>   	memcpy(ptr + GSS_KRB5_TOK_HDR_LEN, md5cksum.data, md5cksum.len);
>   
> -	seq_send = gss_seq_send_fetch_and_inc(kctx);
> +	seq_send = atomic_fetch_inc(&kctx->seq_send);
>   
>   	/* XXX would probably be more efficient to compute checksum
>   	 * and encrypt at the same time: */
> @@ -475,7 +475,7 @@ gss_wrap_kerberos_v2(struct krb5_ctx *kctx, u32 offset,
>   	*be16ptr++ = 0;
>   
>   	be64ptr = (__be64 *)be16ptr;
> -	*be64ptr = cpu_to_be64(gss_seq_send64_fetch_and_inc(kctx));
> +	*be64ptr = cpu_to_be64(atomic64_fetch_inc(&kctx->seq_send64));
>   
>   	err = (*kctx->gk5e->encrypt_v2)(kctx, offset, buf, pages);
>   	if (err)
> 
