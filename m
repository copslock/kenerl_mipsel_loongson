Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2002 12:25:20 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:29907 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122978AbSJPKZU>; Wed, 16 Oct 2002 12:25:20 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA15358;
	Wed, 16 Oct 2002 12:25:30 +0200 (MET DST)
Date: Wed, 16 Oct 2002 12:25:30 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alexandre Oliva <aoliva@redhat.com>
cc: Paul Koning <pkoning@equallogic.com>, wilson@redhat.com,
	hjl@lucon.org, rsandifo@redhat.com, linux-mips@linux-mips.org,
	gcc@gcc.gnu.org, binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
In-Reply-To: <orof9vqso2.fsf@free.redhat.lsd.ic.unicamp.br>
Message-ID: <Pine.GSO.3.96.1021016121633.14774B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 15 Oct 2002, Alexandre Oliva wrote:

> >  Hmm, how do you select right relocations that depend on the ABI selected? 
> 
> Err...  With logic similar to that the assembler uses? :-)

 Except that at the assembly level you cannot guess which switches were
passed to gas.  You may try to guess with cpp, but it isn't able to get at
whatever is passed with "-Wa".  Also you have to reflect all the
conditional paths from the "asm" sections of specs in the "cpp" ones,
which is fragile. 

 Pretty tough at the moment, I'd say.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
