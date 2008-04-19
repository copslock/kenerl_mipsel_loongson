Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Apr 2008 00:08:48 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:29655 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S28575656AbYDSXIq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 20 Apr 2008 00:08:46 +0100
Received: from lagash (88-106-226-17.dynamic.dsl.as9105.com [88.106.226.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 334CB48917;
	Sun, 20 Apr 2008 01:08:45 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1JnMAm-0008UI-Kk; Sun, 20 Apr 2008 00:08:44 +0100
Date:	Sun, 20 Apr 2008 00:08:44 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	David Daney <ddaney@avtrex.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Building current kernel for Qemu
Message-ID: <20080419230844.GA31431@networkno.de>
References: <480A70EA.50804@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480A70EA.50804@avtrex.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> I would like to build a current kernel for mipsel on qemu.  However it
> seems that the qemu target was recently removed.
> 
> I tried building a plain malta kernel vmlinux, but there is no output on
> the console when trying to boot it.  The Debian 2.6.18 qemu kernel seems
> to work well though.
> 
> Do you have to do anything special to the kernel to run on qemu?

Nothing special is needed for the kernel. You need to start with
e.g. "qemu-system-mipsel -M malta" to select Qemu's malta machine
emulation.

> How does one go about building a kernel for qemu from current kernel
> sources?

The special qemu kernel is now deprecated, as the malta kernel is a
full replacement which corresponds better to real existing hardware.

This is btw. also true for Qemu itself, the mips_r4k machine is still
there because
 a) uBoot supports it as the only mips Qemu target
 b) Some out-of-tree machine definitions use it as a baseline
    configuration.


Thiemo
