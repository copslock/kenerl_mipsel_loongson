Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2008 02:47:34 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:8495 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20042817AbYHFBrX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Aug 2008 02:47:23 +0100
Received: by mo.po.2iij.net (mo31) id m761l9DH046926; Wed, 6 Aug 2008 10:47:09 +0900 (JST)
Received: from rally.tokyo.tripeaks.co.jp (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox303) id m761l4Is022564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 6 Aug 2008 10:47:04 +0900
Message-Id: <200808060147.m761l4Is022564@po-mbox303.hop.2iij.net>
Date:	Wed, 6 Aug 2008 10:49:01 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ricardo Mendoza <ricmm@gentoo.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] vr41xx: fix problem with vr41xx_cpu_wait
In-Reply-To: <20080805104314.GB4628@woodpecker.gentoo.org>
References: <20080805104314.GB4628@woodpecker.gentoo.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ricardo,

On Tue, 5 Aug 2008 10:43:14 +0000
Ricardo Mendoza <ricmm@gentoo.org> wrote:

> Hello,
> 
> Yoichi, please correct me if I am wrong but I think that the "standby"
> instruction does not set IE bit on its own, so calling it with
> interrupts disabled will loop the cpu away forever on standby state
> being unable to come back due to no interrupts getting through.

In VR4100 series User's Manual, it's being written
"IE bit of the Status register in the CP0 is also set to 1".

Do you have any problem on your board?

Yoichi
