Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Nov 2018 05:20:06 +0100 (CET)
Received: from mail-ed1-x544.google.com ([IPv6:2a00:1450:4864:20::544]:35665
        "EHLO mail-ed1-x544.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990397AbeKYESDP5AMf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Nov 2018 05:18:03 +0100
Received: by mail-ed1-x544.google.com with SMTP id x30so13135700edx.2;
        Sat, 24 Nov 2018 20:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=peBHLQfMZprZ7Y8obIOHLEWYp3Ixk/YUySRgAo0Jafw=;
        b=NjorkavKui9Tc7buhACLon/lY1784aUUvSYflHH+QPFX8yqDS6zSJEeeIkPW/eqAb+
         /XTfFxzVG02YA3LbBnv8xXF2x3eQGCUgXH9G1rmR3PxMBOK7TRdTk0GMJfn5itImNOym
         Xp+alG1ykMs38TNqe1LlJKPdaVabnfpGDyROppKmXzTx4Wkp31ZbJ+kkuvIsXyq9umM0
         5rTL4qlsrJ8uOEOAPy3yFffyyIUlA5f3hJcHZbstrD5sx+H3yuhYo6E6uhok+p//g8+h
         EJhkJguTrr6l/8stGIAo8jxAmWHOFu9/Tjh+nEE/AFVG4KJK71Y6fHTSNhQe5tYauyCP
         Aunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=peBHLQfMZprZ7Y8obIOHLEWYp3Ixk/YUySRgAo0Jafw=;
        b=un2rBjsOeLhJF2IiXDsVgLFaipZEHDDBnQjGw4asxAugV8gCJRoredspG7+H4BN8Ge
         JEqNfthaWVkfhuaWhIXCq5oQwDUCrZ8BASqKjjPGMVuiCop0nxlJfnB4NNmKLGaA17cA
         RQMr/ofLPQoCQ0Fr8CJd2rrx5mTzb9x/7554E/q1rIUslrhsMSO1rcamjHhbE11xXAUu
         ciejNbY1m3V2jRm2UlNn7E80kHDHsypoCNCkhUbHMkhsBq9Ip0POuVJMslRGKHDMrIEX
         aWpuA5QgBR6urFPFeKfRPv1i0E3GATmci6pk0KTfUFk3g14cfXuO8s/Q/LpKXFUHEFgH
         QgDA==
X-Gm-Message-State: AA+aEWbJXHD2ZDH1NMGAjUw1ArtBiPFE0a7IYVflGU6GkvMk5eFSa9FG
        mBjqNBW7WhteRTmqw7FrqUHyU0YP9UkDmynK99Q=
X-Google-Smtp-Source: AFSGD/WFxCqokbbTRO6Hk8K9wcilVroJIfm/Lok7h/4afEenadq1vGvymFhQe8/+ZimaS+/sLdCfXU8DeE36FK40u8M=
X-Received: by 2002:a50:b31c:: with SMTP id q28mr18322945edd.241.1543119482776;
 Sat, 24 Nov 2018 20:18:02 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-8-deepa.kernel@gmail.com> <CAF=yD-K=ZLZ_S=Y6YnhvvkfKQS=21ujwiGd7+JB9yDMtiX_9hg@mail.gmail.com>
In-Reply-To: <CAF=yD-K=ZLZ_S=Y6YnhvvkfKQS=21ujwiGd7+JB9yDMtiX_9hg@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 24 Nov 2018 23:17:25 -0500
Message-ID: <CAF=yD-K3Ga8qojSh5Epa6m4EYn-Lvdo=e38MnFqOKch1128VHw@mail.gmail.com>
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
X-archive-position: 67475
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

On Sat, Nov 24, 2018 at 10:59 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Sat, Nov 24, 2018 at 3:58 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > Add SO_TIMESTAMP_NEW and SO_TIMESTAMPNS_NEW variants of
> > socket timestamp options.
> > These are the y2038 safe versions of the SO_TIMESTAMP_OLD
> > and SO_TIMESTAMPNS_OLD for all architectures.
> >
> > Note that the format of scm_timestamping.ts[0] is not changed
> > in this patch.
> >
> > Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> > Cc: jejb@parisc-linux.org
> > Cc: ralf@linux-mips.org
> > Cc: rth@twiddle.net
> > Cc: linux-alpha@vger.kernel.org
> > Cc: linux-mips@linux-mips.org
> > Cc: linux-parisc@vger.kernel.org
> > Cc: linux-rdma@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: sparclinux@vger.kernel.org
> > ---
>
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 8143c4c1a49d..9edf909dc176 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -801,6 +801,7 @@ enum sock_flags {
> >         SOCK_RCU_FREE, /* wait rcu grace period in sk_destruct() */
> >         SOCK_TXTIME,
> >         SOCK_XDP, /* XDP is attached */
> > +       SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */
>
> sk_flags is getting exhausted. Commit b9f40e21ef42 ("net-timestamp:
> move timestamp flags out of sk_flags") added a new u16 sk_tsflags
> specifically for timestamps. That may be a better choice here, too.
>
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index e60036618205..7b485dfaa400 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -652,15 +652,23 @@ static void setsockopt_timestamp(struct sock *sk, int type, int val)
> >         if (!val) {
> >                 sock_reset_flag(sk, SOCK_RCVTSTAMP);
> >                 sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
> > +               sock_reset_flag(sk, SOCK_TSTAMP_NEW);
> >                 return;
> >         }
> >
> > +       if (type == SO_TIMESTAMP_NEW || type == SO_TIMESTAMPNS_NEW)
> > +               sock_set_flag(sk, SOCK_TSTAMP_NEW);
> > +       else
> > +               sock_reset_flag(sk, SOCK_TSTAMP_NEW);
> > +
>
> if adding a boolean whether the socket uses new or old-style
> timestamps, perhaps fail hard if a process tries to set a new-style
> option while an old-style is already set and vice versa. Also include
> SO_TIMESTAMPING_NEW as it toggles the same option.
>
> > diff --git a/net/socket.c b/net/socket.c
> > index d3defba55547..9abeb6bc9cfe 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -699,6 +699,38 @@ static void put_ts_pktinfo(struct msghdr *msg, struct sk_buff *skb)
> >                  sizeof(ts_pktinfo), &ts_pktinfo);
> >  }
> >
> > +static void sock_recv_sw_timestamp(struct msghdr *msg, struct sock *sk,
> > +                                  struct sk_buff *skb)
> > +{
> > +       if (sock_flag(sk, SOCK_TSTAMP_NEW)) {
> > +               if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> > +                       struct sock_timeval tv;
> > +
> > +                       skb_get_new_timestamp(skb, &tv);
> > +                       put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_NEW,
> > +                                sizeof(tv), &tv);
> > +               } else {
> > +                       struct __kernel_timespec ts;
> > +
> > +                       skb_get_new_timestampns(skb, &ts);
> > +                       put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
> > +                                sizeof(ts), &ts);
> > +               }
> > +       }
> > +       if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> > +               struct __kernel_old_timeval tv;
> > +
> > +               skb_get_timestamp(skb, &tv);
> > +               put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
> > +                        sizeof(tv), &tv);
> > +       } else {
> > +               struct timespec ts;
> > +
> > +               skb_get_timestampns(skb, &ts);
> > +               put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
> > +                        sizeof(ts), &ts);
> > +       }
> > +}
> >  /*
> >   * called from sock_recv_timestamp() if sock_flag(sk, SOCK_RCVTSTAMP)
> >   * or sock_flag(sk, SOCK_RCVTSTAMPNS)
> > @@ -719,19 +751,8 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
> >                 false_tstamp = 1;
> >         }
> > -       if (need_software_tstamp) {
>
> Considerably less code churn if adding __sock_recv_timestamp_2038 and
> calling that here:
>
>                    if (sock_flag(sk, SOCK_TSTAMP_NEW))
>                            __sock_recv_timestamp_2038(msg, sk, skb);
>                    else if ...
>
> Same for the tcp case above, really, and in the case of the next patch
> for SO_TIMESTAMPING_NEW

That naming convention, ..._2038, is not the nicest, of course. That
is not the relevant bit in the above comment.

Come to think of it, and related to my question in patch 2 why the
need to rename at all, could all new structs, constants and functions
be named consistently with 64 suffix? __sock_recv_timestamp64,
SO_TIMESTAMPING64 and timeval64 (instead of sock_timeval,
it isn't really a sock specific struct)?

I guess that there is a good reason for the renaming exercise and
conditional mapping of SO_TIMESTAMP onto old or new interface.
Please elucidate in the commit message.
