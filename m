Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2002 16:03:40 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:54983 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123897AbSJBODk>;
	Wed, 2 Oct 2002 16:03:40 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g92E2vrZ006871;
	Wed, 2 Oct 2002 07:02:57 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA23381;
	Wed, 2 Oct 2002 07:03:26 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g92E2wb06206;
	Wed, 2 Oct 2002 16:02:58 +0200 (MEST)
Message-ID: <3D9AFC8F.261F0C37@mips.com>
Date: Wed, 02 Oct 2002 16:02:55 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: 64-bit kernel patch.
References: <3D9AF333.BC304A34@mips.com> <Pine.GSO.3.96.1021002153025.8947A-100000@delta.ds2.pg.gda.pl> <20021002154638.B16482@linux-mips.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> On Wed, Oct 02, 2002 at 03:40:27PM +0200, Maciej W. Rozycki wrote:
>
> >  As a side note -- arch/mips64/kernel/linux32.c is a huge collection of
> > often unrelated functions.  It might be beneficial to split the file
> > functionally, e.g. into fs32.c, net32.c, etc. or even with a finer grain,
> > preferably in a subdirectory, e.g. arch/mips64/linux32/.  What do you
> > think?
>
> Much of the code is so generic it almost deserves to live in a directory
> even higher in the hierarchy.  If you look at the 32-bit compat code for
> the various 64-bit architectures of Linux (in particular sparc64 and ia64),
> it's a single huge cut'n'paste session.  Not much of that code is actually
> architecture dependant.

That would be even better, but unfortunately a lot of the structures used in
the compat code is not exactly the same across architectures :-(
But it should be possible to merges a lot this stuff into a generic
(architecture independent) set of functions.


>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
