Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 15:46:06 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:48261 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011099AbbATOqAaD7lP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 15:46:00 +0100
Date:   Tue, 20 Jan 2015 14:46:00 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
cc:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC v2 19/70] MIPS: Use the new "ZC" constraint for MIPS
 R6
In-Reply-To: <alpine.LFD.2.11.1501201433480.28301@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1501201441030.28301@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-20-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501200015580.28301@eddie.linux-mips.org> <6D39441BF12EF246A7ABCE6654B0235320FAC20A@LEMAIL01.le.imgtec.org>
 <54BE217D.3060508@imgtec.com> <6D39441BF12EF246A7ABCE6654B0235320FAC32D@LEMAIL01.le.imgtec.org> <54BE2A0B.8010500@imgtec.com> <alpine.LFD.2.11.1501201433480.28301@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, 20 Jan 2015, Maciej W. Rozycki wrote:

> > >> We have tools out there based on 4.9. If we make gcc < 5.0 to fail with
> > >> R6, then nobody will be able to build it until 5.0 is released.
> > >> Perhaps it makes sense to add some checks in arch/mips/Makefile, see if
> > >> our gcc supports -mips32r6 or something and then decide what to do.
> > > 
> > > Indeed, I think it is worthwhile supporting the use of tools which have R6
> > > backported to them owing to long lead times for new versions of GCC to be
> > > released.
> > > 
> > > I think you could actually just switch the check around and remove the
> > > check for micromips entirely, putting the GCC 4.9 check first:
> > > 
> > > #if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 9)
> > > #define GCC_OFF12_ASM() "ZC"
> > > #else
> > > #define GCC_OFF12_ASM() "R"
> > > #endif
> > > 
> > > From what I can see this is safe. It was presumably written with a micromips
> > > check out of caution to not change older non-micromips code-gen but that
> > > doesn't seem particularly important. It is an improvement to older code if
> > > anything.
> > 
> > For non-micromips kernel, this will start using "ZC" instead of "R",
> > whereas before, it only used "ZC" for micromips and "R" for everything
> > else. Is that safe? Maciej was the one committed this code, so if that's
> > still safe, then I will change it as requested.
> 
>  I'm fine with this proposal; a separate Makefile check for 
> `-march=mips32r6' support would be good too.

 With such an arrangement there is potential however that it'll break 
non-microMIPS builds for someone using a 4.9 prerelease that didn't yet 
have `ZC'.  This is why I arranged the macros like I did in the first 
place.  So if you are able to keep such an arrangement without 
complicating the structure too much, then it would be great.

  Maciej
