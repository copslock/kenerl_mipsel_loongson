Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2004 20:48:09 +0000 (GMT)
Received: from p508B7363.dip.t-dialin.net ([IPv6:::ffff:80.139.115.99]:24646
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225342AbUBBUsI>; Mon, 2 Feb 2004 20:48:08 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i12Km2ex027025;
	Mon, 2 Feb 2004 21:48:02 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i12Km1vt027022;
	Mon, 2 Feb 2004 21:48:01 +0100
Date: Mon, 2 Feb 2004 21:48:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Stuart Longland <stuartl@longlandclan.hopto.org>
Cc: Karsten Merker <karsten@excalibur.cologne.de>,
	Linux MIPS Mailing list <linux-mips@linux-mips.org>
Subject: Re: Problems with LCD panel & SCSI support with Linux 2.4.24-pre2 on Cobalt Qube II
Message-ID: <20040202204801.GA26734@linux-mips.org>
References: <401D06A6.4050905@longlandclan.hopto.org> <20040201145448.GA1945@excalibur.cologne.de> <401D54C6.40207@longlandclan.hopto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401D54C6.40207@longlandclan.hopto.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 02, 2004 at 05:34:30AM +1000, Stuart Longland wrote:

> 	Thanks for that, this fixes the LCD problem, it's working fine now.  
> 	If
> it's more dynamic, it looks like using devfs might be a better option --
> although I'm trying to avoid enabling stuff that enlarges my kernel (I'm
> at 600kB now).

Devfs is not going to be the solution, that much is clear.  It's
deprecated in 2.6 and in general enjoys the positive reputation of ebola
in most of the kernel community.  For 2.4 /proc/misc allows you to get
away without devfs, something that'll also work with 2.6.  In a more
general context it looks like udev is going to be the official successor
of devfs.

> At the moment, I'll see about putting a hack in the scripts to recreate
> /dev/lcd at boot.

  Ralf
