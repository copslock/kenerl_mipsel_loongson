Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Sep 2002 14:36:27 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:33160 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123899AbSIXMg0>;
	Tue, 24 Sep 2002 14:36:26 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g8OCZgrZ002710;
	Tue, 24 Sep 2002 05:35:42 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id FAA14048;
	Tue, 24 Sep 2002 05:36:00 -0700 (PDT)
Message-ID: <00e301c263c7$3cc80b60$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: <linux-mips@linux-mips.org>
References: <Pine.GSO.3.96.1020924133932.29072A-100000@delta.ds2.pg.gda.pl>
Subject: Re: FCSR Management
Date: Tue, 24 Sep 2002 14:37:57 +0200
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
X-archive-position: 266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> On Tue, 24 Sep 2002, Kevin D. Kissell wrote:
> 
> > dump core, so the user never executes again.  But *if*
> > the user has registered a handler for SIGFPE, and one
> > of the IEEE exceptions occurs, I don't see where the
> > associated Cause bit is being cleared, and I would think
> > that the consequence would be that the process would
> > get into an endless loop of trapping, posting the signal,
> > restoring the FCSR from the context with the bits set,
> > and trapping again, whether or not the PC is modified
> > to avoid re-executing the faulting instruction.
> 
>  Obviously user code is responsible to clear the bit it acted upon in the
> saved context. 

It may be obvious that someone *intended* that user code 
clear the bit.  But the FCSR value containing the trapping
condition seems to be saved as part of both the thread 
and the signal contexts, thus (a) it could be restored as 
part of the sigcontext load of the signal handler, causing 
a re-entrant trap, possibly ad infinitum, and (b) will be
restored in the thread state after the execution of the
signal in any case, since we don't allow signals to have
side-effects on the FP register state, including the FCSR.
So even if the signal handler executed far enough to clear
the relevant Cause bit, it looks to me as if it would simply
be re-set the next time the thread loaded the FPU context.

I haven't seen anyone complaining about threads hanging
when SIGFPE's are being caught, so things may be working
somehow - but we may be blundering through some number
of spurious traps for no good reason before we get there.

I'll be delighted if someone on the list could point out
how the probelem is being bypassed..

            Kevin K.
