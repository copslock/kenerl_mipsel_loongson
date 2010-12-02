Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2010 13:41:47 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:40782 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493213Ab0LBMlo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Dec 2010 13:41:44 +0100
X-Authority-Analysis: v=1.1 cv=NFUeGz0loTdi/T6hXKngYYtckjed7x3pKvNOqmBBK18= c=1 sm=0 a=ClBoAdZ3F6cA:10 a=Q9fys5e9bTEA:10 a=OPBmh+XkhLl+Enan7BmTLg==:17 a=x7__WfI_cIIZ8pTkQnEA:9 a=hkIQd6hWhJ326Va0KoKsjSwHE1QA:4 a=PUjeQqilurYA:10 a=OPBmh+XkhLl+Enan7BmTLg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.242.120.143
Received: from [67.242.120.143] ([67.242.120.143:39874] helo=[192.168.23.10])
        by hrndva-oedge04.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id 20/0D-12606-FF397FC4; Thu, 02 Dec 2010 12:41:37 +0000
Subject: Re: Build failure triggered by recordmcount
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Arnaud Lacombe <lacombar@gmail.com>,
        John Reiser <jreiser@bitwagon.com>, linux-mips@linux-mips.org,
        wu zhangjin <wuzhangjin@gmail.com>
In-Reply-To: <4CF78A96.8000109@mvista.com>
References: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>
         <AANLkTim-+1csKoCc7kqXERmLZRSt9LAAB=JPK+0gaYPo@mail.gmail.com>
         <AANLkTikaUxKqsqXKYpETOnWAMuCi5gp30ANux0RQuK6Z@mail.gmail.com>
         <AANLkTinr1bU+_YCTW9xyJ9H0qiSOifBMsxC6iujszMvs@mail.gmail.com>
         <4CEB37F8.1050504@bitwagon.com>
         <AANLkTikUZ=kQbWEtSNpw27pBPX-cSs2J+NaLODHG6T7O@mail.gmail.com>
         <4CF78A96.8000109@mvista.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Thu, 02 Dec 2010 07:41:34 -0500
Message-ID: <1291293694.12005.2.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Thu, 2010-12-02 at 15:01 +0300, Sergei Shtylyov wrote:
> > This patch does not seems to have made its way up to Linus tree, has
> > it been picked by anyone ?

I have it queued, but have been working on other things (things that pay
me ;-)

> 
>     It was not signed off, so couldn't be applied.

You're right! I only had it in the mbox to be queued. I would have
notice this when I pulled it into git.

John, Can you reply with your signed-off-by?

Thanks,

-- Steve
