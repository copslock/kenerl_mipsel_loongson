Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Dec 2006 20:40:19 +0000 (GMT)
Received: from fmmailgate03.web.de ([217.72.192.234]:23474 "EHLO
	fmmailgate03.web.de") by ftp.linux-mips.org with ESMTP
	id S20038981AbWLNUkN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Dec 2006 20:40:13 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 853F2462813B;
	Thu, 14 Dec 2006 21:40:07 +0100 (CET)
Received: from [84.180.143.59] (helo=pluto.sol)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.107 #114)
	id 1GuxN7-0005AS-00; Thu, 14 Dec 2006 21:40:06 +0100
Received: from jens by pluto.sol with local (Exim 4.63)
	(envelope-from <tux-master@web.de>)
	id 1GuxIl-0004pA-NB; Thu, 14 Dec 2006 21:35:35 +0100
Date:	Thu, 14 Dec 2006 21:35:35 +0100
From:	Jens Seidel <jensseidel@users.sf.net>
To:	linux-mips@linux-mips.org
Subject: SGI Octane kernel patches fail
Message-ID: <20061214203535.GA18511@pluto>
Reply-To: linux-mips@linux-mips.org, Jens Seidel <jensseidel@users.sf.net>
Mail-Followup-To: linux-mips@linux-mips.org,
	Jens Seidel <jensseidel@users.sf.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Sender: tux-master@web.de
Return-Path: <tux-master@web.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jensseidel@users.sf.net
Precedence: bulk
X-list: linux-mips

Hi,

I have a SGI Octane IP30 and was able to boot Linux on it with the
ip30-r10k+-20050128.img Gentoo kernel. Nevertheless I noticed that
this kernel is very unstable.

Once I was lucky and able to bootstrap Debian before the kernel paniced
again (usually a "unaligned instruction access in
arch/mips/kernel/unaligned.c::do_ade, line 544[#3]").

I tried to compile a newer 2.6.19-rc1 kernel and applied the two IOC3
and IP30 patches from
ftp://ftp.linux-mips.org/pub/linux/mips/people/skylark/. First of all
the patch fails slightly and needs manual adjustments. Compiling results
in an error, do_IRQ() is called with only one parameter instead of two.

So I wonder what kernels are compatible with
linux-mips-2.6.19-rc1-ip30-r28.patch.bz2. Do I need other patches as
well? Also the kernel config file skylark-approved-config-tm in skylark/
is out of date. It seems to match a 2.6.12 or similar version.

PS: Please CC: me.

Jens
