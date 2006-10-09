Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 00:24:55 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:64988 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039764AbWJIXYy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Oct 2006 00:24:54 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k99NP101003191;
	Tue, 10 Oct 2006 00:25:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k99NOuB9003169;
	Tue, 10 Oct 2006 00:24:56 +0100
Date:	Tue, 10 Oct 2006 00:24:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Igal Chernobelsky <igalch@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Math-emu issue
Message-ID: <20061009232455.GA26855@linux-mips.org>
References: <103e245f0610090921g5348dbd3hd806129e75668763@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <103e245f0610090921g5348dbd3hd806129e75668763@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 09, 2006 at 06:21:18PM +0200, Igal Chernobelsky wrote:

> I started to use LinuxThread in Linux 2.4 (version
> 2.4.17_mvl21-malta-mips_fp_le) and sometimes encounter a problem of
> arithmetic exception while performing dividing of two variables of double
> type. Our MIPS core does not include FPU coprosessor so math-emu is used. Is
> there any known problems/patches for kernel math emulation when LinuxThreads
> is used?

This is an extremly old kernel; from my own experience I recall we hit
heap and piles of bugs in that particular particular MV release so I
can only recommend you to upgrade.

  Ralf
