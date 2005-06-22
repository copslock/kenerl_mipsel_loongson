Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jun 2005 13:35:09 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:27663 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225400AbVFVMew>; Wed, 22 Jun 2005 13:34:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B2174F596A; Wed, 22 Jun 2005 14:33:38 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30735-03; Wed, 22 Jun 2005 14:33:38 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 5E10DE1C9A; Wed, 22 Jun 2005 14:33:38 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5MCXfIf011655;
	Wed, 22 Jun 2005 14:33:41 +0200
Date:	Wed, 22 Jun 2005 13:33:47 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: .set mips2 breaks 64bit kernel (Re: CVS Update@linux-mips.org:
 linux)
In-Reply-To: <20050622.163101.103777455.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.LNX.4.61L.0506221330240.4849@blysk.ds.pg.gda.pl>
References: <20050614173512Z8225617-1340+8840@linux-mips.org>
 <20050622.163101.103777455.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/950/Wed Jun 22 02:48:34 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 22 Jun 2005, Atsushi Nemoto wrote:

> macro> Log message:
> macro> 	Enable a suitable ISA for the assembler around ll/sc so that code
> macro> 	builds even for processors that don't support the instructions.
> macro> 	Plus minor formatting fixes.
> 
> Please do not set mips2 unconditionaly.  It breaks 64bit kernel.

 Any specifics please?  It works for me -- I wouldn't have committed it 
otherwise.  In particular in the affected range there are no operations 
that would require a 64-bit ISA.

  Maciej
