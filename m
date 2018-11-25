Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Nov 2018 06:58:04 +0100 (CET)
Received: from mail-io1-xd43.google.com ([IPv6:2607:f8b0:4864:20::d43]:38776
        "EHLO mail-io1-xd43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990397AbeKYF4CmuZRf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Nov 2018 06:56:02 +0100
Received: by mail-io1-xd43.google.com with SMTP id l14so11331531ioj.5;
        Sat, 24 Nov 2018 21:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBOjXQl5ISrX4oGsbj589km/xVXzKIUUQQcwYRGpHJE=;
        b=LfnK8JR0vjvMyLLr9HiCDLlfltw2E7voMKFxDmPaKIdxeCC+kOhuPDF/NjWvR+H37a
         Y2JzE8U7cT0SR+8SszTF2gP29tcHLT3QL6lehZ38XNGSWC3TFhTUSjg326xVBOXVCfRe
         A5JS1ctLjACH4SnC08tkayjIzskVaFSKWdBdUngXfELE0SFHR0KizL4rJhPo3j08wotv
         Vo/ShyURMtQuFcziC0Gw/Hv3Gw+v2D+ODydkbR31vKlPFeIr+tcYl9H35Hpme/eYyN2D
         pdqf4d9Hdx0rbSk1yywmFLSTlLwF/JaEQJNZFwhdS33HDolRauiSfijd3y6fp0WT2wsg
         xNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBOjXQl5ISrX4oGsbj589km/xVXzKIUUQQcwYRGpHJE=;
        b=dXNEj2Cvl85hZayjrUpgOphsQC6LK5/U/Wjkic7RzoxrfE4u/DGbO+R1rOAtaUEMyH
         VaJJeoF7syX5m3gsxMxvKSq0TBkJuqOrSTTDKUh/CBtFCoC4ULPMe2Kf1X8CpRGScONm
         Ijtayk6v8K5FgEf42E+5Nw93ahUH2dM+BxLpEzfZ5OmCAUGPMsdzC54+sID6eq8L+6jF
         5WeX8whaRpTHLX6m3fmoU24d6rVxAErORxT/lkeiubUEL7lC2qaHEPivQunKzCpULOyT
         yg9QEYxkViaeLtibDKFRi3s27cdTQkiIyC5+sS37jLWFhoLTHMh8N27MO6IzVxvcgsDT
         7Zug==
X-Gm-Message-State: AA+aEWYMCN0C8pNuUw+v6zgYuNKq/Tf2G9yghMpQkJYbpzOsPa0FldmY
        9BUau+tO7n/6826ggm5jqOKQYJgvVid0T5Rm2D4=
X-Google-Smtp-Source: AFSGD/UXWQT2preuj58YBxV4UNX9+gVllZ4F0/fL3VggCNUUQXLrZNalbc4btAB+LCdGbZUx9fhMhgXZZ7Cpv/Xy6Lk=
X-Received: by 2002:a6b:b642:: with SMTP id g63-v6mr17991014iof.34.1543125361976;
 Sat, 24 Nov 2018 21:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-8-deepa.kernel@gmail.com> <CAF=yD-K=ZLZ_S=Y6YnhvvkfKQS=21ujwiGd7+JB9yDMtiX_9hg@mail.gmail.com>
 <CAF=yD-K3Ga8qojSh5Epa6m4EYn-Lvdo=e38MnFqOKch1128VHw@mail.gmail.com> <CABeXuvoDPvT45CCt2L0TReqtb1Q_-E8+toYu6qjiP0cxfdQNdA@mail.gmail.com>
In-Reply-To: <CABeXuvoDPvT45CCt2L0TReqtb1Q_-E8+toYu6qjiP0cxfdQNdA@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 24 Nov 2018 21:55:50 -0800
Message-ID: <CABeXuvr6fi9UPwMvuafx7MwEta-Sx1TLNN0KQ8HQHhn=vAne5Q@mail.gmail.com>
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
X-archive-position: 67478
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

A couple of comments I missed:

> > > >  /*
> > > >   * called from sock_recv_timestamp() if sock_flag(sk, SOCK_RCVTSTAMP)
> > > >   * or sock_flag(sk, SOCK_RCVTSTAMPNS)
> > > > @@ -719,19 +751,8 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
> > > >                 false_tstamp = 1;
> > > >         }
> > > > -       if (need_software_tstamp) {
> > >
> > > Considerably less code churn if adding __sock_recv_timestamp_2038 and
> > > calling that here:
> > >
> > >                    if (sock_flag(sk, SOCK_TSTAMP_NEW))
> > >                            __sock_recv_timestamp_2038(msg, sk, skb);
> > >                    else if ...
> > >
> > > Same for the tcp case above, really, and in the case of the next patch
> > > for SO_TIMESTAMPING_NEW
> >
> > That naming convention, ..._2038, is not the nicest, of course. That
> > is not the relevant bit in the above comment.

it could be  __sock_recv_timestamp64().
But, these timestamps should be doing exactly the same thing as the
old ones and I thought it would be nicer to keep the same code path.
I can change it to as per above.

> > Come to think of it, and related to my question in patch 2 why the
> > need to rename at all, could all new structs, constants and functions
> > be named consistently with 64 suffix? __sock_recv_timestamp64,
> > SO_TIMESTAMPING64 and timeval64 (instead of sock_timeval,
> > it isn't really a sock specific struct)?
> >
> > I guess that there is a good reason for the renaming exercise and
> > conditional mapping of SO_TIMESTAMP onto old or new interface.
> > Please elucidate in the commit message.
>
> I think there is some confusion here.
>
> The existing timestamp options: SO_TIMESTAMP* fail to provide proper
> timestamps beyond year 2038 on 32 bit ABIs.
> But, these work fine on 64 bit native ABIs.
> So now we need a way of updating these timestamps so that we do not
> break existing userspace: 64 bit ABIs should not have to change
> userspace, 32 bit ABIs should work as is until 2038 after which they
> have bad timestamps.
> So we introduce new y2038 safe timestamp options for 32 bit ABIs. We
> assume that 32 bit applications will switch to new ABIs at some point,
> but leave the older timestamps as is.
> I can update the commit text as per above.

We have been avoiding adding timeval64 timestamps to discourage users
from using these types in the interfaces.
We want to keep all the uapi time interfaces to use __kernel_*
interfaces. And, we already provide __kernel_timespec interface for
such instances.
But, in this case we do not have an option. So we introduce a type
specific to sockets.

-Deepa
