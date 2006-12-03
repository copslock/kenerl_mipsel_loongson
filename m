Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Dec 2006 17:05:24 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:49287 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S20037526AbWLCRFU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 3 Dec 2006 17:05:20 +0000
Received: from drow by nevyn.them.org with local (Exim 4.63)
	(envelope-from <drow@nevyn.them.org>)
	id 1GqumB-0002w5-Rf; Sun, 03 Dec 2006 12:05:15 -0500
Date:	Sun, 3 Dec 2006 12:05:15 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	"Fu, He Wei PSE NKG" <hewei.fu@siemens.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: The difference between mips*-gnu and mips*-linux when configure tool-chain
Message-ID: <20061203170514.GA11258@nevyn.them.org>
References: <96E7D5519FC3D741BEE27AB88C7387970162312C@PEKW934A.cn001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96E7D5519FC3D741BEE27AB88C7387970162312C@PEKW934A.cn001.siemens.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Sun, Dec 03, 2006 at 05:15:07PM +0800, Fu, He Wei PSE NKG wrote:
> Hello everyone.At the time of building tool-chain for mips machine,we
> can choose mips*-gnu or mips*-linux, I want to know what's the
> difference between them? The original idea is that mips*-gnu for
> developing firmware which has not OS-surport, and mips*-linux for
> developing software on Linux, but it is not suitable for firmware such
> as bootloaders.But now I think I'm not right,it seems that configure
> with mips*-linux suit for both linux and bootloader, and configure with
> mips*-gnu means build for OS such as IRIX surport, I'm not very
> clearly,can anybody help me figour out the difference between them?

mips-gnu is the GNU system (the Hurd kernel).  mips-linux is used for
the kernel and userspace of a Linux system.  mips-elf is used for bare
metal targets without an OS.

You should be able to build a Linux bootloader using a mips-linux
compiler.

-- 
Daniel Jacobowitz
CodeSourcery
