Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2003 14:51:32 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:52419 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225510AbTJUNv2>; Tue, 21 Oct 2003 14:51:28 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA25570;
	Tue, 21 Oct 2003 15:51:22 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 21 Oct 2003 15:51:21 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-mips@linux-mips.org
Subject: Re: LK201 keyboard
In-Reply-To: <20031021131033.GM20846@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1031021152207.23366D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 21 Oct 2003, Jan-Benedict Glaw wrote:

> I'm currently reworking the LK201 keyboard driver to attach it to the
> new Input API, as well as letting it use the serio interface (-> this
> way, you're not bound to dz.c/zs.c).

 Thanks for your effort and please cooperate -- I have some have
half-baked patches for the driver to let it pass native codes for the raw 
mode as appropriate.

> I've got a little problem with it, though. I've got docs (for the VAX)
> which describe the LK201 in detail. First of all, the "Set LEDs On"
> command is wrong there (advertised as 0x12, but 0x13 actually works;
> this is what the current driver uses, too). That may be a typo, though..

 This is definitely a typo -- 0x12 is a Set Mode command (mode: 1, key
group: 2; a repeat register number follows).  The definitions in lk201.h
have been verified to be correct.

> However, the "Set Mode" command (to set the repeat mode for a block of
> keys) doesn't work for me on a lk201. Using a lk401 instead, these
> commands work. Every time I send a set-mode command, I get a Input Error
> (from the keyboard) sent back...

 Strange -- these work for me.

> I'd like to ask you DECstation users to verify that the set-mode command
> actually works for you on a lk201... Or do you all use the newer lk401?

 I have an LK201 and the current code was tested almost exclusively with
it.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
