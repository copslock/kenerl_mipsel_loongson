Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2002 14:35:13 +0100 (CET)
Received: from mx2.mips.com ([206.31.31.227]:22780 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8225265AbSLENfM>;
	Thu, 5 Dec 2002 14:35:12 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB5DZ2Nf029389;
	Thu, 5 Dec 2002 05:35:02 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA16134;
	Thu, 5 Dec 2002 05:35:03 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB5DZ3b06845;
	Thu, 5 Dec 2002 14:35:03 +0100 (MET)
Message-ID: <3DEF5606.E34BD27A@mips.com>
Date: Thu, 05 Dec 2002 14:35:03 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Subject: Re: Compiler problems with zero-length array in the middle of a struct
References: <3DEF2EBE.F273B44A@mips.com> <20021205141018.A6106@linux-mips.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

It should be a problem in gcc-3.0, also the SDE compiler has a problem with
that, but it's going to be fixed.

/Carsten


Ralf Baechle wrote:

> On Thu, Dec 05, 2002 at 11:47:26AM +0100, Carsten Langgaard wrote:
>
> > Some compiler reject a zero-length array in the middle of a structure,
> > and report it as an error.
> > So could we please redo the change, that has recently been done to
> > include/linux/raid/md_p.h (see patch below).
>
> Hmm...  What compiler version is that?  The gcc documentation explicitly
> permits empty arrays.
>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
