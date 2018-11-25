Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Nov 2018 06:30:06 +0100 (CET)
Received: from mail-io1-xd41.google.com ([IPv6:2607:f8b0:4864:20::d41]:40192
        "EHLO mail-io1-xd41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbeKYF2TaRTrf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Nov 2018 06:28:19 +0100
Received: by mail-io1-xd41.google.com with SMTP id n9so11450731ioh.7;
        Sat, 24 Nov 2018 21:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZDq+TkzUn/G29okEW5qiws/BZ6VkEyzQgI0POq8fhg=;
        b=kEzbHJfwAO3bNFDX5jEerzuVr38CtCa0HNsxzNCCZi3XLJA985hLZfC6LXcmVHkEXY
         JzFGSM1VziqJMg7GWZoL121v60MVGNrhgjCgfcglRfSfBUExpcQYcc+sEfCTXgDnrpql
         EcoGAJt6EVCwE+QYQEHv7i5a2XZMxQPvw9PJBp32rROSAZNvtC+wK5GERi1YdCmHDQ75
         ySy72kl0xaOFzHcDsSNU1fqdMybybIyLI3nbZYvmTD1EWRGnqAGAxKhN4SB1yn1DbIWI
         DI7m7jidGGCcpHk7F2p5l9/JbqdR0VrZV7FQA6P4BUtHHISs1UJyf0TntzzrH2c9X2Hl
         yCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZDq+TkzUn/G29okEW5qiws/BZ6VkEyzQgI0POq8fhg=;
        b=DEiIOIWsO/OsKeSVnSD+lHxj6Bp+jxUMSi0I54Dneo/0X8NX2ljWD6jmKOS/LXwlTQ
         SzrjSH4T5seLxI3P2IzM0225YaeRbBupYNFcL6Di4wka1gMOxlFG+b7HNmXsuet7AIhA
         Z61RUeBw61MnfYi6bMqTHtKj6CKXx+btgrn8lm7nXMiZ1+EY7KmLFzTNmkmbVy0p714T
         84ZwyXN12Bh9aPgHwgDEBrVFTzjymxOn9BP4Dfca6IvcuCAr2bW1seR1aEilP65c2dMD
         exoVaA6/L0tTWQysyayK7WIgUP8qOp4xTFZ4PK+OdE8Vwu6+tNpdtUACcUw1NDAgRGHR
         etgA==
X-Gm-Message-State: AA+aEWYnYwB0Bb6UnFbNwmUIWnKcVYQOyTiETF1j4qGTpvwFzG0h7CZN
        givwje/O1s3qOqqNutph4dXqckh+5bYd6OMp3DQ=
X-Google-Smtp-Source: AFSGD/U1ty8BkP5cpO7vIF/L63LH/hSWCd+dmHYeUvuVs/2kdjL2jXnEzeLz9Aba8BoAkxeLJSkjJVY4IoBl4eEZ+F4=
X-Received: by 2002:a6b:3b4f:: with SMTP id i76mr7941350ioa.266.1543123698794;
 Sat, 24 Nov 2018 21:28:18 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-8-deepa.kernel@gmail.com> <CAF=yD-K=ZLZ_S=Y6YnhvvkfKQS=21ujwiGd7+JB9yDMtiX_9hg@mail.gmail.com>
 <CAF=yD-K3Ga8qojSh5Epa6m4EYn-Lvdo=e38MnFqOKch1128VHw@mail.gmail.com>
In-Reply-To: <CAF=yD-K3Ga8qojSh5Epa6m4EYn-Lvdo=e38MnFqOKch1128VHw@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 24 Nov 2018 21:28:07 -0800
Message-ID: <CABeXuvoDPvT45CCt2L0TReqtb1Q_-E8+toYu6qjiP0cxfdQNdA@mail.gmail.com>
Subject: Re: [PATCH 7/8] socket: Add SO_TIMESTAMP[NS]_NEW
To:     willemdebruijn.kernel@gmail.com
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ralf Baechle <ralf@linux-mips.org>, rth@twiddle.net,
        linux-alpha@vger.kernel.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-rdma@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <deepa.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: deepa.kernel@gmail.com
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

> > > +       if (type == SO_TIMESTAMP_NEW || type == SO_TIMESTAMPNS_NEW)
> > > +               sock_set_flag(sk, SOCK_TSTAMP_NEW);
> > > +       else
> > > +               sock_reset_flag(sk, SOCK_TSTAMP_NEW);
> > > +
> >
> > if adding a boolean whether the socket uses new or old-style
> > timestamps, perhaps fail hard if a process tries to set a new-style
> > option while an old-style is already set and vice versa. Also include
> > SO_TIMESTAMPING_NEW as it toggles the same option.

I do not think this is a problem.
Consider this example, if there is a user application with updated
socket timestamps is linking into a library that is yet to be updated.

Besides, the old timestamps should work perfectly fine on 64 bit
arches even beyond 2038.
So failing here means adding a bunch of ifdef's to verify it is not
executing on 64 bit arch or something like x32.

> > > diff --git a/net/socket.c b/net/socket.c
> > > index d3defba55547..9abeb6bc9cfe 100644
> > > --- a/net/socket.c
> > > +++ b/net/socket.c
> > > @@ -699,6 +699,38 @@ static void put_ts_pktinfo(struct msghdr *msg, struct sk_buff *skb)
> > >                  sizeof(ts_pktinfo), &ts_pktinfo);
> > >  }
> > >
> > > +static void sock_recv_sw_timestamp(struct msghdr *msg, struct sock *sk,
> > > +                                  struct sk_buff *skb)
> > > +{
> > > +       if (sock_flag(sk, SOCK_TSTAMP_NEW)) {
> > > +               if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> > > +                       struct sock_timeval tv;
> > > +
> > > +                       skb_get_new_timestamp(skb, &tv);
> > > +                       put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_NEW,
> > > +                                sizeof(tv), &tv);
> > > +               } else {
> > > +                       struct __kernel_timespec ts;
> > > +
> > > +                       skb_get_new_timestampns(skb, &ts);
> > > +                       put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
> > > +                                sizeof(ts), &ts);
> > > +               }
> > > +       }
> > > +       if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> > > +               struct __kernel_old_timeval tv;
> > > +
> > > +               skb_get_timestamp(skb, &tv);
> > > +               put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
> > > +                        sizeof(tv), &tv);
> > > +       } else {
> > > +               struct timespec ts;
> > > +
> > > +               skb_get_timestampns(skb, &ts);
> > > +               put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
> > > +                        sizeof(ts), &ts);
> > > +       }
> > > +}
> > >  /*
> > >   * called from sock_recv_timestamp() if sock_flag(sk, SOCK_RCVTSTAMP)
> > >   * or sock_flag(sk, SOCK_RCVTSTAMPNS)
> > > @@ -719,19 +751,8 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
> > >                 false_tstamp = 1;
> > >         }
> > > -       if (need_software_tstamp) {
> >
> > Considerably less code churn if adding __sock_recv_timestamp_2038 and
> > calling that here:
> >
> >                    if (sock_flag(sk, SOCK_TSTAMP_NEW))
> >                            __sock_recv_timestamp_2038(msg, sk, skb);
> >                    else if ...
> >
> > Same for the tcp case above, really, and in the case of the next patch
> > for SO_TIMESTAMPING_NEW
>
> That naming convention, ..._2038, is not the nicest, of course. That
> is not the relevant bit in the above comment.
>
> Come to think of it, and related to my question in patch 2 why the
> need to rename at all, could all new structs, constants and functions
> be named consistently with 64 suffix? __sock_recv_timestamp64,
> SO_TIMESTAMPING64 and timeval64 (instead of sock_timeval,
> it isn't really a sock specific struct)?
>
> I guess that there is a good reason for the renaming exercise and
> conditional mapping of SO_TIMESTAMP onto old or new interface.
> Please elucidate in the commit message.

I think there is some confusion here.

The existing timestamp options: SO_TIMESTAMP* fail to provide proper
timestamps beyond year 2038 on 32 bit ABIs.
But, these work fine on 64 bit native ABIs.
So now we need a way of updating these timestamps so that we do not
break existing userspace: 64 bit ABIs should not have to change
userspace, 32 bit ABIs should work as is until 2038 after which they
have bad timestamps.
So we introduce new y2038 safe timestamp options for 32 bit ABIs. We
assume that 32 bit applications will switch to new ABIs at some point,
but leave the older timestamps as is.
I can update the commit text as per above.

-Deepa
