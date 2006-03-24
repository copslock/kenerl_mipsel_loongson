Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 16:45:23 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:61156 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133909AbWCXQpO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Mar 2006 16:45:14 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k2OGtINn018557;
	Fri, 24 Mar 2006 16:55:18 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k2OGtIFW018556;
	Fri, 24 Mar 2006 16:55:18 GMT
Date:	Fri, 24 Mar 2006 16:55:18 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kishore K <hellokishore@gmail.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: 2.6.14 - problem with malta
Message-ID: <20060324165518.GA16567@linux-mips.org>
References: <f07e6e0603240636x5e496cd2g29316d73490aa300@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f07e6e0603240636x5e496cd2g29316d73490aa300@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 24, 2006 at 08:06:43PM +0530, Kishore K wrote:

> hi
> I am trying to bring up the malta board (MIPS 4kec), using the 2.6.14 kernel
> downloaded from linux-mips. The kernel is built with malta_defconfig located
> in arch/mips/configs. After loading this kernel, board halts after printing
> "Linux Started
> Config serial console: console=ttyS0, 38400n8r"
> 
> Kernel is built with the tool chain based on gcc 3.3.6, binutils 2.14.90.0.8
> .

Note I generally don't test with HJ.Lu's toolchain at all.  It may be
broken for MIPS, I don't know.  Also due to known bugs in older toolchains
the minimal requirement is binutils 2.16; the vanilla FSF version from
ftp.gnu.org will do.

(2.15 will core dump for some configurations but if it doesn't die, it seems
to do just fine)

> Could any one tell me what the problem is .

Let's see.  What CPU card are you using on your Malta?  And if it's an
FPGA card, what bitfile is loaded?  Yamon will print information on the
CPU after powerup or reset.

  Ralf
