Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Nov 2018 15:39:21 +0100 (CET)
Received: from mail-ed1-x541.google.com ([IPv6:2a00:1450:4864:20::541]:38080
        "EHLO mail-ed1-x541.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990473AbeKYOjS7RE-y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Nov 2018 15:39:18 +0100
Received: by mail-ed1-x541.google.com with SMTP id h50so13698579ede.5;
        Sun, 25 Nov 2018 06:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qe3g+4oK5urf0C9OUamBYlRFG+yhIqOjwS7c1rUtW60=;
        b=UVvhIO3OtE36NR7EaldVBH0cjI7DckhnH8TLQVhcv2B1B/Gj5+AOV3MspIw3OlKphj
         XN2YDSNpLY2zkBbQfs2GCXYffBnFm0HlhGaPH7iz4C2Emb9bMrv0aTdROtvqschfdIcl
         l+HWx6xn/xvNeMIJNDWlgRnrHoFjnaNIWXQw/fUGdpCMKnEjLlQOUJFHgCqVvSyElLZP
         OXN0dlyf1e0ylz67t0NewK0HdSWEcVCSEJuY0wmklF1++SUmPS68B9fhi+hUzoQdqsPE
         qk3GK/Xzr7QaoCdAw+yCmywUX0LzhN2ZWx+LBLPcekZMtYWX2izhp46/gDeXfp3uAEyh
         9GiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qe3g+4oK5urf0C9OUamBYlRFG+yhIqOjwS7c1rUtW60=;
        b=eoBTu0rfQe8YyzOuWNii0jpooIfK1AyMQgE4ayQrK9VcU1K3R6XSCxxB+bjNK05UuQ
         rZ8e85sfhY+9MZV2cuCLa7swf9U2ZJD+yNlnlqYclrwKdpoG213/AQiQDGx67BMeBDUq
         uyNRoPxRmyhv+byUF334iDMe9twY7yLjDmQ4x6zcvYUtqpnmfH1Grzx+Yv2Ou9S5l/S0
         hDFz91TmhaQnx4ffBibcFuLPv/GRLXRVEVk7PhcReGa9AyPh6css434GOPWkEJoR3TGl
         t5hY+nUqBqN1HI5nc7550KF4RpiPi7S83sWPUUctoKG0O2MJjk32IQ5t+Bgn4XpDD/+1
         toXA==
X-Gm-Message-State: AA+aEWb4kUTSJnlc6D25cj/WQc46+lTdFGq0SCoA6up0ILNU8oCQZhJ3
        +9rgQ3K8A3GV/T3WMNbFWbM+Rur/1PVxG60O/9TDWg==
X-Google-Smtp-Source: AFSGD/U/LkPppFlHFTz7CAE0T+Ke3D7zL5uaLIpr865a7GwILN1XgMUdNCb0b2hognUG2qgN2epog+6ChKTef8woxNc=
X-Received: by 2002:a50:ac81:: with SMTP id x1mr15103189edc.71.1543156758652;
 Sun, 25 Nov 2018 06:39:18 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-8-deepa.kernel@gmail.com> <CAF=yD-K=ZLZ_S=Y6YnhvvkfKQS=21ujwiGd7+JB9yDMtiX_9hg@mail.gmail.com>
 <CAF=yD-K3Ga8qojSh5Epa6m4EYn-Lvdo=e38MnFqOKch1128VHw@mail.gmail.com>
 <CABeXuvoDPvT45CCt2L0TReqtb1Q_-E8+toYu6qjiP0cxfdQNdA@mail.gmail.com> <CABeXuvr6fi9UPwMvuafx7MwEta-Sx1TLNN0KQ8HQHhn=vAne5Q@mail.gmail.com>
In-Reply-To: <CABeXuvr6fi9UPwMvuafx7MwEta-Sx1TLNN0KQ8HQHhn=vAne5Q@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 25 Nov 2018 09:38:41 -0500
Message-ID: <CAF=yD-+ZiBR+VFzDnKOKPBCuNF_wbAe6goNO8KXYQH105Sg=0g@mail.gmail.com>
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
X-archive-position: 67480
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

> > > > Same for the tcp case above, really, and in the case of the next patch
> > > > for SO_TIMESTAMPING_NEW
> > >
> > > That naming convention, ..._2038, is not the nicest, of course. That
> > > is not the relevant bit in the above comment.
>
> it could be  __sock_recv_timestamp64().
> But, these timestamps should be doing exactly the same thing as the
> old ones and I thought it would be nicer to keep the same code path.
> I can change it to as per above.

Please minimize code changes. It breaks git blame and longer patches
are harder to review.

In this specific case, from a readability point of view, I find new functions
that map one-to-one onto the new interfaces also more readable than
deeper nested branches in place.

> > So we introduce new y2038 safe timestamp options for 32 bit ABIs. We
> > assume that 32 bit applications will switch to new ABIs at some point,
> > but leave the older timestamps as is.
> > I can update the commit text as per above.
>
> We have been avoiding adding timeval64 timestamps to discourage users
> from using these types in the interfaces.
> We want to keep all the uapi time interfaces to use __kernel_*
> interfaces. And, we already provide __kernel_timespec interface for
> such instances.
> But, in this case we do not have an option. So we introduce a type
> specific to sockets.

This structure just holds a timestamp. It does not seem socket specific.
I don't mean to bikeshed the naming point too much, but timeval_ll or
so may be more representative than tying it to a socket.

As for the general naming, xxx64 or xxx2038 are more descriptive than xxx_NEW.
