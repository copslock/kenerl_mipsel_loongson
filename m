Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 17:42:21 +0100 (BST)
Received: from rproxy.gmail.com ([IPv6:::ffff:64.233.170.195]:21066 "EHLO
	mproxy.gmail.com") by linux-mips.org with ESMTP id <S8224929AbUHRQmJ>;
	Wed, 18 Aug 2004 17:42:09 +0100
Received: by mproxy.gmail.com with SMTP id 76so187304rnk
        for <linux-mips@linux-mips.org>; Wed, 18 Aug 2004 09:42:04 -0700 (PDT)
Received: by 10.38.13.31 with SMTP id 31mr510410rnm;
        Wed, 18 Aug 2004 09:42:04 -0700 (PDT)
Message-ID: <e2eac657040818094264dc6a3b@mail.gmail.com>
Date: Wed, 18 Aug 2004 12:42:04 -0400
From: Tim Lai <tinglai@gmail.com>
Reply-To: Tim Lai <tinglai@gmail.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: Re: problem with prefetch in user space
Cc: Eric DeVolder <eric.devolder@amd.com>, linux-mips@linux-mips.org
In-Reply-To: <20040818153148.GI23756@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <e2eac65704081716345c78b7c6@mail.gmail.com> <41235841.6090105@amd.com> <e2eac65704081808061f27cb5a@mail.gmail.com> <20040818153148.GI23756@rembrandt.csv.ica.uni-stuttgart.de>
Return-Path: <tinglai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tinglai@gmail.com
Precedence: bulk
X-list: linux-mips

Thanks. 
I did some search and find no answer. How do I define %0 as a register input and
assign the value of "addr" to it?

Tim 

On Wed, 18 Aug 2004 17:31:48 +0200, Thiemo Seufer
<ica2_ts@csv.ica.uni-stuttgart.de> wrote:
> Tim Lai wrote:
> > Thanks for the suggestion.
> > I tried it, and still got the same error:
> >
> > /tmp/cc73TRSF.s:5521: Error: illegal operands `pref'
> 
> That's because you use
> 
> > > >                         "     pref       4 ,  0(%0)  \n"
> > > >
> > > >                         ".set pop                   \n");
> 
> without defining %0 as a register input.
> 
> 
> Thiemo
>
