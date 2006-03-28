Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2006 00:48:28 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:42723 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133724AbWC1XsT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Mar 2006 00:48:19 +0100
Received: from lagash (88-106-238-34.dynamic.dsl.as9105.com [88.106.238.34])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 34F984403D; Wed, 29 Mar 2006 01:58:49 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.60)
	(envelope-from <ths@networkno.de>)
	id 1FOO57-0007bY-Rx; Wed, 29 Mar 2006 00:58:37 +0100
Date:	Wed, 29 Mar 2006 00:58:27 +0100
To:	Chris Boot <bootc@bootc.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: Emulating MIPS -- please help!
Message-ID: <20060328235827.GC31939@networkno.de>
References: <44299EE6.7010309@bootc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44299EE6.7010309@bootc.net>
User-Agent: Mutt/1.5.11+cvs20060126
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

On Tue, Mar 28, 2006 at 09:39:02PM +0100, Chris Boot wrote:
> Hi all,
> 
> I'm desperately trying to get a MIPS emulator running Linux, and while 
> I've managed to get gxemul and (I think) qemu running, I can't for the 
> life of me get them to (1) output anything or (2) use an initrd.
> 
> Can anyone post some instructions and, perhaps, a .config for 2.6.16 so 
> I can get some output like kernel boot messages and a login screen?
> 
> I've got gxemul emulating code and running a kernel, which I can test by 
> stopping emulation and stepping the code. Qemu seems to boot my 
> qemu-specific kernel but I get no output and qemu appears to hang (won't 
> take keyboard input).

VGA support for qemu isn't there yet, use -nographics to get the serial
console output.

> I can't seem to get either emulator to load my 
> initrd, but that doesn't really matter at this stage since I can't see 
> anything anyway (I have no idea how to using gxemul, and qemu refuses to 
> load the image).

Current qemu confuses virtual and physical adresses when loading initrds,
this and a bunch of other bugs are fixed in a set of patches I have.
Note that these are work in progress, and may cause different bugs.
Notably, the gcc4 support patch won't work on x86, and probably only on
powerpc. It has, however, emulated IDE support, I use a self-compiled
qemu kernel and a Debian/mips image to boot from, no ramdisk. The
patchset is available at

http://people.debian.org/~ths/qemu-patches-bogus/

Use at your own risk.


Thiemo
