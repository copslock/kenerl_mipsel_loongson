Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 22:32:00 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.201]:48585 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226325AbVGGVbk> convert rfc822-to-8bit;
	Thu, 7 Jul 2005 22:31:40 +0100
Received: by wproxy.gmail.com with SMTP id i20so299783wra
        for <linux-mips@linux-mips.org>; Thu, 07 Jul 2005 14:32:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MWfXgjnj9sBo9+dDcgEVgTyGaiHhmoUyFZcHEE0cgAiiPpT1ebJ3w8zrDSSZHgbuGP9vWEYt1cBu2C//9NE7hh6kUPAnXedMFTFcGYvSyVkE+qqaxc/JA9cxphIpWw/JEG+EM1ZZt9YPMcjeD+OqUK3aCzskfmjJ0zIQwxbSYBQ=
Received: by 10.54.100.5 with SMTP id x5mr1087243wrb;
        Thu, 07 Jul 2005 14:32:11 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Thu, 7 Jul 2005 14:32:10 -0700 (PDT)
Message-ID: <2db32b72050707143277bb0532@mail.gmail.com>
Date:	Thu, 7 Jul 2005 14:32:10 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	ppopov@embeddedalley.com
Subject: Re: insmod error for pcmcia support on db1550
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <1120770143.5777.85.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2db32b7205070713553df6096a@mail.gmail.com>
	 <1120770143.5777.85.camel@localhost.localdomain>
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

Thanks.
I just joined the linux (mips) community a few weeks. :(
I will try google first next time.

On 7/7/05, Pete Popov <ppopov@embeddedalley.com> wrote:
> On Thu, 2005-07-07 at 13:55 -0700, rolf liu wrote:
> > I compiled linux 2.6.12 with the pcmcia support. And I got 3 module
> > files: au1x00_ss.ko, pcmcia.ko, and pcmcia_core.ko.
> >
> > I used" insmod au1x00_ss.ko", but system tells me:
> > >>insmod: QM_MODULES: Function not implemented
> >
> > The same thing happens to pcmcia_core.ko and pcmcia.ko too.
> >
> > What is the problem here? Do I need to recompile the module untilities
> > for the 2.6 kernels?
> >
> > Also, when I typed "lspci -v", no information for the pcmcia showed up.
> >
> > Thanks for comments
> 
> Just my 2c: you have to do some work yourself before you ping the
> mailing list. If you search on google for the above error, you'll find
> the answer within 5 min.
> 
> Yes, you do need a new modules loading package which you'll have to
> compile.
> 
> Pete
> 
>
