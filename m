Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jul 2004 01:25:02 +0100 (BST)
Received: from p508B68D1.dip.t-dialin.net ([IPv6:::ffff:80.139.104.209]:23155
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225761AbUGOAY6>; Thu, 15 Jul 2004 01:24:58 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i6F0Ou7B025329;
	Thu, 15 Jul 2004 02:24:56 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i6F0OsU9025328;
	Thu, 15 Jul 2004 02:24:54 +0200
Date: Thu, 15 Jul 2004 02:24:54 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Alexander Voropay <a.voropay@vmb-service.ru>
Cc: "'Kevin D. Kissell'" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: MS VC++ compiler / MIPS
Message-ID: <20040715002454.GA25279@linux-mips.org>
References: <003001c469b4$3b5ae960$10eca8c0@grendel> <07f501c469c8$85f86240$0200000a@ALEC>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07f501c469c8$85f86240$0200000a@ALEC>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 14, 2004 at 09:32:23PM +0400, Alexander Voropay wrote:

>  MSVC/MIPS supports 2 calling conventions (/Gd __cdecl calling
> convention;
> /Gr __fastcall calling convention) but I can't grok a difference.

Probably more argument registers etc.  I'd expect something along the
NABI callign conventions.

> > and certainly the assembler directives will be different from those
> assumed by the Linux sources.
> 
>  Yes.
> 
>  It sems, it is impossible to build a full Linux toolcain at the MSVC
> base. The MS linker
> (LINK.EXE) is weak (comparing to `ld` monster) and can produce only COFF
> .EXE (a.out)
> MIPS executables.

PECOFF, Microsoft's ECOFF variant which basically is ECOFF plus an MSDOS
executable header.  Yes, we all run MSDOS on our MIPS boxes so that's
and important feature ;-)

  Ralf
