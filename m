Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 14:10:58 +0200 (CEST)
Received: from buserror-extern.convergence.de ([212.84.236.66]:49670 "EHLO
	hell") by linux-mips.org with ESMTP id <S1122961AbSIRMK5>;
	Wed, 18 Sep 2002 14:10:57 +0200
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17rdfL-00059j-00; Wed, 18 Sep 2002 14:10:47 +0200
Date: Wed, 18 Sep 2002 14:10:47 +0200
From: Johannes Stezenbach <js@convergence.de>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: Stuart Hughes <seh@zee2.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: cannot debug multi-threaded programs with gdb/gdbserver
Message-ID: <20020918121047.GA17744@convergence.de>
References: <3D876053.C2CD1D8C@zee2.com> <3D87653E.9030702@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D87653E.9030702@realitydiluted.com>
User-Agent: Mutt/1.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

Steven J. Hill wrote:
> Stuart Hughes wrote:
> >
> >Does anyone know whether there is some special setup needed on
> >gdb/gdbserver to use the multi-threaded gdbserver ??
...
> >binutils:	Version 2.11.90.0.25
> >
> Don't use H.J. Lu's binutils, use the released one. Use gcc-3.2 and
> binutils-2.13 as they have fixes for the MIPS debugging symbols with
> regards to DWARF.

Is this a general recommendation to avoid H.J. Lu's binutils, or do
you just favor the newer binutils version?
What about binutils 2.13.90.0.4?

I'm currently using gcc-2.95.4 with the Debian patches, and
binutils binutils-2.12.90.0.14, which seem to work well.
I planned to switch to gcc-3.2 but postponed it because I
read about the DWARF debugging problems. Are they solved
with gcc-3.2 / binutils-2.13 / gdb-5.3-CVS ?


Regards,
Johannes
