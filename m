Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2006 07:53:30 +0100 (BST)
Received: from ns2.nec.com.au ([147.76.180.2]:62368 "EHLO ns2.nec.com.au")
	by ftp.linux-mips.org with ESMTP id S20037758AbWJEGx2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2006 07:53:28 +0100
Received: from smtp1.nec.com.au (unknown [172.31.8.18])
	by ns2.nec.com.au (Postfix) with ESMTP id BB6CD3B6A9
	for <linux-mips@linux-mips.org>; Thu,  5 Oct 2006 16:53:20 +1000 (EST)
Received: from [147.76.208.162] ([147.76.208.162])
	by tns.neca.nec.com.au (8.12.8/8.12.8) with ESMTP id k956xGZl014904;
	Thu, 5 Oct 2006 16:59:16 +1000
Message-ID: <4524AB69.4040802@nec.com.au>
Date:	Thu, 05 Oct 2006 16:51:21 +1000
From:	Pak Woon <pak.woon@nec.com.au>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: Roll-your-own Toolchain Builds
References: <20061002231432.733374f7.yoichi_yuasa@tripeaks.co.jp>	<20061002151800.GA25180@linux-mips.org>	<200610030144.k931i4TD002658@mbox32.po.2iij.net>	<4522175B.80901@nec.com.au>	<Pine.LNX.4.64.0610031034490.28786@yvahk3.pbagnpgbe.fr>	<45249FE6.8080800@nec.com.au> <20061005151756.6911f9de.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20061005151756.6911f9de.yoichi_yuasa@tripeaks.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <pak.woon@nec.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pak.woon@nec.com.au
Precedence: bulk
X-list: linux-mips

>>I am now trying to build a simple program with my new toolchain and I've 
>>come across the "can't find crt1.o" problem again. I am struggling with 
>>this.
> 
> 
> You need glibc or uClibc for MIPS target.
> 
> If you want to use uClibc, see buildroot link in
> http://www.linux-mips.org/wiki/Toolchains .

Okay, this is going to be a stupid question, but when I built the kernel 
for the MIPS target, I had no issues or a need for those libs. I assumed 
that for such a simple hello.c program, I would not need glibc or uClibc 
either.

Pak
