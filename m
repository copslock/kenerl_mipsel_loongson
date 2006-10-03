Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2006 18:45:19 +0100 (BST)
Received: from mail.zeugmasystems.com ([192.139.122.66]:27024 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20038857AbWJCRpR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2006 18:45:17 +0100
Content-class: urn:content-classes:message
Subject: RE: Roll-your-own Toolchain Builds
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date:	Tue, 3 Oct 2006 10:45:12 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D3E6D9E@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Roll-your-own Toolchain Builds
thread-index: AcbmxqvYZrrljagrS1iCAgNkhmYUXgASKKZQ
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	"Yoichi Yuasa" <yoichi_yuasa@tripeaks.co.jp>,
	"Pak Woon" <pak.woon@nec.com.au>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

> Yoichi Yuasa wrote:
> Pak Woon <pak.woon@nec.com.au> wrote:
> 
> > Hi all,
> > 
> > I am trying to roll-my-own toolchain by following the instructions 
> > outlined in http://www.linux-mips.org/wiki/Toolchains. I have 
> > encountered the "cannot create executables" / "crt01.o: No 
> such file" 
> > problem. There are a lot of people who see the same thing, 
> but there 
> > does not seem to be a definative answer.
> 
> When did you get the message?
> building toolchain or ...
> 
> > FYI, my packages are:-
> > binutils-2.16.91.0.6-5
> > gcc-4.1.1-1.fc5
> > lib-gcc-4.1.1-1.fc5
> > gcc-gfortran-4.1.1-1.fc5
> > gcc-g++-4.1.1-1.fc5
> 
> Did you install glibc-devel package?

The "compiler cannot create executables" is spit out by the
Autoconf-generated configure script when it tries to compile a
feature-test program using a some compiler that has no library. That
could mean that the development packages are not installed on the host
machine for compiling programs against glibc. But it could also possibly
mean that the wrong compiler is being run, i.e. a bootstrapping compiler
with no library.

Use a clean path when building stuff. Before you do anything else:

  PATH=/bin:/usr/bin

Otherwise who knows what will get picked up for execution when all those
mountains of scriptology are executing.
