Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 23:44:09 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:30604 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225239AbTGVWnu>; Tue, 22 Jul 2003 23:43:50 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id AAA11264;
	Wed, 23 Jul 2003 00:43:42 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 23 Jul 2003 00:43:42 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Wayne Gowcher <wgowcher@yahoo.com>
cc: linux-mips@linux-mips.org
Subject: Re: Support of cmpxchg
In-Reply-To: <20030722221252.37376.qmail@web11903.mail.yahoo.com>
Message-ID: <Pine.GSO.3.96.1030723003736.607N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 22 Jul 2003, Wayne Gowcher wrote:

> I am trying to get some DRM ( direct rendering module
> ? ) code to work with XFree86 on a mips system and
> have come across the function cmpxchg(). On x86
> systems 486 and higher this is an assembly
> instruction. Other architectures like sparc have some
> inline assembly to preform the same task. Yet other
> architectures like the parisc have generic c code to
> implement the function. MIPS it seems has nothing.
> 
> Has anyone ever implemented this for mips2 and higher
> architecture ?
> 
> If no, does anyone think it is possible to use ll / sc
> to implement this function similar to the spinlock
> case. Or should I just stick with the generic c
> versions ?

 Doing it with ll/sc should be straightforward.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
