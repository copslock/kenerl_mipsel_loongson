Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2007 14:03:42 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:59560 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021900AbXFLNDk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Jun 2007 14:03:40 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5CD15vY003984;
	Tue, 12 Jun 2007 14:01:30 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5CD12sA003979;
	Tue, 12 Jun 2007 14:01:02 +0100
Date:	Tue, 12 Jun 2007 14:01:02 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Fuxin Zhang <fxzhang@ict.ac.cn>
Cc:	tiansm@lemote.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 09/15] add serial port definition for lemote fulong
Message-ID: <20070612130101.GA3929@linux-mips.org>
References: <11811127722019-git-send-email-tiansm@lemote.com> <11811127741719-git-send-email-tiansm@lemote.com> <20070612123440.GC2926@linux-mips.org> <466E9833.4000302@ict.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <466E9833.4000302@ict.ac.cn>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 12, 2007 at 08:57:23PM +0800, Fuxin Zhang wrote:

> I think CONFIG_HAVE_STD_PC_SERIAL_PORT is ok, especially for that we now 
> have CONFIG_SERIAL_8250_NR_UARTS.
> Nothing special for Fulong's serial ports(we used to have a special 
> serial port inside the northbridge FPGA), and the 686B is
> "Standard PC" chip:)
> We can take the simple way.

Good.  This simplifies the rewrite of the 8250 serial support to use
the platform_device driver.

  Ralf
