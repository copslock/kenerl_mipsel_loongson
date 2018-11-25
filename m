Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Nov 2018 05:00:53 +0100 (CET)
Received: from mail-ed1-x543.google.com ([IPv6:2a00:1450:4864:20::543]:39453
        "EHLO mail-ed1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990392AbeKYEAcSsG8f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Nov 2018 05:00:32 +0100
Received: by mail-ed1-x543.google.com with SMTP id b14so13087747edt.6;
        Sat, 24 Nov 2018 20:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0vV7/EObBCO4v9Rbbv3QtqSUcOg+1e5F/clF9P9EI4=;
        b=pIFLmXiOKG8nxFxCUFxvKfEsTNbZUHTZXYoKBOrkZPzuyKP3vZizA9/vXUEXNoK5Mj
         TyAUoBqlJFo76mnp9yIaolSyH/fqmtG9AIN3C3M3i4Z9YpQhcq2K4hozDjtKi1phO369
         6i+abB2q7vZ/H0ZRZW4GAbnOueijLaknYZj+0EL95O98J7N9IYCZCwkWSy6gPE2JR9js
         pEBQW81eY6TmwYFICsbHx5bpSlelLJVTjvHSXRYGB34x26GgALYs7dDRhyVUt1AJmmbD
         6cdec+Fwb5ff4sFOacX1Q0lCYJZ5/54aX+XcIhf3Mb7E0EddjR569wVT63ZtB/8Bx3wy
         FB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0vV7/EObBCO4v9Rbbv3QtqSUcOg+1e5F/clF9P9EI4=;
        b=EwxKo+DUGKVha8mqMo0wtrjp8kCGSHiApUy/GsaXUn7551jmJSjfcFLPnGX6RJyR4h
         Ig+E9yjIBgihC2t+h75gq9LUILAx3zxbuD7gSqbPhcmuLft0F7+2GNvFS6PHs75KQUXX
         qGGcBGEDNvwoN4oTa4Q06ldFxKcuFNwkTYAHXU7gw/WJ4UVPTIDYyggQE+6rbI1me29R
         uaAegdRcnBGCmJHl/EKzPtqhlQJ6QExuYSHX1v9OhQBwJeHigkPW8de37fYjPxZrDIK8
         v9GJRJFKnkHs69Yyhztz3hW+UtJr4jlEuZVzEQiIGNOE0KK0JFNI5e/f/MNVMMrj4JWH
         5ZHA==
X-Gm-Message-State: AA+aEWYG5Frb+A0D2qcXSonWd4F6d0V1aE204Jhw89BGylI/iTluC+ue
        ANbQiU41rHUS0lTAft3SpgYDqiqCbv5fugyGPxhSfw==
X-Google-Smtp-Source: AFSGD/WI0FGh0FBBjGUts0gY68Rvm3EjIPfQ21X8KClomKghX3Yp59UWE2OWagkBa1JFLKtgiQKeCi/4MBNGoy50yM0=
X-Received: by 2002:a50:a517:: with SMTP id y23mr18600029edb.219.1543118431777;
 Sat, 24 Nov 2018 20:00:31 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com> <20181124022035.17519-8-deepa.kernel@gmail.com>
In-Reply-To: <20181124022035.17519-8-deepa.kernel@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 24 Nov 2018 22:59:54 -0500
Message-ID: <CAF=yD-K=ZLZ_S=Y6YnhvvkfKQS=21ujwiGd7+JB9yDMtiX_9hg@mail.gmail.com>
Subject: Re: [PATCH 7/8] socket: Add SO_TIMESTAMP[NS]_NEW
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        jejb@parisc-linux.org, ralf@linux-mips.org, rth@twiddle.net,
        linux-alpha@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <willemdebruijn.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67473
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
> Add SO_TIMESTAMP_NEW and SO_TIMESTAMPNS_NEW variants of
> socket timestamp options.
> These are the y2038 safe versions of the SO_TIMESTAMP_OLD
> and SO_TIMESTAMPNS_OLD for all architectures.
>
> Note that the format of scm_timestamping.ts[0] is not changed
> in this patch.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: jejb@parisc-linux.org
> Cc: ralf@linux-mips.org
> Cc: rth@twiddle.net
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-rdma@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> ---

> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8143c4c1a49d..9edf909dc176 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -801,6 +801,7 @@ enum sock_flags {
>         SOCK_RCU_FREE, /* wait rcu grace period in sk_destruct() */
>         SOCK_TXTIME,
>         SOCK_XDP, /* XDP is attached */
> +       SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */

sk_flags is getting exhausted. Commit b9f40e21ef42 ("net-timestamp:
move timestamp flags out of sk_flags") added a new u16 sk_tsflags
specifically for timestamps. That may be a better choice here, too.

> diff --git a/net/core/sock.c b/net/core/sock.c
> index e60036618205..7b485dfaa400 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -652,15 +652,23 @@ static void setsockopt_timestamp(struct sock *sk, int type, int val)
>         if (!val) {
>                 sock_reset_flag(sk, SOCK_RCVTSTAMP);
>                 sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
> +               sock_reset_flag(sk, SOCK_TSTAMP_NEW);
>                 return;
>         }
>
> +       if (type == SO_TIMESTAMP_NEW || type == SO_TIMESTAMPNS_NEW)
> +               sock_set_flag(sk, SOCK_TSTAMP_NEW);
> +       else
> +               sock_reset_flag(sk, SOCK_TSTAMP_NEW);
> +

if adding a boolean whether the socket uses new or old-style
timestamps, perhaps fail hard if a process tries to set a new-style
option while an old-style is already set and vice versa. Also include
SO_TIMESTAMPING_NEW as it toggles the same option.

> diff --git a/net/socket.c b/net/socket.c
> index d3defba55547..9abeb6bc9cfe 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -699,6 +699,38 @@ static void put_ts_pktinfo(struct msghdr *msg, struct sk_buff *skb)
>                  sizeof(ts_pktinfo), &ts_pktinfo);
>  }
>
> +static void sock_recv_sw_timestamp(struct msghdr *msg, struct sock *sk,
> +                                  struct sk_buff *skb)
> +{
> +       if (sock_flag(sk, SOCK_TSTAMP_NEW)) {
> +               if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> +                       struct sock_timeval tv;
> +
> +                       skb_get_new_timestamp(skb, &tv);
> +                       put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_NEW,
> +                                sizeof(tv), &tv);
> +               } else {
> +                       struct __kernel_timespec ts;
> +
> +                       skb_get_new_timestampns(skb, &ts);
> +                       put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
> +                                sizeof(ts), &ts);
> +               }
> +       }
> +       if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> +               struct __kernel_old_timeval tv;
> +
> +               skb_get_timestamp(skb, &tv);
> +               put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
> +                        sizeof(tv), &tv);
> +       } else {
> +               struct timespec ts;
> +
> +               skb_get_timestampns(skb, &ts);
> +               put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
> +                        sizeof(ts), &ts);
> +       }
> +}
>  /*
>   * called from sock_recv_timestamp() if sock_flag(sk, SOCK_RCVTSTAMP)
>   * or sock_flag(sk, SOCK_RCVTSTAMPNS)
> @@ -719,19 +751,8 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
>                 false_tstamp = 1;
>         }
> -       if (need_software_tstamp) {

Considerably less code churn if adding __sock_recv_timestamp_2038 and
calling that here:

                   if (sock_flag(sk, SOCK_TSTAMP_NEW))
                           __sock_recv_timestamp_2038(msg, sk, skb);
                   else if ...

Same for the tcp case above, really, and in the case of the next patch
for SO_TIMESTAMPING_NEW


> -               if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> -                       struct __kernel_old_timeval tv;
> -                       skb_get_timestamp(skb, &tv);
> -                       put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
> -                                sizeof(tv), &tv);
> -               } else {
> -                       struct timespec ts;
> -                       skb_get_timestampns(skb, &ts);
> -                       put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
> -                                sizeof(ts), &ts);
> -               }
> -       }


> +       if (need_software_tstamp)
> +               sock_recv_sw_timestamp(msg, sk, skb);
>
>         memset(&tss, 0, sizeof(tss));
>         if ((sk->sk_tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> --
> 2.17.1
>
