Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2017 23:09:10 +0200 (CEST)
Received: from smtprelay0114.hostedemail.com ([216.40.44.114]:44384 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990406AbdJTVJCS8mPL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Oct 2017 23:09:02 +0200
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 541A3180A8147;
        Fri, 20 Oct 2017 21:09:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: board79_6b533f76e4a1c
X-Filterd-Recvd-Size: 2604
Received: from XPS-9350 (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Oct 2017 21:08:57 +0000 (UTC)
Message-ID: <1508533736.30181.7.camel@perches.com>
Subject: Re: [PATCH] MIPS: kernel: proc: Remove spurious white space in
 cpuinfo
From:   Joe Perches <joe@perches.com>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        linux-mips@linux-mips.org,
        Dragan Cecavac <dragan.cecavac@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        James Hogan <james.hogan@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Date:   Fri, 20 Oct 2017 14:08:56 -0700
In-Reply-To: <alpine.DEB.2.00.1710202148280.3886@tp.orcam.me.uk>
References: <1508509203-30661-1-git-send-email-aleksandar.markovic@rt-rk.com>
         <1508512648.30181.1.camel@perches.com>
         <alpine.DEB.2.00.1710202148280.3886@tp.orcam.me.uk>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Fri, 2017-10-20 at 21:52 +0100, Maciej W. Rozycki wrote:
> On Fri, 20 Oct 2017, Joe Perches wrote:
> 
> > > diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> > > index bd9bf52..99f9aab 100644
> > > --- a/arch/mips/kernel/proc.c
> > > +++ b/arch/mips/kernel/proc.c
> > > @@ -58,7 +58,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> > >  
> > >  	seq_printf(m, "processor\t\t: %ld\n", n);
> > >  	sprintf(fmt, "cpu model\t\t: %%s V%%d.%%d%s\n",
> > > -		      cpu_data[n].options & MIPS_CPU_FPU ? "  FPU V%d.%d" : "");
> > > +		      cpu_data[n].options & MIPS_CPU_FPU ? " FPU V%d.%d" : "");
> > >  	seq_printf(m, fmt, __cpu_name[n],
> > >  		      (version >> 4) & 0x0f, version & 0x0f,
> > >  		      (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
> > 
> > That's somewhat unpleasant code as it formats a fmt string
> > and the compiler can not verify fmt and args.
> > 
> > Perhaps something like the below is preferable:
> 
>  Hmm, what problem exactly are you trying to solve with code that has 
> worked just fine for 16 years now?

The compiler cannot verify fmt and args.
