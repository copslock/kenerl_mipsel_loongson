Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Feb 2004 14:14:20 +0000 (GMT)
Received: from baldur.fh-brandenburg.de ([IPv6:::ffff:195.37.0.5]:20933 "HELO
	baldur.fh-brandenburg.de") by linux-mips.org with SMTP
	id <S8225467AbUBFOOU>; Fri, 6 Feb 2004 14:14:20 +0000
Received: (1386 bytes) by baldur.fh-brandenburg.de
	via sendmail with P:stdio/R:match-inet-hosts/T:smtp
	(sender: <dahms@zeus.fh-brandenburg.de>) 
	id <m1Ap6i1-000psMC@baldur.fh-brandenburg.de>
	for <linux-mips@linux-mips.org>; Fri, 6 Feb 2004 15:11:53 +0100 (MET)
	(Smail-3.2.0.97 1997-Aug-19 #3 built DST-Sep-15)
Received: from zeus.fh-brandenburg.de(195.37.1.35)
 via SMTP by baldur.fh-brandenburg.de, id smtpdAAAa005XJ; Fri Feb  6 14:46:56 2004
Received: (from dahms@localhost)
	by zeus.fh-brandenburg.de (8.11.7p1+Sun/8.11.7) id i16Dktl08880;
	Fri, 6 Feb 2004 14:46:55 +0100 (MET)
Date: Fri, 6 Feb 2004 14:46:55 +0100
From: Markus Dahms <dahms@fh-brandenburg.de>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: Indy R4000PC problems
Message-ID: <20040206134655.GA17745@fh-brandenburg.de>
References: <20040202160729.GA5966@fh-brandenburg.de> <20040205175146.GA18162@linux-mips.org> <20040206102115.GA7490@fh-brandenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206102115.GA7490@fh-brandenburg.de>
User-Agent: Mutt/1.4.1i
Return-Path: <dahms@zeus.fh-brandenburg.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dahms@fh-brandenburg.de
Precedence: bulk
X-list: linux-mips

> [R4000PC]
>> Do you know which version of the processor this is exactly?  IRIX's hinv
>> command or the "CPU revision is: ..." line of bootup messages contain
>> that information.
> R4000 V3.0 I believe. I'll check it, when I'm at home again.

checked it:

[dmesg]
| CPU revision is: 00000430
| FPU revision is: 00000500

[/proc/cpuinfo]
| cpu model               : R4000PC V3.0  FPU V0.0

Markus

-- 
Any given program will expand to fill available memory.
