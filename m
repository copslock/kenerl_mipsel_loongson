Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2007 08:55:50 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:24079 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021653AbXFRHzs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Jun 2007 08:55:48 +0100
Received: by mo.po.2iij.net (mo32) id l5I7thOW091417; Mon, 18 Jun 2007 16:55:43 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox300) id l5I7tguM024101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 18 Jun 2007 16:55:42 +0900
Date:	Mon, 18 Jun 2007 16:55:42 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	"mao ye" <ym.uestc@gmail.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: About binutils for mips
Message-Id: <20070618165542.6967512c.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <e6480a290706180036m23996de9re866607186f404cf@mail.gmail.com>
References: <e6480a290706180036m23996de9re866607186f404cf@mail.gmail.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Mon, 18 Jun 2007 15:36:06 +0800
"mao ye" <ym.uestc@gmail.com> wrote:

> I compile the rtems ,but I meet some trouble:
> opcode not supported on this processor: mips1(mips1)'dmfc0 $8,$14'
>  opcode not supported on this processor: mips1(mips1)'dadd $5,$4,$0'
>  opcode not supported on this processor: mips1(mips1)'dsll $9,$9,2'
>  opcode not supported on this processor: mips1(mips1)'eret'
> 
> The version of gcc is gcc-3.4.3,and the version of binutils is 2.15.
> 
> Does the binutils-2.15 not support the mips1 or some other reasons?

Their instructions are mips3, not mips1.

Yoichi
