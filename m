Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2002 14:19:03 +0200 (CEST)
Received: from p508B7444.dip.t-dialin.net ([80.139.116.68]:65155 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123396AbSJGMTC>; Mon, 7 Oct 2002 14:19:02 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g97CIi509981;
	Mon, 7 Oct 2002 14:18:44 +0200
Date: Mon, 7 Oct 2002 14:18:44 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Colin.Helliwell@Zarlink.Com
Cc: linux-mips@linux-mips.org
Subject: Re: MIPS32/MIPS4K kernel compilation settings
Message-ID: <20021007141844.A9410@linux-mips.org>
References: <OFFFD113F8.B40CC667-ON80256C4B.0028865D@zarlink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OFFFD113F8.B40CC667-ON80256C4B.0028865D@zarlink.com>; from Colin.Helliwell@Zarlink.Com on Mon, Oct 07, 2002 at 08:48:26AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 07, 2002 at 08:48:26AM +0100, Colin.Helliwell@Zarlink.Com wrote:

> Was just wondering why the (2.4.19) kernel compilation for MIPS4K systems
> appears to be using the "-mips2" compiler setting - shouldn't it be using
> -mips4 or -mips32 to get the full instruction set?

Because we want MIPS II only ;-)

There are serious problems with the use of 64-bit stuff in the 32-bit
kernel, so we can't use mips3, mips4 or mips64.  -mips32 works but is not
supported by all toolchains.  Anyway, mips32 doesn't deliver much that isn't
already part of MIPS II.

  Ralf
