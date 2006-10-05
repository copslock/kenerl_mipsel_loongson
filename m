Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2006 07:18:03 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:20509 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037651AbWJEGSC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2006 07:18:02 +0100
Received: by mo.po.2iij.net (mo30) id k956Hxpk088002; Thu, 5 Oct 2006 15:17:59 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox30) id k956HuvD067996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 5 Oct 2006 15:17:56 +0900 (JST)
Date:	Thu, 5 Oct 2006 15:17:56 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Pak Woon <pak.woon@nec.com.au>
Cc:	linux-mips@linux-mips.org
Subject: Re: Roll-your-own Toolchain Builds
Message-Id: <20061005151756.6911f9de.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <45249FE6.8080800@nec.com.au>
References: <20061002231432.733374f7.yoichi_yuasa@tripeaks.co.jp>
	<20061002151800.GA25180@linux-mips.org>
	<200610030144.k931i4TD002658@mbox32.po.2iij.net>
	<4522175B.80901@nec.com.au>
	<Pine.LNX.4.64.0610031034490.28786@yvahk3.pbagnpgbe.fr>
	<45249FE6.8080800@nec.com.au>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Pak,

On Thu, 05 Oct 2006 16:02:14 +1000
Pak Woon <pak.woon@nec.com.au> wrote:

> I am now trying to build a simple program with my new toolchain and I've 
> come across the "can't find crt1.o" problem again. I am struggling with 
> this.

You need glibc or uClibc for MIPS target.

If you want to use uClibc, see buildroot link in
http://www.linux-mips.org/wiki/Toolchains .

Yoichi
