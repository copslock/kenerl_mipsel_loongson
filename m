Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2006 10:10:35 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:4394 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037569AbWHGJKb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 Aug 2006 10:10:31 +0100
Received: by mo.po.2iij.net (mo32) id k779AOJ1071647; Mon, 7 Aug 2006 18:10:24 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id k779AKYv003840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 7 Aug 2006 18:10:21 +0900 (JST)
Date:	Mon, 7 Aug 2006 18:10:20 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	"Kishore K" <hellokishore@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Problem booting malta with 2.4.33-rc1
Message-Id: <20060807181020.37d94241.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <f07e6e0608062331p4ef621afn67764067f5b822c2@mail.gmail.com>
References: <f07e6e0608062331p4ef621afn67764067f5b822c2@mail.gmail.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, 7 Aug 2006 12:01:43 +0530
"Kishore K" <hellokishore@gmail.com> wrote:

> Hi,
> When trying to bring up Malta (4KC) board with 2.4.33-rc1 from linux-mips,
> the kernel crashes. Boot log is enclosed along with this mail. I am using
> the tool chain based on gcc 3.3.6, uClibc-0.9.27, binutils 2.14.90.0.8.
> When the same tool chain is used for 2.4.31 kernel, the board comes up
> without any issues.
> 
> Observed the same issue with tool chain based on gcc 3.4.4, uClibc-0.9.28,
> binutils 2.15.94. Same result is observed even with  Malta 24KEC and
> 2.4.33-rc1 kernel.
> 
> Does any one observe the same behaviour ? Am I missing something obvious
> here ?

I have seen the same problem with gcc 3.4.4 mipssde-6.03.01-20051114 and
 binutils 2.15.94 mipssde-6.03.01-20051114 with 2.6.6 kernel.
gcc 3.3.2 and binutils 2.14.90.0.8 20040114 has no problem with same kernel.

Yoichi
