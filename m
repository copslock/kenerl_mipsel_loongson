Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2003 15:26:16 +0100 (BST)
Received: from p508B58B4.dip.t-dialin.net ([IPv6:::ffff:80.139.88.180]:36015
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225389AbTIKO0Q>; Thu, 11 Sep 2003 15:26:16 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h8BEQDLT016090;
	Thu, 11 Sep 2003 16:26:13 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h8BEQBWO016083;
	Thu, 11 Sep 2003 16:26:11 +0200
Date:	Thu, 11 Sep 2003 16:26:11 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	???? <guangxing@ict.ac.cn>
Cc:	linux-mips@linux-mips.org, angela <jhyang@ict.ac.cn>, xie@ict.ac.cn
Subject: Re: Some  Question about the kernel module on MIPS64
Message-ID: <20030911142611.GC15365@linux-mips.org>
References: <20030911021338Z8225363-1272+5279@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911021338Z8225363-1272+5279@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 11, 2003 at 10:13:58AM +0800, ???? wrote:

>    1) I want to know if the linux for mips64 support the customer's
>       kernel module .if yes, is there any modutils i can use?And how
>       can i get it.

There is currently no module support for mips64.

>    2) I have written a simplest simplest kernel module for linux for
>       mips64 (only the init()and cleanup() we can see,and we do nothing.)
>       and with the crossing compiling tool it is ok.One thing confused
>       me is that it can be "insmod" in the linux for mips32, but when we
>       try to "insmod" in the linux for mips64, we get the following error:
> [root@(none) root]# insmod try.o
> init_module: Invalid module header size.
> A new version of the modutils is likely needed.

True.

> try.o: init_module: Invalid argument
> Hint: insmod errors can be caused by incorrect module parameters,
> including invalid IO or IRQ parameters
> Of course we do the above works in the same hardware platform .
> Is there any thing I should pay attention to when I compile the Kernel
> Module or the linux for mips64? Eagering your help!!

The problem isn't the kernel but modutils which don't support kernel
modules for 64-bit kernels.

  Ralf
