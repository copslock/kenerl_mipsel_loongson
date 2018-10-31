Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2018 23:03:01 +0100 (CET)
Received: from mail-pf1-x441.google.com ([IPv6:2607:f8b0:4864:20::441]:42418
        "EHLO mail-pf1-x441.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991112AbeJaWC6UTAR4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2018 23:02:58 +0100
Received: by mail-pf1-x441.google.com with SMTP id f26-v6so8267477pfn.9;
        Wed, 31 Oct 2018 15:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d/3VpCZ0Aa3ShjyLzNxCDT9XMSAT4U74mvB3YJDt8sk=;
        b=eX6VSrP5jr3ebobFPu8mkzOocEIGmM5qPE5p74+wGHr9YyBSLjT06ItmcchYyiR85y
         FXxmzmyrgWHkQgBKfNqtTq9dq6yIERA4x19Pfp7d3AKAg5CSyhxqivbNpS7yKCX+hqKV
         mOqZg+ugCoIAPvh98FNcB5u0vmFa5n8+suXYA34YdnNHoMKlRrSCYYL1FRf9++2Yibkn
         yAlVCnUmOKzOk5SqMrsAVMeslpnKW0/kaehkSZ7DNB2M218fjlcNg+HABi+fevxuRoLK
         PGcBlT+KpnthEkk2HsdmmJQoDZeJ+3st59Bwm8CW7sXCxHVkePD/yEg7brB5DkYvPtk6
         F5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=d/3VpCZ0Aa3ShjyLzNxCDT9XMSAT4U74mvB3YJDt8sk=;
        b=L12hdc4Wib8GfU+PnltUVKA0v52c/jr6NIihW4Jx4wt9tKf337k+gIC3JsjV/uyi7O
         oYbxncLfbGwHcnehkCnaGUJYxbm1+UkKfE0xQEa19fTPT0UfLYSeS4FAtM69PwRMOTRY
         UlTfpkpbtj5x47kFoEELv8lsT5JdgFG8x0/ac6ECXJ7JXkRTFk5zWjalC7C1TsqHjyXC
         MA5yn2h0eR4+WEb75kPY6Fng8twantdQtBitWs9KK1vn3SADRx0XndPfWeRHimh/y9le
         QWJjqeZWf1DlQf1xl2HDMXVQpARJIAvqkCoGw6R4q5mbAHp3oTSecr3CUJKGwhOfgYNQ
         KWOA==
X-Gm-Message-State: AGRZ1gIYFMgixiKOfuuONxp/AJM0irKXW9641QwlfRbfJcZrJUr79CAd
        97aMBroLUSz3zu/WOCQyCFY=
X-Google-Smtp-Source: AJdET5eEsyeFs/lpJXpJYu/HYdX2RxwOsfZDwN5MUryd3bU0YO93jcAbvzClWY6bJOjVIthccDcfRw==
X-Received: by 2002:a65:47cb:: with SMTP id f11-v6mr4900412pgs.166.1541023377095;
        Wed, 31 Oct 2018 15:02:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q76-v6sm60412618pfa.18.2018.10.31.15.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 15:02:55 -0700 (PDT)
Date:   Wed, 31 Oct 2018 15:02:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Burton <paul.burton@mips.com>
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
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
Message-ID: <20181031220253.GA15505@roeck-us.net>
References: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
 <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67020
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

On Wed, Oct 31, 2018 at 09:32:43PM +0000, Paul Burton wrote:
> Hi Guenter,
> 
> On Wed, Oct 31, 2018 at 12:52:18PM -0700, Guenter Roeck wrote:
> > +/*
> > + * Generic version of __cmpxchg_u64, to be used for cmpxchg64().
> > + * Takes u64 parameters.
> > + */
> > +u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new)
> > +{
> > +	raw_spinlock_t *lock = lock_addr(ptr);
> > +	unsigned long flags;
> > +	u64 prev;
> > +
> > +	raw_spin_lock_irqsave(lock, flags);
> > +	prev = READ_ONCE(*ptr);
> > +	if (prev == old)
> > +		*ptr = new;
> > +	raw_spin_unlock_irqrestore(lock, flags);
> > +
> > +	return prev;
> > +}
> > +EXPORT_SYMBOL(__cmpxchg_u64);
> 
> This is only going to work if we know that memory modified using
> __cmpxchg_u64() is *always* modified using __cmpxchg_u64(). Without that
> guarantee there's nothing to stop some other CPU writing to *ptr after
> the READ_ONCE() above but before we write new to it.
> 
> As far as I'm aware this is not a guarantee we currently provide, so it
> would mean making that a requirement for cmpxchg64() users & auditing
> them all. That would also leave cmpxchg64() with semantics that differ
> from plain cmpxchg(), and semantics that may surprise people. In my view
> that's probably not worth it, and it would be better to avoid using
> cmpxchg64() on systems that can't properly support it.
> 

Good point. Unfortunately this is also true for the architectures with
similar implementations, ie at least sparc32 (and possibly parisc).

The alternatives I can see are
- Do not use cmpxchg64() outside architecture code (ie drop its use from
  the offending driver, and keep doing the same whenever the problem comes
  up again).
or
- Introduce something like ARCH_HAS_CMPXCHG64 and use it to determine
  if cmpxchg64 is supported or not.

Any preference ?

Thanks,
Guenter
