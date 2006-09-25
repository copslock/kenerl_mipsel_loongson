Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Sep 2006 12:04:52 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:40412 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038506AbWIYLEv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Sep 2006 12:04:51 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8PB5YvW017734;
	Mon, 25 Sep 2006 12:05:34 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8PB5WvP017733;
	Mon, 25 Sep 2006 12:05:32 +0100
Date:	Mon, 25 Sep 2006 12:05:32 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	william_lei@ali.com.tw
Cc:	linux-mips@linux-mips.org
Subject: Re: How to emulate lw/sw instruction by lb/sb instruction
Message-ID: <20060925110532.GA14735@linux-mips.org>
References: <OF041A6F77.FC0AA7D2-ON482571F4.00036CCB-482571F4.0003EC56@LocalDomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF041A6F77.FC0AA7D2-ON482571F4.00036CCB-482571F4.0003EC56@LocalDomain>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 25, 2006 at 08:41:53AM +0800, william_lei@ali.com.tw wrote:

> Dear all
>       Could someone tell me how to modify GCC as titled?because we have met
> problem while porting some middleware,which will generate some lw/sw
> instruction to unaligned address,so I would modify GCC to not generate
> lw/sw instructions for this pieces code.

You can use gcc's __attribute__((packed)) to define a data structure
that does not have any alignment gaps in it.  Gcc will then use unaligned
loads and stores to access this structure.  This however is a kludge, for
best performance you should redefine the data structures your code is
working to avoid such missalignment.

Otoh if the miss-alignment case is rare only then you may actually be
better off by relying on the kernel's handling of this case.

  Ralf
