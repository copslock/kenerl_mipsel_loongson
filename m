Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2005 20:40:52 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.205]:50524 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226288AbVGETkh> convert rfc822-to-8bit;
	Tue, 5 Jul 2005 20:40:37 +0100
Received: by wproxy.gmail.com with SMTP id i25so963563wra
        for <linux-mips@linux-mips.org>; Tue, 05 Jul 2005 12:40:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lLpxi9VtoBbJkKxgdzsnNmwTYS1X0TuCbPTdwm8PRQOmLz9P3Y26bgm06+5QdVg6YjfQ7Hz/IzM8VWRvxovLghlEsptekPjL2z9Cri3vLs5uGTKAGtJuIt8J0LXtsqhBl1iNZqiUhy4cvZyOACHi9J5CTSRpE8y00ZJD1H/KeK0=
Received: by 10.54.115.4 with SMTP id n4mr4873663wrc;
        Tue, 05 Jul 2005 12:40:54 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Tue, 5 Jul 2005 12:40:54 -0700 (PDT)
Message-ID: <2db32b72050705124078a48aed@mail.gmail.com>
Date:	Tue, 5 Jul 2005 12:40:54 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	ppopov@embeddedalley.com
Subject: Re: possible serial driver fixup for au1x00 in 2.6?
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <1120266383.5987.46.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2db32b720507011756247735d6@mail.gmail.com>
	 <1120266383.5987.46.camel@localhost.localdomain>
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

Pete,
To try if 8250.c can work under db1550/linux 2.6.12, I turn off the
au1x00_uart.c config and just compiled in the 8250 support. When I
boot the kernel, nothing comes up through the console, which should be
provided by 8250 support, by 8250_early.c?

Any idea?

On 7/1/05, Pete Popov <ppopov@embeddedalley.com> wrote:
> On Fri, 2005-07-01 at 17:56 -0700, rolf liu wrote:
> > Basically, au1x00_uart.c is doing the same thing as 8250.c.
> 
> Basically.
> 
> > If I want
> > to add extra serial port support by 8250.c. There could be some
> > problem. Any idea?
> 
> Don't know, haven't tried it. In general, the au1x00 serial driver needs
> to be rewritten.
> 
> Pete
> 
>
