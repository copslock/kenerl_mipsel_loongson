Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Feb 2005 16:20:14 +0000 (GMT)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.198]:20590 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225395AbVBXQT7>;
	Thu, 24 Feb 2005 16:19:59 +0000
Received: by wproxy.gmail.com with SMTP id 57so160279wri
        for <linux-mips@linux-mips.org>; Thu, 24 Feb 2005 08:19:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kE0EyGiiVMRhY6pekpMaFZlYDjNTHsgk6FTLAsnQRzzzNKJjn2/0VIhkGuOlXb1gFA/0htn/WAZHP72WPiMsQZGbmFYbCe59xCdaNw3uT3FOtqt7ezr29RrMl6QFJfFJ0DbeG2W/Q2SfehquLiPaPhqIvkwwVV4kHAY2zAWSkbc=
Received: by 10.54.7.72 with SMTP id 72mr62213wrg;
        Thu, 24 Feb 2005 08:19:52 -0800 (PST)
Received: by 10.54.41.3 with HTTP; Thu, 24 Feb 2005 08:19:51 -0800 (PST)
Message-ID: <ecb4efd105022408199abf2c3@mail.gmail.com>
Date:	Thu, 24 Feb 2005 11:19:51 -0500
From:	Clem Taylor <clem.taylor@gmail.com>
Reply-To: Clem Taylor <clem.taylor@gmail.com>
To:	JP Foster <jp.foster@exterity.co.uk>
Subject: Re: Big Endian au1550
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1109239495.8389.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1109157737.16445.6.camel@localhost.localdomain>
	 <000301c5199d$3154ad40$0300a8c0@Exterity.local>
	 <1109160313.16445.20.camel@localhost.localdomain>
	 <cb80abe539fa80effd786cacc1340de7@embeddededge.com>
	 <1109177856.18018.13.camel@kronenbourg.scs.ch>
	 <000001c519d1$84d9c250$0300a8c0@Exterity.local>
	 <1109239495.8389.8.camel@localhost.localdomain>
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

> Great, but I still can't get a running kernel from cvs mips-linux for
> a DB1550 board. Is it perhaps the toolchain? I'm using gcc-3.4.1 perhaps
> that is too recent.
> 
> Tried mipsel last night and got the same result as big end so I suspect
> it may be my compiler/binutils combination. Is there are recommended
> toolchain for mips. Should I go build gcc-2.95 and binutils 2.12 ?

I'm not sure about mipseb, but I've used both crosstool and buildroot
to build toolchains to compile a mipsel 2.6.10 kernel for the
DBAu1550. The kernel is the linux-mips cvs head from a few weeks ago.
Right now I'm using gcc 3.4.3 and binutils 2.15.94.0.2 20041220 that
was built with a recent buildroot checkout.

When I first tried to compile the 2.6.10 I was using
crosstool-0.28-rc37 and I ran into some binutils issues. I ended up
using gcc-3.4.1-glibc-2.3.2 with binutils-050110 (I'm not sure where I
got that). When I switched to buildroot I was able to use the latest
tools it had support for.

                                --Clem
