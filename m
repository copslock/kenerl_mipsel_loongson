Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2006 08:39:25 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:25128 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038966AbWJEHjV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2006 08:39:21 +0100
Received: by mo.po.2iij.net (mo31) id k957dJKj077360; Thu, 5 Oct 2006 16:39:19 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id k957dHLU006916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-mips@linux-mips.org>; Thu, 5 Oct 2006 16:39:18 +0900 (JST)
Date:	Thu, 5 Oct 2006 16:39:17 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	linux-mips@linux-mips.org
Subject: Re: Roll-your-own Toolchain Builds
Message-Id: <20061005163917.1a6480e4.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <200610050710.k957AVKf040935@mbox33.po.2iij.net>
References: <20061002231432.733374f7.yoichi_yuasa@tripeaks.co.jp>
	<20061002151800.GA25180@linux-mips.org>
	<200610030144.k931i4TD002658@mbox32.po.2iij.net>
	<4522175B.80901@nec.com.au>
	<Pine.LNX.4.64.0610031034490.28786@yvahk3.pbagnpgbe.fr>
	<45249FE6.8080800@nec.com.au>
	<20061005151756.6911f9de.yoichi_yuasa@tripeaks.co.jp>
	<4524AB69.4040802@nec.com.au>
	<200610050710.k957AVKf040935@mbox33.po.2iij.net>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Pak,

I received error mail from your mail server.

On Thu, 05 Oct 2006 17:15:55 +1000
Pak Woon <pak.woon@nec.com.au> wrote:

> 
> My hello.c is:-
> void main ( void )
> {
>    volatile int i,j,k;
> 
>    i = 2;
>    j = 1;
>    k = i + j;
> }

main() needs C library.

Yoichi
