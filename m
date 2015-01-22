Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2015 15:08:40 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34620 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010595AbbAVOIjOf85y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Jan 2015 15:08:39 +0100
Date:   Thu, 22 Jan 2015 14:08:39 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH RFC v2 30/70] MIPS: kernel: proc: Add MIPS R6 support to
 /proc/cpuinfo
In-Reply-To: <54BF709B.1080609@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501210936410.28301@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-31-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501202336540.28301@eddie.linux-mips.org> <54BF709B.1080609@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45428
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

On Wed, 21 Jan 2015, Markos Chandras wrote:

> >> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> >> index 097fc8d14e42..a8fdf9685cad 100644
> >> --- a/arch/mips/kernel/proc.c
> >> +++ b/arch/mips/kernel/proc.c
> >> @@ -82,7 +82,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> >>  		seq_printf(m, "]\n");
> >>  	}
> >>  
> >> -	seq_printf(m, "isa\t\t\t: mips1");
> >> +	seq_printf(m, "isa\t\t\t:"); 
> >> +	if (!cpu_has_mips_r6)
> >> +		seq_printf(m, " mips1");
> > 
> >  I think define `cpu_has_mips_r1' instead and use it here.  It may turn 
> > out needed elsewhere too.  We probably don't need a new `MIPS_CPU_ISA_I' 
> > bit at this stage so this could be:

 Typo here, I meant `cpu_has_mips_1' actually, sorry about that.

> the change is simple enough and I see no reason to define the
> cpu_has_mips_r1 at the moment. If we ever need to explicitly handle r1,
> we can reconsider that.

 It's a matter of code clarity, good code is self-explanatory.  Here the 
intent is to print `mips1' if it is supported.  By avoiding the extra 
definition you're detaching the intent from what code says.  Someone 
reading this code (who may not necessarily know the architecture documents 
by heart) has to scratch their head thinking: "why isn't `mips1' printed 
for R6, what the former has to do with the latter, and why is this case 
different to `mips2' and other ones that follow?"

 Whereas the intent is clear with this:

#define cpu_has_mips_1 (!cpu_has_mips_r6) // Aha, `mips1' is there if no R6!

	if (cpu_has_mips_1)
		seq_printf(m, " mips1");  // Well, this is obvious...

Do you see what I mean?  Do you agree now?

  Maciej
