Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2018 16:30:11 +0100 (CET)
Received: from mail-pf1-x442.google.com ([IPv6:2607:f8b0:4864:20::442]:40858
        "EHLO mail-pf1-x442.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991096AbeKAP2whCOeP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2018 16:28:52 +0100
Received: by mail-pf1-x442.google.com with SMTP id g21-v6so9499156pfi.7;
        Thu, 01 Nov 2018 08:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UQwNdyZs7+NarOfK+icn1dwEf9p2K/3ed2HnMcVT/yY=;
        b=ew7C/SFJ6Ri3Bz6CSG3sxAVqWNf/agXmhpiWebq1zpcRYkwr7tp3dIZQVLRK6OPw1a
         WRMbhYedqjfYTTyn98qQkOyOkfk6t4GlxAu/KFTHCzsiqTslIFFXHqc83+iBxCD5zjhl
         u3h0Qo+EIYaoZ0HxHNf8IWFBQm6Kz8CUixslkxk5KedqD/dGrxqD9K/UsfRudc0H5veq
         05dUpHAjG9s5EvkLwE6RJF3+d4W8bfhgXYGBx4qChVRv3vmE3bJqOPhVpfqbzvPvnp3X
         MTkiJE7E80Is3fAMQWDEQtDQLZeT4OByi4H0ePAPkaFOoruc6sEeWUh0e+FJ3T6ePOd0
         nvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UQwNdyZs7+NarOfK+icn1dwEf9p2K/3ed2HnMcVT/yY=;
        b=h2AX/ScZTvipBk6AXuQ5B3O8iMBQ7FFog9CZrA1V1rSegi1cbgEnn7ktOnw1pINYSu
         rrveX0GC/3WJDEuMjfeM9bE50Jq48PRU0i+4A8gCC8TkStr/2KMvxR7D0emiIi6Dq/A4
         asS3kzigwsRx221uBx8XqdnFCqHm0/teusMflrttz1v2lPJVmEqWCXngOgyV6QRqhXra
         TGF0/+SR70ntr+gFRSeONzs4kdZ/Ndns+FnRGg/J4EaKXUxB2OzJlaHRunJ6BSQXxCRY
         JU5SJyQ6q1ndOPGGcj9noNJWzbcYFogRggFRns4hBIzLtqa3hENfaN6VvHmlN3ogeeyb
         ERkg==
X-Gm-Message-State: AGRZ1gJf0vvwepkwZ+CHEvVK7GlLqoNoQAnYKVnksjr73l3QbgXnlq1F
        8vSzu3Pj/sUTimyutxiY0qA=
X-Google-Smtp-Source: AJdET5fmhmqkDC08+8WPv32oJZpErebY8qH/BIp2xCnqI/AxX/IZq4kpeLpsLQtf3LQwsCQQNvGbTg==
X-Received: by 2002:a63:cc51:: with SMTP id q17-v6mr7483905pgi.291.1541086131442;
        Thu, 01 Nov 2018 08:28:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n65-v6sm1848713pfi.185.2018.11.01.08.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 08:28:50 -0700 (PDT)
Date:   Thu, 1 Nov 2018 08:28:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "paul.burton@mips.com" <paul.burton@mips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
Message-ID: <20181101152849.GC25346@roeck-us.net>
References: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
 <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
 <20181031220253.GA15505@roeck-us.net>
 <20181031233235.qbedw3pinxcuk7me@pburton-laptop>
 <291af20b-820e-e848-cf75-730024612117@roeck-us.net>
 <d7fe095d8d1f848b5742a5b3e8cce9f89e0c1c8d.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7fe095d8d1f848b5742a5b3e8cce9f89e0c1c8d.camel@hammerspace.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67032
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

On Thu, Nov 01, 2018 at 06:30:08AM +0000, Trond Myklebust wrote:
[ ... ]
> > 
> > For my part I agree that this would be a much better solution. The
> > argument
> > that it is not always absolutely guaranteed that atomics don't wrap
> > doesn't
> > really hold for me because it looks like they all do. On top of that,
> > there
> > is an explicit atomic_dec_if_positive() and
> > atomic_fetch_add_unless(),
> > which to me strongly suggests that they _are_ supposed to wrap.
> > Given the cost of adding a comparison to each atomic operation to
> > prevent it from wrapping, anything else would not really make sense
> > to me.
> 
> That's a hypothesis, not a proven fact. There are architectures out
> there that do not wrap signed integers, hence my question.
> 

If what you say is correct, the kernel is in big trouble on those architectures.
atomic_inc_return() is used all over the place in the kernel with the assumption
that each returned value differs from the previous value (ie the value is used
as cookie, session ID, or for similar purposes).

Guenter
