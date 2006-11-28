Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2006 19:05:34 +0000 (GMT)
Received: from ka.cs.utk.edu ([160.36.56.221]:47032 "EHLO ka.cs.utk.edu")
	by ftp.linux-mips.org with ESMTP id S20040229AbWK1TF2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2006 19:05:28 +0000
Received: from localhost (localhost [127.0.0.1])
	by ka.cs.utk.edu (Postfix) with ESMTP id D903C2F291;
	Tue, 28 Nov 2006 14:05:16 -0500 (EST)
X-Virus-Scanned: by amavisd-new with ClamAV and SpamAssasin at cs.utk.edu
Received: from ka.cs.utk.edu ([127.0.0.1])
	by localhost (ka.cs.utk.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O74EQyG4h4ob; Tue, 28 Nov 2006 14:05:07 -0500 (EST)
Received: from [192.168.1.9] (213-66-54-131-o837.telia.com [213.66.54.131])
	by ka.cs.utk.edu (Postfix) with ESMTP id 83D1E2F22E;
	Tue, 28 Nov 2006 14:05:06 -0500 (EST)
Subject: Re: [Perfctr-devel] 2.6.19-rc6-git10 new perfmon code base +
	libpfm + pfmon
From:	"Philip J. Mucci" <mucci@cs.utk.edu>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	eranian@hpl.hp.com, perfmon@napali.hpl.hp.com,
	linux-mips@linux-mips.org
In-Reply-To: <20061128182049.GA19304@linux-mips.org>
References: <20061127143705.GC24980@frankl.hpl.hp.com>
	 <1164725427.2316.109.camel@localhost.localdomain>
	 <20061128182049.GA19304@linux-mips.org>
Content-Type: text/plain
Date:	Tue, 28 Nov 2006 20:05:02 +0100
Message-Id: <1164740702.2316.151.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Return-Path: <mucci@cs.utk.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mucci@cs.utk.edu
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Forgive me, I thought Stefane had posted the announcement of the new
perfmon kernel substrate on Linux/MIPS list. I see now that he did not,
so it's likely that the below patch has little meaning to you folks. I
do know however, that there are some broadcom folks tracking this work.

This is not meant to be a patch for the Linux/MIPS tree, but rather the
perfmon2 patch when applied to Linus' latest GIT tree. This hack (marked
as such) gets around a NULL pointer dereference upon boot. I make no
claims other than that it lets the MIPS folks play with the perfmon2
implementation.

Phil

On Tue, 2006-11-28 at 18:20 +0000, Ralf Baechle wrote:
> On Tue, Nov 28, 2006 at 03:50:27PM +0100, Philip J. Mucci wrote:
> 
> > Linux-MIPS users will need the following patch to add the 'cpu'
> > directories to sysfs.
> 
> This patch is to some file which doesn't even exist in standard
> kernels.  Nor should it be done in the perfmon code if it did exist in
> the stock kernel.
> 
> > Index: perfmon/perfmon_sysfs.c
> > ===================================================================
> > --- perfmon/perfmon_sysfs.c	(.../perfmon2-post-sf-pre-fixup)	(revision 27882)
> > +++ perfmon/perfmon_sysfs.c	(.../perfmon2-post-sf-post-fixup)	(revision 27882)
> > @@ -79,6 +79,10 @@
> >  
> >  static struct kobject pfm_kernel_kobj, pfm_kernel_fmt_kobj;
> >  
> > +/* Remove this after mips get topology.c files */
> 
> Why should there be one?  I guess you were looking for topology_init
> which exists since Febuary 20 / linux-2.6.16-rc5 and does register all
> CPUs.
> 
> > +struct cpu sysfs_cpus[NR_CPUS];
> > +
> >  static void pfm_reset_stats(int cpu)
> >  {
> >  	struct pfm_stats *st;
> > @@ -400,6 +404,19 @@
> >  	int done_kobj_fmt = 0, done_kobj_kernel = 0;
> >  	int i, cpu = -1;
> >  	
> > +	/* This is a hack to be removed */
> > +
> > +        for_each_present_cpu(i) {
> > +          ret = register_cpu(&sysfs_cpus[i],i,NULL);
> > +          if (ret)
> > +            {
> > +              PFM_INFO("cannot register cpu %d: %d\n",i,ret);
> > +              goto error;
> > +            }
> > +        }
> > +
> > +	/* End hack */
> 
> Formatting style, see Documentation/CodingStyle.
> 
>   Ralf
