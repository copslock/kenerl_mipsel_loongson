Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jun 2004 14:49:21 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:33190 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225551AbUF2NtR>; Tue, 29 Jun 2004 14:49:17 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id F2834474EF; Tue, 29 Jun 2004 15:49:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id DFA2947485; Tue, 29 Jun 2004 15:49:11 +0200 (CEST)
Date: Tue, 29 Jun 2004 15:49:11 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [patch] Incorrect mapping of serial ports to lines
In-Reply-To: <Pine.GSO.4.58.0406291408020.29058@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.55.0406291546480.31801@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0406281513120.23162@jurand.ds.pg.gda.pl>
 <20040628235908.GC5736@linux-mips.org> <Pine.LNX.4.55.0406291345590.31801@jurand.ds.pg.gda.pl>
 <Pine.GSO.4.58.0406291408020.29058@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 29 Jun 2004, Geert Uytterhoeven wrote:

> The NEC DDB Vrc-5074 (and probably the other DDB variants as well) has one
> serial port in the Nile 4 host bridge, and 2 serial ports in the Super I/O.
> 
> To me it sounds the most logical if the one in the Nile 4 is ttyS0.

 Then we need to find a way to make the order configurable somehow.
