Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2002 14:10:28 +0100 (CET)
Received: from p508B7E19.dip.t-dialin.net ([80.139.126.25]:53149 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225265AbSLENK2>; Thu, 5 Dec 2002 14:10:28 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gB5DAIB06497;
	Thu, 5 Dec 2002 14:10:18 +0100
Date: Thu, 5 Dec 2002 14:10:18 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Compiler problems with zero-length array in the middle of a struct
Message-ID: <20021205141018.A6106@linux-mips.org>
References: <3DEF2EBE.F273B44A@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DEF2EBE.F273B44A@mips.com>; from carstenl@mips.com on Thu, Dec 05, 2002 at 11:47:26AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 05, 2002 at 11:47:26AM +0100, Carsten Langgaard wrote:

> Some compiler reject a zero-length array in the middle of a structure,
> and report it as an error.
> So could we please redo the change, that has recently been done to
> include/linux/raid/md_p.h (see patch below).

Hmm...  What compiler version is that?  The gcc documentation explicitly
permits empty arrays.

  Ralf
