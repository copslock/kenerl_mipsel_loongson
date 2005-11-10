Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2005 15:31:38 +0000 (GMT)
Received: from xproxy.gmail.com ([66.249.82.200]:37055 "EHLO xproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3457893AbVKJPbU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2005 15:31:20 +0000
Received: by xproxy.gmail.com with SMTP id s19so513933wxc
        for <linux-mips@linux-mips.org>; Thu, 10 Nov 2005 07:32:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oDMCejdXqKENZg8cJ/aXqQy97Ath27pj6dqknBayszhvIzC7wefy8wcvj1PiWR8Uzb4ZzXregp551Tep2zg2abQZvNK92HBzIK7FBDkoO3e1hCSPC0PLOgsNvMDMPf3AzG4XBMeBMtbTl+FUNJx0+uIfCsqMfHd8AprlJKGsIEQ=
Received: by 10.70.100.17 with SMTP id x17mr839009wxb;
        Thu, 10 Nov 2005 07:32:48 -0800 (PST)
Received: from pantathon.404.gr ( [195.97.100.53])
        by mx.gmail.com with ESMTP id h39sm555234wxd.2005.11.10.07.32.22;
        Thu, 10 Nov 2005 07:32:48 -0800 (PST)
From:	Pantelis Antoniou <pantelis.antoniou@gmail.com>
Reply-To: pantelis.antoniou@gmail.com
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: smc91x support
Date:	Thu, 10 Nov 2005 17:37:08 +0200
User-Agent: KMail/1.8
Cc:	matej.kupljen@ultra.si, linux-mips@linux-mips.org
References: <1131634331.18165.30.camel@localhost.localdomain> <20051111.001543.93019156.anemo@mba.ocn.ne.jp>
In-Reply-To: <20051111.001543.93019156.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511101737.09316.pantelis.antoniou@gmail.com>
Return-Path: <pantelis.antoniou@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pantelis.antoniou@gmail.com
Precedence: bulk
X-list: linux-mips

On Thursday 10 November 2005 17:15, Atsushi Nemoto wrote:
> >>>>> On Thu, 10 Nov 2005 15:52:11 +0100, Matej Kupljen <matej.kupljen@ultra.si> said:
> 
> matej> What is the patch required for smc91x.h?
> 
> I also want to know about the patch.
> 
> matej> I also added support for smc91x.h to enable it on the DBAU1200,
> matej> but as I wrote in another mail, I get bad performance.  I
> matej> enabled the debug mode and I now I see that I get a lot of
> matej> overruns, like:
> matej> ...
> matej> [4294761.172000] eth0: RX overrun (EPH_ST 0x0001)
> matej> [4294761.190000] eth0: RX overrun (EPH_ST 0x0001)
> matej> [4294761.198000] eth0: RX overrun (EPH_ST 0x0001)
> matej> ...
> 
> matej> Is there any solution to this?
> 
> I have similar problem on my several custom boards with SMC91C111.  I
> see so many RX overrun, but I can not see why it happens.  Forcing to
> 10Mbps/HalfDuplex reduced the overrun count (and works better than
> 100Mbps), but it is not preferable, of course ...
> 
> ---

I'm afraid there's not much that you can do...

The old driver just didn't report the overruns. The generic one 
does, that's why you see the overrun error.

And yes performance is bad with this chip. I'm not sure if DMA would
help much, since the overrun occurs because the chip does not have
enough internal buffers. I don't think that we can service the interrupts
fast enough to prevent the overruns...

IMHO the only solution is to use a decent chip...

> Atsushi Nemoto
> 
> 

Regards

Pantelis
