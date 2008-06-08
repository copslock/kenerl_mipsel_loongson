Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Jun 2008 09:39:07 +0100 (BST)
Received: from winston.telenet-ops.be ([195.130.137.75]:32642 "EHLO
	winston.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S29038107AbYFHIjE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Jun 2008 09:39:04 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by winston.telenet-ops.be (Postfix) with SMTP id 9834DA004D
	for <linux-mips@linux-mips.org>; Sun,  8 Jun 2008 10:39:03 +0200 (CEST)
Received: from anakin.of.borg (78-21-204-88.access.telenet.be [78.21.204.88])
	by winston.telenet-ops.be (Postfix) with ESMTP id 1319AA000C
	for <linux-mips@linux-mips.org>; Sun,  8 Jun 2008 10:39:02 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-4) with ESMTP id m588d0I0021784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-mips@linux-mips.org>; Sun, 8 Jun 2008 10:39:01 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id m588cvQ2021781
	for <linux-mips@linux-mips.org>; Sun, 8 Jun 2008 10:38:59 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Sun, 8 Jun 2008 10:38:54 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: linux-next: Tree for June 6 (fwd)
Message-ID: <Pine.LNX.4.64.0806081038410.9181@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

FYI...

---------- Forwarded message ----------
Date: Fri, 6 Jun 2008 21:11:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for June 6

Hi Dmitri,

On Fri, 06 Jun 2008 11:48:37 +0300 Dmitri Vorobiev <dmitri.vorobiev@movial.fi> wrote:
>
> Please see http://lkml.org/lkml/2008/6/4/152 where you'll find the
> description of how I built a MIPS cross-toolchain and a working MIPS config.

Thanks for that.  Sorry I didn't respond sooner.

We have managed to make a working tool chain and I will
add some MIPS builds soon.  Was the attached config just the
malta_defconfig in the kernel tree, or there something special about it.
I noticed that a straight defconfig build works for mips and mipsel.
Would you expect all{no,mod}config to work?  What would be a good 64 bit
test config?

It is easier for us if we just use the configs out of the kernel tree,
but others are possible (its just harder to keep them up to date).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
