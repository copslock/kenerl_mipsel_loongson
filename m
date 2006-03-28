Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Mar 2006 23:27:15 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:8644 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133627AbWC1W1H (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Mar 2006 23:27:07 +0100
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1FOMoh-0003Hp-6o; Tue, 28 Mar 2006 17:37:35 -0500
Date:	Tue, 28 Mar 2006 17:37:35 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Chris Boot <bootc@bootc.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: Emulating MIPS -- please help!
Message-ID: <20060328223735.GA12609@nevyn.them.org>
References: <44299EE6.7010309@bootc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44299EE6.7010309@bootc.net>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 28, 2006 at 09:39:02PM +0100, Chris Boot wrote:
> I've got gxemul emulating code and running a kernel, which I can test by 
> stopping emulation and stepping the code. Qemu seems to boot my 
> qemu-specific kernel but I get no output and qemu appears to hang (won't 
> take keyboard input). I can't seem to get either emulator to load my 
> initrd, but that doesn't really matter at this stage since I can't see 
> anything anyway (I have no idea how to using gxemul, and qemu refuses to 
> load the image).

For qemu, are you looking at its VGA window, or its serial console
window?  Should use the latter.

-- 
Daniel Jacobowitz
CodeSourcery
