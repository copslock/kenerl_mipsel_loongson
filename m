Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jan 2003 20:43:22 +0000 (GMT)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:12193 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8226246AbTALS4H>;
	Sun, 12 Jan 2003 18:56:07 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h0CItu67013021;
	Sun, 12 Jan 2003 10:55:56 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id KAA24683;
	Sun, 12 Jan 2003 10:55:51 -0800 (PST)
Message-ID: <003b01c2ba6c$f64ef840$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@linux-mips.org>,
	"Krishnakumar. R" <krishnakumar@naturesoft.net>
Cc: <linux-mips@linux-mips.org>
References: <200301101600.26246.krishnakumar@naturesoft.net> <20030112180917.A18654@linux-mips.org>
Subject: Re: Cpu frequency scaling
Date: Sun, 12 Jan 2003 20:01:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1135
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> > Can frequency scaling (through software) 
> > be done on mips using linux ?
> > 
> > Is  such a feature feasible in mips ??
> > 
> > I could not find any documentation nor patches 
> > for  frequency
> > scaling on mips at 
> > http://www.brodo.de/cpufreq/
> > :-(
> 
> None of the currently supported MIPS CPUs support such a feature in
> hardware as such our support is already complete and by definition
> bug free ;-)

Actually, that's not *quite* true.  A number of MIPS CPUs and
cores that are otherwise supported by Linux (e.g. 4K, 5K) have
a "reduced power" mode which is modulated by the CP0 "RP"
bit. In general, this bit does nothing in the CPU itself, however.
It was intended that it be connected to system-level logic for
frequency scaling (1/n normal clock, or CPU=Bus).  So on
most systems it does nothing, and on the ones where it does
do something, it's entirely system dependent.  I don't have an
Alchemy AU1000 spec handy, but since they've integrated
a lot of other logic with their CPU, and since they designed
their component to go into low-power devices, it wouldn't
surprise me in the least if they do something well-defined
with the RP bit.

So, to get back to the original question, something highly
platform dependent *could* be done using MIPS/Linux, 
via /proc/cpu or some kind of system call, but I don't believe 
anyone has made such a hook generally available as yet.

            Kevin K.
