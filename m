Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2003 19:39:31 +0100 (BST)
Received: from p508B6F04.dip.t-dialin.net ([IPv6:::ffff:80.139.111.4]:64168
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225423AbTJTSjY>; Mon, 20 Oct 2003 19:39:24 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h9KIdMNK024698;
	Mon, 20 Oct 2003 20:39:22 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h9KIdM0w024697;
	Mon, 20 Oct 2003 20:39:22 +0200
Date: Mon, 20 Oct 2003 20:39:22 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: linux-mips@linux-mips.org
Subject: Re: kernel modules
Message-ID: <20031020183922.GD15997@linux-mips.org>
References: <Pine.GSO.4.44.0310201029090.12930-100000@ares.mmc.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0310201029090.12930-100000@ares.mmc.atmel.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 20, 2003 at 10:32:08AM -0400, David Kesselring wrote:

> Can someone please confirm that loading and unloading of kernel modules is
> functioning in the  2.4 release?
> 
> When I try to load a wlan module that I compiled (with mipsel-*) I get
> relocation errors. I used the same options as I did to compile the kernel
> (for MIPS Malta board). If you have any ideas, please let me know.

You're _not_ using the same options as the kernel's Makefile does for
building modules.

  Ralf
