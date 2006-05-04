Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 19:34:38 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.196]:64721 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8133769AbWEDSeT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 May 2006 19:34:19 +0100
Received: by nz-out-0102.google.com with SMTP id z6so522857nzd
        for <linux-mips@linux-mips.org>; Thu, 04 May 2006 11:34:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=keiYSPhCOzg8cvq6TcK3URUoZKqFg+gX5YGAC07hya5kRIlLMhcQmQouQQkQKm9l+gwBErK37OZZjEnEVJFmbGyHII4Uuv/nVP+/0Sj1kHhNvfz4+dLCYddHaanFKQjWErpA/VWga7+9gydNxPDlhbBnL8+cRJU3d9xOOJAcai4=
Received: by 10.36.160.18 with SMTP id i18mr1468778nze;
        Thu, 04 May 2006 11:34:18 -0700 (PDT)
Received: by 10.36.49.2 with HTTP; Thu, 4 May 2006 11:34:18 -0700 (PDT)
Message-ID: <cda58cb80605041134ka111018t7171284c527c4635@mail.gmail.com>
Date:	Thu, 4 May 2006 20:34:18 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Thiemo Seufer" <ths@networkno.de>
Subject: Re: [PATCH] Make interrupt handler works for all cases
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20060502180436.GH5004@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80605020055r2597bf3ds9fb380aab8cbf7b3@mail.gmail.com>
	 <20060502094123.GB4301@linux-mips.org>
	 <cda58cb80605020330hfd0352ds11f7f80603092cde@mail.gmail.com>
	 <20060502104441.GA5004@networkno.de>
	 <cda58cb80605021048n14ec2aa5ldd27e0f9a6fceb8e@mail.gmail.com>
	 <20060502180436.GH5004@networkno.de>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/5/2, Thiemo Seufer <ths@networkno.de>:
> Franck Bui-Huu wrote:
> > 2006/5/2, Thiemo Seufer <ths@networkno.de>:
> > >Franck Bui-Huu wrote:
> > >> 2006/5/2, Ralf Baechle <ralf@linux-mips.org>:
> > >> >On Tue, May 02, 2006 at 09:55:51AM +0200, Franck Bui-Huu wrote:
> > >> >
> > >> >> specially when the kernel is mapped.
> > >> >
> > >> >At which time you're on very fragile ice because TLB instructions should
> > >> >better be executed from an unmapped address ...
> > >> >
> > >>
> > >> well TLB entry used by the kernel is wired, so it should work fined,
> > >> shouldn't it ?
> > >
> > >The architecture spec doesn't guarantee it will.
> >
> > having a quick look at the TLB handling code, it seems that the code
> > assumes it will...
>
> I don't know which code you are looking at, but the kernel's TLB
> handling doesn't run in mapped space. (The ip27 is an exception,
> I assume the R1x000 allows for mapped TLB handling.)
>

I have assumed the same for r4k cpu and it seems to work fine...
Anyways, Ralf can you apply this patch ?

Thanks
--
               Franck
