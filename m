Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Dec 2002 20:37:38 +0000 (GMT)
Received: from p508B4FAF.dip.t-dialin.net ([IPv6:::ffff:80.139.79.175]:46484
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225615AbSLWUhi>; Mon, 23 Dec 2002 20:37:38 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBNKbUa01968;
	Mon, 23 Dec 2002 21:37:30 +0100
Date: Mon, 23 Dec 2002 21:37:30 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Robert Rusek <robru@teknuts.com>
Cc: linux-mips@linux-mips.org
Subject: Re: MIPS_RedHat7.3_Release-01.00 On SGI Indy, r5k IP22?
Message-ID: <20021223213730.B753@linux-mips.org>
References: <000701c2aab9$f3552370$0a01a8c0@sohotower>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <000701c2aab9$f3552370$0a01a8c0@sohotower>; from robru@teknuts.com on Mon, Dec 23, 2002 at 11:31:54AM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 23, 2002 at 11:31:54AM -0800, Robert Rusek wrote:

> Does anyone know if he MIPS_RedHat7.3_Release-01.00 will run on the SGI
> Indy, r5k IP22?  It is the release from mips.com that is made for the
> malta and atlas boards.  I am already running their 7.0 release but am
> not sure if the 7.3 v1.0 will run big edian?

It support both byteorders.  Rpm refuses to install packages of the wrong
endianess btw.

  Ralf
