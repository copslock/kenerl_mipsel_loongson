Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2006 09:33:11 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:22589 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037845AbWJCIdK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2006 09:33:10 +0100
Received: by mo.po.2iij.net (mo32) id k938X6Xb009831; Tue, 3 Oct 2006 17:33:06 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id k938X4UJ011881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 3 Oct 2006 17:33:04 +0900 (JST)
Date:	Tue, 3 Oct 2006 17:33:04 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Pak Woon <pak.woon@nec.com.au>
Cc:	linux-mips@linux-mips.org
Subject: Re: Roll-your-own Toolchain Builds
Message-Id: <20061003173304.04e8b907.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <4522175B.80901@nec.com.au>
References: <20061002231432.733374f7.yoichi_yuasa@tripeaks.co.jp>
	<20061002151800.GA25180@linux-mips.org>
	<200610030144.k931i4TD002658@mbox32.po.2iij.net>
	<4522175B.80901@nec.com.au>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Tue, 03 Oct 2006 17:55:07 +1000
Pak Woon <pak.woon@nec.com.au> wrote:

> Hi all,
> 
> I am trying to roll-my-own toolchain by following the instructions 
> outlined in http://www.linux-mips.org/wiki/Toolchains. I have 
> encountered the "cannot create executables" / "crt01.o: No such file" 
> problem. There are a lot of people who see the same thing, but there 
> does not seem to be a definative answer.

When did you get the message?
building toolchain or ...

> FYI, my packages are:-
> binutils-2.16.91.0.6-5
> gcc-4.1.1-1.fc5
> lib-gcc-4.1.1-1.fc5
> gcc-gfortran-4.1.1-1.fc5
> gcc-g++-4.1.1-1.fc5

Did you install glibc-devel package?

Yoichi
