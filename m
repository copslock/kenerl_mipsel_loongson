Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2006 08:57:20 +0100 (BST)
Received: from ns2.nec.com.au ([147.76.180.2]:4266 "EHLO ns2.nec.com.au")
	by ftp.linux-mips.org with ESMTP id S20037761AbWJCH5Q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2006 08:57:16 +0100
Received: from smtp1.nec.com.au (unknown [172.31.8.18])
	by ns2.nec.com.au (Postfix) with ESMTP id 70CD33B6B6
	for <linux-mips@linux-mips.org>; Tue,  3 Oct 2006 17:57:04 +1000 (EST)
Received: from [147.76.208.162] ([147.76.208.162])
	by tns.neca.nec.com.au (8.12.8/8.12.8) with ESMTP id k9382jZl030035
	for <linux-mips@linux-mips.org>; Tue, 3 Oct 2006 18:02:48 +1000
Message-ID: <4522175B.80901@nec.com.au>
Date:	Tue, 03 Oct 2006 17:55:07 +1000
From:	Pak Woon <pak.woon@nec.com.au>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Roll-your-own Toolchain Builds
References: <20061002231432.733374f7.yoichi_yuasa@tripeaks.co.jp>	<20061002151800.GA25180@linux-mips.org> <200610030144.k931i4TD002658@mbox32.po.2iij.net>
In-Reply-To: <200610030144.k931i4TD002658@mbox32.po.2iij.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <pak.woon@nec.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pak.woon@nec.com.au
Precedence: bulk
X-list: linux-mips

Hi all,

I am trying to roll-my-own toolchain by following the instructions 
outlined in http://www.linux-mips.org/wiki/Toolchains. I have 
encountered the "cannot create executables" / "crt01.o: No such file" 
problem. There are a lot of people who see the same thing, but there 
does not seem to be a definative answer.

FYI, my packages are:-
binutils-2.16.91.0.6-5
gcc-4.1.1-1.fc5
lib-gcc-4.1.1-1.fc5
gcc-gfortran-4.1.1-1.fc5
gcc-g++-4.1.1-1.fc5

Regards,
Pak
