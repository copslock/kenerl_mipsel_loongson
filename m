Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jul 2004 10:48:39 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:29967 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224863AbUG3Jsf>; Fri, 30 Jul 2004 10:48:35 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 1051BE1CB5; Fri, 30 Jul 2004 11:48:31 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 17811-05; Fri, 30 Jul 2004 11:48:30 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id DB497E1C94; Fri, 30 Jul 2004 11:48:30 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.11.4) with ESMTP id i6U9mbge008500;
	Fri, 30 Jul 2004 11:48:37 +0200
Date: Fri, 30 Jul 2004 11:48:31 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Richard Sandiford <rsandifo@redhat.com>
Cc: greg.roelofs@philips.com, linux-mips@linux-mips.org
Subject: Re: apparent math-emu hang on movf instruction
In-Reply-To: <871xivuwjf.fsf@redhat.com>
Message-ID: <Pine.LNX.4.58L.0407301143260.23489@blysk.ds.pg.gda.pl>
References: <OFFE4A0198.56A3A2A2-ON88256EDF.006D0D9F@philips.com>
 <876587uwud.fsf@redhat.com> <871xivuwjf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 29 Jul 2004, Richard Sandiford wrote:

> Oops!  Serves me right for dabbling in new code.  Only the first
> hunk is correct.

 Thanks Richard for working on this.  I've verified your patch on my
system and as it is obviously correct, I've applied it with a trivial
formatting change to our CVS, both to the head and to the 2.4 branch; with
appropriate literal name changes for the latter.

  Maciej
