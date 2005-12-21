Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2005 09:45:22 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:36505 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S3458540AbVLUJpD
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Dec 2005 09:45:03 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id jBL9jnf3004465;
	Wed, 21 Dec 2005 01:45:55 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with SMTP id jBL9jllk004606;
	Wed, 21 Dec 2005 01:45:48 -0800 (PST)
Message-ID: <002f01c60613$8b346590$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"zhuzhenhua" <zzh.hust@gmail.com>, <ppopov@embeddedalley.com>
Cc:	<linux-mips@linux-mips.org>
References: <50c9a2250512210051q85f813fx27b0533fe66165e2@mail.gmail.com> <1135155432.9009.18.camel@localhost.localdomain> <50c9a2250512210106h7bca5c7fu5714ea3aa16cde8a@mail.gmail.com>
Subject: Re: does someone succeed in making the toolchain for 2.6 kernel?
Date:	Wed, 21 Dec 2005 10:47:21 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

I've been using the 6.02 MIPS SDE for my 2.6 kernel builds.  I'm not
100% certain that it's exactly the same one that you'll find on the page at
http://www.linux-mips.org/wiki/MIPS_SDE_Installation
but it's close enough where I'd suggest at least giving it a try.

            Regards,

            Kevin K.

----- Original Message ----- 
From: "zhuzhenhua" <zzh.hust@gmail.com>
To: <ppopov@embeddedalley.com>
Cc: <linux-mips@linux-mips.org>
Sent: Wednesday, December 21, 2005 10:06 AM
Subject: Re: does someone succeed in making the toolchain for 2.6 kernel?


> i am not sure which toolchain can work for the 2.6 kernel
> can you suggest one?
> thanks
> 
> On 12/21/05, Pete Popov <ppopov@embeddedalley.com> wrote:
> > On Wed, 2005-12-21 at 16:51 +0800, zhuzhenhua wrote:
> > > i want to compile a 2.6.14 kernel for mips 4kec, does someone compile
> > > the 2.6 kernel with self-build toolchain?
> >
> > Quite a few people have, I'm sure.
> >
> > > how to select the gcc,
> > > gdb,glibc,linux head and binutils version?
> > > and where to get the guide doc?
> >
> > If you have such questions, I would suggest you start by compiling and
> > booting your kernel with a toolchain and distribution that already
> > works. Build your own toolchain, if you must, later.
> >
> > Pete
> >
> >
> 
> Best regards
> zhuzhenhua
> 
> 
