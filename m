Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2010 16:19:11 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:40560 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493245Ab0LBPTE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Dec 2010 16:19:04 +0100
X-Authority-Analysis: v=1.1 cv=6ptpMFIBtxRk0xdOb6IhJTbTLVRlKjWFes7R4SsWCrA= c=1 sm=0 a=ClBoAdZ3F6cA:10 a=Q9fys5e9bTEA:10 a=OPBmh+XkhLl+Enan7BmTLg==:17 a=WPyIoOwQAAAA:8 a=w5Mvk01vzc27DdUpXGAA:9 a=8DTp0P9Tbi2iqBqt1eMA:7 a=lEtgAm3pwO0Pt8yHSJ7MvwtLFpUA:4 a=PUjeQqilurYA:10 a=1DbiqZag68YA:10 a=OPBmh+XkhLl+Enan7BmTLg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.242.120.143
Received: from [67.242.120.143] ([67.242.120.143:39383] helo=[192.168.23.10])
        by hrndva-oedge01.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id 6B/E1-26142-1E8B7FC4; Thu, 02 Dec 2010 15:18:58 +0000
Subject: Re: Build failure triggered by recordmcount
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Arnaud Lacombe <lacombar@gmail.com>,
        wu zhangjin <wuzhangjin@gmail.com>,
        John Reiser <jreiser@bitwagon.com>, linux-mips@linux-mips.org
In-Reply-To: <20101202145412.GA7503@linux-mips.org>
References: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>
         <AANLkTim-+1csKoCc7kqXERmLZRSt9LAAB=JPK+0gaYPo@mail.gmail.com>
         <AANLkTikaUxKqsqXKYpETOnWAMuCi5gp30ANux0RQuK6Z@mail.gmail.com>
         <AANLkTinr1bU+_YCTW9xyJ9H0qiSOifBMsxC6iujszMvs@mail.gmail.com>
         <20101202145412.GA7503@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Thu, 02 Dec 2010 10:18:56 -0500
Message-ID: <1291303136.12005.6.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Thu, 2010-12-02 at 14:54 +0000, Ralf Baechle wrote:
> > > So, we may need to custom our own elf.h for recordmcount according
> to
> > > the target type(endian here) of the kernel image:
> > >
> > > At first, pass the target information to recordmcount(only a demo
> > > here, we may need to clear it carefully):
> 
> Looks all right to me.  Steven, can you merge it?
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> 
Will do, thanks!

-- Steve
