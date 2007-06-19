Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2007 17:56:13 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.182]:34296 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20023657AbXFSQ4L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Jun 2007 17:56:11 +0100
Received: by py-out-1112.google.com with SMTP id f31so4047516pyh
        for <linux-mips@linux-mips.org>; Tue, 19 Jun 2007 09:55:09 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e12ofQi3i7A+kXhFlyBbOksFOyPJ37mIxisv+Jed8P04EmWEmRyaw54Bwo7RYEWacMtdZN0PV1IxczuFjqtdJIxXPdjHgg0REIvn5e8tgIqvbWvwO2sOnJ2aNKXY3oxTfMqEMo3X5GjhZbQCGwqt5n8jeppPIaG4ZV/IasRGC4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MRuhf5JIfJwwTsWr9KcdZU9XFB11zOMlTvEKJs+H/qEu6wZ65JxSMmLz/nlG7htLmnHBjENhgHs8YHdHceApWdo+bsH2TtT+63Uw2rCxQTvM/phJFPN4zo1aSqi8ofJAZqcG8QBOTwAy9ErDJ41FwMDsgnN11ThA//KEsFmJxDQ=
Received: by 10.64.233.12 with SMTP id f12mr11852169qbh.1182272109564;
        Tue, 19 Jun 2007 09:55:09 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Tue, 19 Jun 2007 09:55:09 -0700 (PDT)
Message-ID: <cda58cb80706190955p44ca7203rb1cbf2604f9381f0@mail.gmail.com>
Date:	Tue, 19 Jun 2007 18:55:09 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time code.
Cc:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	macro@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <467802E3.4040703@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80706180238r17da4434jcdee307b0385729b@mail.gmail.com>
	 <20070619.005121.118948229.anemo@mba.ocn.ne.jp>
	 <cda58cb80706190033y47ccec58u8fc8254ced24f96f@mail.gmail.com>
	 <20070620.010805.23009775.anemo@mba.ocn.ne.jp>
	 <467802E3.4040703@ru.mvista.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 6/19/07, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> Atsushi Nemoto wrote:
>
> >>What do you mean by "pnx8550 can have customized copy of cp0_hpt
> >>routines" ? Do you mean that it should copy the whole clock event
> >>driver ?
>
> >>It seems to me that using cp0 hpt as a clock event only is a valid usage...
>
> > Well, I thought the customized cp0 clockevent codes (custom
> > .set_next_event routine is needed anyway, isn't it?) would be small
> > enough.  But I did not investigate deeply.  If generic cp0 hpt can
> > handle this beast without much bloating, it would be great.
>
>     IMO, the generic code should only have the standard MIPS count/compare
> support and let the platform code to initialize it if it choses so and also
> register its own specific clock[source|event] devices if it choses so -- i.e
> *not* what the current clocksource code does...
>

And this is _exactly_ what the new patch 5/5 I sent yesteday does and
what I suggested to DEC and PNX5550 thing...

Please have a look to it (if you have time of course) at:
http://marc.info/?l=linux-mips&m=118217055927261&w=2

CP0 count/compare support is handled in arch/mips/kernel/hpt-cp0.c new
file. Therefore it can be compiled or not easily. And it lets the
platform code initialize it if it wants to. So we can easily now see
which platform is using what, and get rid of the ugly thing in generic
time code trying to detect which hpt the platform is trying to use.
The main issue with this approach is that we need to update a lot of
board code which is a pain because it's currently hard to guess what
it does and platform maintainers seem to be really busy to help in
this area...

Thanks
-- 
               Franck
