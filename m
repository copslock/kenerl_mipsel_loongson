Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2003 12:12:13 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:34722 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224861AbTDQLMM>; Thu, 17 Apr 2003 12:12:12 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA16657;
	Thu, 17 Apr 2003 13:12:44 +0200 (MET DST)
Date: Thu, 17 Apr 2003 13:12:43 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc: kevink@mips.com, linux-mips@linux-mips.org, source@mvista.com
Subject: Re: wbflush() abuse for TOSHIBA_RBTX4927
In-Reply-To: <20030417.112704.74755522.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.GSO.3.96.1030417130259.16154B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 17 Apr 2003, Atsushi Nemoto wrote:

> >> AFAIK TX49's SYNC instruction correctly flushes the write buffer.
> 
> macro>  That would be an overkill; we only need to enforce strong
> macro> ordering here.
> 
> Hmm... But SYNC is a only TX49 instruction that enforce completions of
> preceding read operations.  (TX49 have "non-blocking load" feature
> which allows non-cached read/write to overtake preceding cached read)

 Yes it is the correct instruction and it works, but if it really flushes
the write buffer, then it does too much and hits performance -- all that
it needs to do is to act as an ordering barrier and assure the write
buffer gets drained before any *subsequent* load or store, which might not
necessarily happen soon. 

> I can imagine three configurations:
> 
> 1. Enable CONFIG_CPU_HAS_SYNC and disable CONFIG_CPU_HAS_WB.  In this
>    case, wmb/rmb/mb/iob/wbflush macro all issues a SYNC instruction.
[...]
> Although I'm not sure whether TX49 core can be integrated with such an
> external write buffer, all TX49XX (not TX39) I have ever seen does not
> have it.

 Then case #1 should be just fine, but the code gets it differently.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
