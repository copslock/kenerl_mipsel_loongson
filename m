Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2002 15:40:05 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:34002 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1123897AbSJBNkF>; Wed, 2 Oct 2002 15:40:05 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA11227;
	Wed, 2 Oct 2002 15:40:27 +0200 (MET DST)
Date: Wed, 2 Oct 2002 15:40:27 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit kernel patch.
In-Reply-To: <3D9AF333.BC304A34@mips.com>
Message-ID: <Pine.GSO.3.96.1021002153025.8947A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 2 Oct 2002, Carsten Langgaard wrote:

> I have a number of patches for the o32 syscall wrapper/conversion
> routines, which is needed when running a 64-bit kernel on an o32
> userland.
> Here is the first one. Ralf, could you please apply it, so I can send
> the next one.

 Do you have a fix for sys32_sendmsg/sys32_recvmsg as well?  I just
started working on it and I'd prefer not to do a duplicate work.

 As a side note -- arch/mips64/kernel/linux32.c is a huge collection of
often unrelated functions.  It might be beneficial to split the file
functionally, e.g. into fs32.c, net32.c, etc. or even with a finer grain,
preferably in a subdirectory, e.g. arch/mips64/linux32/.  What do you
think? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
