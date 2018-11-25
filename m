Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Nov 2018 05:00:58 +0100 (CET)
Received: from mail-ed1-x543.google.com ([IPv6:2a00:1450:4864:20::543]:35598
        "EHLO mail-ed1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990473AbeKYEArNc0gf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Nov 2018 05:00:47 +0100
Received: by mail-ed1-x543.google.com with SMTP id x30so13123836edx.2
        for <linux-mips@linux-mips.org>; Sat, 24 Nov 2018 20:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=obtjhgtDDsP+5Ip6HZR8RzVAI2Sl/WwjveNuv60FNDs=;
        b=YqOmSidS95BPQYBVzqnNeBa4T7rgsx5jQyJB8lWWrWUOypCe3UU48DBr5T6RKM/rQa
         hPYciCQu0hNgfnKSkX29QKmwqkarhfaTT3FkHPIdeC04uGRgL0FBLnGbWv9Rw2S7521Q
         +nVEk46+FXxcZm8WQ3ZYsHn/xr+3veZkjqDUgQdm8YINbiDQO/wN7oxCxAYLN1bcWLsw
         GQy8by3SgVIRMl331D//UNZxLAb7EOtAVSNCQhmKf9mYCjbE/Q5X5CFVbztRRL+Kz3N7
         8HB+Xrp3toMt+Y3gE8GdDCC2HyUJtC0ePC1rg/E8+RqQE1DgJ3w8NfPAXutLtKtIam9h
         qFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=obtjhgtDDsP+5Ip6HZR8RzVAI2Sl/WwjveNuv60FNDs=;
        b=SPL1i8Ts5a7mnoVmbkSwm1dLupAwR9V92m/z3SqFSgBi4Dl9aQayg++PNjEBfYzO1k
         UICkJCaEEwlHC+td0yRXDGcxGvwZLEX357C3qhOzyHW14sXtTtpsdUp71GguHHWjiaSI
         t4tfy45yWOtM6+fYM66tNxldoqhsBrA0em1QvHQF6/NzgWBsAOYxcqXloep1ybCV5SKT
         kRc/nAHTobYAwGtzfVyw0VCh4FGYA4OrMw+2rfvOuiKU2i6xKA6WVoHs5JKejiUTUdKS
         GM7fkSdWtlmsMk7tf6wbAyvcM0XHWHXL6OQTRKfiV1pnQB9l/Dv47R97XjCPNSCz+V1c
         OgOw==
X-Gm-Message-State: AA+aEWZrPSnOZT/IrtPxfXrXIRheJuiCE2Erz9d7Y6Cu1T9Fh2R24wFS
        1EGf2tlObb5P2h7JGCrEa8UqD6dxY0UTAnYiolW8JQ==
X-Google-Smtp-Source: AFSGD/WZnElXfbGNhd/Endw6qrCamTs/4J1B/Q9FZt5jGoDda+QJMvhqU/aMWzRGqoIBi/YOjQkiFTOLMj9kMyN0O30=
X-Received: by 2002:aa7:dace:: with SMTP id x14mr19123754eds.13.1543118445903;
 Sat, 24 Nov 2018 20:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com> <20181124022035.17519-9-deepa.kernel@gmail.com>
In-Reply-To: <20181124022035.17519-9-deepa.kernel@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 24 Nov 2018 23:00:08 -0500
Message-ID: <CAF=yD-Jz8c2EsoKxUDbf7dygWRW49kwteUsksq3eUV00Eg94-w@mail.gmail.com>
Subject: Re: [PATCH 8/8] socket: Add SO_TIMESTAMPING_NEW
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        chris@zankel.net, fenghua.yu@intel.com, rth@twiddle.net,
        Thomas Gleixner <tglx@linutronix.de>, ubraun@linux.ibm.com,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <willemdebruijn.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: willemdebruijn.kernel@gmail.com
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

On Sat, Nov 24, 2018 at 3:58 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> Add SO_TIMESTAMPING_NEW variant of socket timestamp options.
> This is the y2038 safe versions of the SO_TIMESTAMPING_OLD
> for all architectures.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: chris@zankel.net
> Cc: fenghua.yu@intel.com
> Cc: rth@twiddle.net
> Cc: tglx@linutronix.de
> Cc: ubraun@linux.ibm.com
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: sparclinux@vger.kernel.org
> ---

>  /*
>   * called from sock_recv_timestamp() if sock_flag(sk, SOCK_RCVTSTAMP)
>   * or sock_flag(sk, SOCK_RCVTSTAMPNS)
> @@ -739,8 +740,8 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
>         struct sk_buff *skb)
>  {
>         int need_software_tstamp = sock_flag(sk, SOCK_RCVTSTAMP) || sock_flag(sk, SOCK_RCVTSTAMPNS);
> -       struct scm_timestamping tss;
> -       int empty = 1, false_tstamp = 0;
> +       struct scm_timestamping_internal tss;
> +       int empty = 1, false_tstamp = 0, new_tstamp = 0;
>         struct skb_shared_hwtstamps *shhwtstamps =
>                 skb_hwtstamps(skb);
>
> @@ -756,20 +757,23 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
>
>         memset(&tss, 0, sizeof(tss));
>         if ((sk->sk_tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> -           ktime_to_timespec_cond(skb->tstamp, tss.ts + 0))
> +           ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
>                 empty = 0;
>         if (shhwtstamps &&
>             (sk->sk_tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
>             !skb_is_swtx_tstamp(skb, false_tstamp) &&
> -           ktime_to_timespec_cond(shhwtstamps->hwtstamp, tss.ts + 2)) {
> +           ktime_to_timespec64_cond(shhwtstamps->hwtstamp, tss.ts + 2)) {
>                 empty = 0;
>                 if ((sk->sk_tsflags & SOF_TIMESTAMPING_OPT_PKTINFO) &&
>                     !skb_is_err_queue(skb))
>                         put_ts_pktinfo(msg, skb);
>         }
>         if (!empty) {
> -               put_cmsg(msg, SOL_SOCKET,
> -                        SO_TIMESTAMPING_OLD, sizeof(tss), &tss);
> +               new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
> +               if (new_tstamp)

nit: no need for explicit variable

> +                       put_cmsg_scm_timestamping64(msg, &tss);
> +               else
> +                       put_cmsg_scm_timestamping(msg, &tss);
>
>                 if (skb_is_err_queue(skb) && skb->len &&
>                     SKB_EXT_ERR(skb)->opt_stats)
> --
> 2.17.1
>
