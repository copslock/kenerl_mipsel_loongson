Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 05:09:54 +0100 (BST)
Received: from p508B77C3.dip.t-dialin.net ([IPv6:::ffff:80.139.119.195]:22203
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225213AbTE0EJv>; Tue, 27 May 2003 05:09:51 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h4R49lbY013927;
	Mon, 26 May 2003 21:09:47 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h4R49jcA013925;
	Tue, 27 May 2003 06:09:45 +0200
Date: Tue, 27 May 2003 06:09:45 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Embedded ramdisks
Message-ID: <20030527040945.GA13908@linux-mips.org>
References: <Pine.GSO.4.21.0305231551110.26586-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0305231551110.26586-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 23, 2003 at 03:52:45PM +0200, Geert Uytterhoeven wrote:

> Fix the dependency for embedded ramdisks by using the contents of
> CONFIG_EMBEDDED_RAMDISK_IMAGE (after stripping the leading and trailing double
> quotes) instead of using the hardcoded filename `ramdisk.gz'.

Thanks, applied.

  Ralf
