Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Dec 2004 03:33:06 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:16393 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225436AbULCDdB>; Fri, 3 Dec 2004 03:33:01 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id A864EF6DA8; Fri,  3 Dec 2004 04:27:00 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18984-03; Fri,  3 Dec 2004 04:27:00 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 709C0F6108; Fri,  3 Dec 2004 03:46:45 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iB32kOEm017301;
	Fri, 3 Dec 2004 03:46:39 +0100
Date: Fri, 3 Dec 2004 02:46:22 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "Brian R. Gaeke" <brg@dgate.org>
Cc: linux-mips@linux-mips.org
Subject: Re: drivers/tc patch for DS5000/200
In-Reply-To: <20041203002203.GB26830@sartre.insightbb.com>
Message-ID: <Pine.LNX.4.58L.0412030150400.23692@blysk.ds.pg.gda.pl>
References: <20041203002203.GB26830@sartre.insightbb.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/614/Wed Dec  1 16:44:43 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 2 Dec 2004, Brian R. Gaeke wrote:

> Now, it is my understanding that, having a pre-REX PROM, the DECstation
> 5000/200 would not be able to successfully execute the REX calls
> (rex_gettcinfo(), rex_slot_address()) in drivers/tc/tc.c.  Therefore,
> I have found it necessary to use a patched kernel in my efforts to boot
> Linux on VMIPS (http://www.dgate.org/vmips), which has lately gained some
> (limited) DECstation 5000/200 emulation capabilities.

 They've got it wrong.  While there were a few DECstation 5000/200 systems
around 1990 that were shipped with pre-REX firmware, they were soon
updated to REX fimware under service contracts.  I'm inclined to believe
there is no /200 system with pre-REX firmware in existence anymore.  In 
particular there are no entries for these firmware versions on the NetBSD 
PROM list -- the oldest one reported is 5.3c which is already 
REX-compliant.

> If you find this patch useful, you're quite welcome to it.  I'm also
> interested in hearing from anyone who has access to a 5000/200 who can
> tell me whether I'm right or wrong, as I only have old manuals and
> header files to work from.

 Real /200 systems work more or less correctly with Linux 2.4.  A port of
2.6 hasn't really started yet -- some drivers are broken.  The /200 is one
of the best documented DECstations.

  Maciej
