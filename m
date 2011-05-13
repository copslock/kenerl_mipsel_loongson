Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 19:35:33 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:1355 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491849Ab1EMRf1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2011 19:35:27 +0200
X-TM-IMSS-Message-ID: <5077a3850004c06e@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 5077a3850004c06e ; Fri, 13 May 2011 10:34:52 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 13 May 2011 10:35:35 -0700
Date:   Fri, 13 May 2011 23:06:34 +0530
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] MIPS: Replace _PAGE_READ with _PAGE_NO_READ
Message-ID: <20110513173633.GA14607@jayachandranc.netlogicmicro.com>
References: <7aa38c32b7748a95e814e5bb0583f967@localhost>
 <20110513150707.GA26389@linux-mips.org>
 <BANLkTikcyEzjOWt9pWToE=89dySSEYbw_g@mail.gmail.com>
 <20110513155605.GA30674@linux-mips.org>
 <BANLkTinnALQV6dXkJ0AjaQ1=bTawYMMkuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BANLkTinnALQV6dXkJ0AjaQ1=bTawYMMkuQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 13 May 2011 17:35:35.0821 (UTC) FILETIME=[2AD313D0:01CC1194]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

On Fri, May 13, 2011 at 09:55:21AM -0700, Kevin Cernekee wrote:
> On Fri, May 13, 2011 at 8:56 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> > I'm not totally certain with my explanation but it seemed like a good
> > working hypothesis.  Jayachandran C. bisected this morning's linux-queue
> > on his Netlogic XLR which is MIPS64 R1 and found this comment causing
> > the problem.
> 
> Jayachandran, could you please confirm/deny the following:
> 
> Netlogic XLR is a MIPS64 R1 system.
> 
> You are running a 32-bit kernel.
> 
> You are using 64-bit physical addresses.
> 
> You are not enabling RI/XI.
> 
> The commit that caused the regression was "[PATCH 1/4] MIPS: Replace
> _PAGE_READ with _PAGE_NO_READ" (not 2/4, 3/4, or 4/4).
> 
> Do you have a log showing the failure, or any other details of what happened?

Yes, it is a MIPS64R1 system with 64-bit (well 40bit) physical address, we
don't have rixi either on hardware on in kernel overrides. git bisect pointed
the specific patch.

And with your patch it works only on 64 bit compile, 32 bit kernel fails on
init with:
|malloc: subst.c:521: assertion botched
|free: called with already freed block argument

For 32-bit the config is nlm_xlr_defconfig in the source tree. Let me know if
you need any further info.

Regards,
JC.
