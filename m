Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2017 22:54:10 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.154.233]:36661 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990406AbdJTUyDTevlL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Oct 2017 22:54:03 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 20 Oct 2017 20:53:02 +0000
Received: from [10.20.78.35] (10.20.78.35) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Fri, 20 Oct 2017 13:52:10 -0700
Date:   Fri, 20 Oct 2017 21:52:33 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Joe Perches <joe@perches.com>
CC:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        <linux-mips@linux-mips.org>,
        Dragan Cecavac <dragan.cecavac@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        James Hogan <james.hogan@mips.com>,
        James Hogan <jhogan@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: kernel: proc: Remove spurious white space in
 cpuinfo
In-Reply-To: <1508512648.30181.1.camel@perches.com>
Message-ID: <alpine.DEB.2.00.1710202148280.3886@tp.orcam.me.uk>
References: <1508509203-30661-1-git-send-email-aleksandar.markovic@rt-rk.com> <1508512648.30181.1.camel@perches.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1508532765-452059-5275-728925-3
X-BESS-VER: 2017.12.1-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186156
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

On Fri, 20 Oct 2017, Joe Perches wrote:

> > diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> > index bd9bf52..99f9aab 100644
> > --- a/arch/mips/kernel/proc.c
> > +++ b/arch/mips/kernel/proc.c
> > @@ -58,7 +58,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> >  
> >  	seq_printf(m, "processor\t\t: %ld\n", n);
> >  	sprintf(fmt, "cpu model\t\t: %%s V%%d.%%d%s\n",
> > -		      cpu_data[n].options & MIPS_CPU_FPU ? "  FPU V%d.%d" : "");
> > +		      cpu_data[n].options & MIPS_CPU_FPU ? " FPU V%d.%d" : "");
> >  	seq_printf(m, fmt, __cpu_name[n],
> >  		      (version >> 4) & 0x0f, version & 0x0f,
> >  		      (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
> 
> That's somewhat unpleasant code as it formats a fmt string
> and the compiler can not verify fmt and args.
> 
> Perhaps something like the below is preferable:

 Hmm, what problem exactly are you trying to solve with code that has 
worked just fine for 16 years now?

  Maciej
