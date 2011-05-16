Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 14:55:10 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:3008 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491024Ab1EPMzE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 May 2011 14:55:04 +0200
X-TM-IMSS-Message-ID: <5ee9fa9b0004ffa1@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 5ee9fa9b0004ffa1 ; Mon, 16 May 2011 05:54:27 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 16 May 2011 05:56:03 -0700
Date:   Mon, 16 May 2011 18:27:20 +0530
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] MIPS: Replace _PAGE_READ with _PAGE_NO_READ
Message-ID: <20110516125719.GA2318@jayachandranc.netlogicmicro.com>
References: <20110513150707.GA26389@linux-mips.org>
 <BANLkTikcyEzjOWt9pWToE=89dySSEYbw_g@mail.gmail.com>
 <20110513155605.GA30674@linux-mips.org>
 <BANLkTinnALQV6dXkJ0AjaQ1=bTawYMMkuQ@mail.gmail.com>
 <20110513173633.GA14607@jayachandranc.netlogicmicro.com>
 <BANLkTim+z7TSCvNA2duA6LsUzNsiu9OQaQ@mail.gmail.com>
 <20110513184532.GC14607@jayachandranc.netlogicmicro.com>
 <BANLkTi=CJPuhO7OjCv5UF_ABQMb-bFe-2A@mail.gmail.com>
 <20110514051303.GE14607@jayachandranc.netlogicmicro.com>
 <BANLkTimuz8bgrpwJTSh4guDXt+h2hUvSGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BANLkTimuz8bgrpwJTSh4guDXt+h2hUvSGQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 16 May 2011 12:56:03.0409 (UTC) FILETIME=[9CED5C10:01CC13C8]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

[dropping linux-kernel of the cc:]

On Fri, May 13, 2011 at 11:02:27PM -0700, Kevin Cernekee wrote:
> On Fri, May 13, 2011 at 10:13 PM, Jayachandran C.
> <jayachandranc@netlogicmicro.com> wrote:
> > Can you send me the patchset which works on top of queue with any
> > debugging you want enabled?  I can try that and send you the results.
> >
> > It is also possible that something is broken with the XLR platform code,
> > it is currently almost straight r4k...
> 
> Well, David suggested adding "#define DEBUG 1" at the very top of
> tlbex.c, then booting with "debug" and posting the TLB refill handler
> to make sure the RI/XI code isn't getting enabled.  That seems like a
> reasonable start.  Even if there's no smoking gun, we'd still be able
> to compare our TLB handlers side-by-side.
> 
> Personally I don't have any other leads or patches to try.  These
> changes work fine for me in every configuration I am able to test:
> 
> 32-bit MIPS32 system, 32-bit kernel (non-RIXI)
> 32-bit MIPS32 system, 32-bit kernel (XI)
> 64-bit R5000 system, 32-bit kernel (non-RIXI, with 64-bit physical addresses)
> 64-bit R5000 system, 64-bit kernel (non-RIXI)
> 
> So it's really best for somebody to debug the problem hands-on, on the
> system that showed the issue.

I will try this patch again on top of 'queue' with debugging and send you
an update.  Hope to do it today or tomorrow.

JC.
