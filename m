Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2007 20:06:02 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:3507 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022479AbXFMTF7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 13 Jun 2007 20:05:59 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5DIvgie027774;
	Wed, 13 Jun 2007 19:58:07 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5DIvdnq027773;
	Wed, 13 Jun 2007 19:57:39 +0100
Date:	Wed, 13 Jun 2007 19:57:39 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Fuxin Zhang <fxzhang@ict.ac.cn>
Cc:	tiansm@lemote.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 09/15] add serial port definition for lemote fulong
Message-ID: <20070613185739.GB27392@linux-mips.org>
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
X-archive-position: 15385
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

So the serial port initialization rewrite is in -queue, now it needs some
testing - on all platforms.

  Ralf
