Received:  by oss.sgi.com id <S553844AbQJNQUO>;
	Sat, 14 Oct 2000 09:20:14 -0700
Received: from ltc.ltc.com ([38.149.17.171]:38921 "HELO ltc.com")
	by oss.sgi.com with SMTP id <S553841AbQJNQUB>;
	Sat, 14 Oct 2000 09:20:01 -0700
Received: from gw1.ltc.com (gw1.ltc.com [38.149.17.163]) by ltc.com (NTMail 3.03.0017/1.afdd) with ESMTP id da314239 for <linux-mips@oss.sgi.com>; Sat, 14 Oct 2000 12:25:43 -0400
Message-ID: <005601c035fa$e4b13a10$0701010a@ltc.com>
From:   "Bradley D. LaRonde" <brad@ltc.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>, "Jay Carlson" <nop@nop.com>
Cc:     <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>
References: <20001014170928.B6499@bacchus.dhis.org> <KEEOIBGCMINLAHMMNDJNGECBCAAA.nop@nop.com> <20001014181257.C6499@bacchus.dhis.org>
Subject: Re: stable binutils, gcc, glibc ...
Date:   Sat, 14 Oct 2000 12:22:05 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

----- Original Message -----
From: "Ralf Baechle" <ralf@oss.sgi.com>
To: "Jay Carlson" <nop@nop.com>
Cc: "Jay Carlson" <nop@place.org>; <linux-mips@fnet.fr>;
<linux-mips@oss.sgi.com>
Sent: Saturday, October 14, 2000 12:12 PM
Subject: Re: stable binutils, gcc, glibc ...


> On Sat, Oct 14, 2000 at 12:11:39PM -0400, Jay Carlson wrote:
>
> > > Actually I'm trying to kill this entire naming problem by getting all
> > > patches back to the respective maintainers.  Result:  no pending
patches
> > > for cvs binutils, only tiny ones for glibc-current and egcs-current.
> >
> > What's going to happen to glibc 2.0.6?  I suspect the embedded people
are
> > going to be stuck using it until we figure out how to trim down the
binary
> > size of 2.2.
>
> Which why I guess we still have to maintain it for a while or even come
> up with some alternative small libc.

I am fine with using 2.0.6 for a long time, at least until some markedly
superior option is available.

Regards,
Brad
