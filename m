Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2006 18:21:01 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:47760 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20040230AbWK1SU7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Nov 2006 18:20:59 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kASIKp1h020518;
	Tue, 28 Nov 2006 18:20:51 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kASIKnCw020517;
	Tue, 28 Nov 2006 18:20:49 GMT
Date:	Tue, 28 Nov 2006 18:20:49 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Philip J. Mucci" <phil@sicortex.com>
Cc:	eranian@hpl.hp.com, perfmon@napali.hpl.hp.com,
	linux-mips@linux-mips.org
Subject: Re: [Perfctr-devel] 2.6.19-rc6-git10 new perfmon code base + libpfm + pfmon
Message-ID: <20061128182049.GA19304@linux-mips.org>
References: <20061127143705.GC24980@frankl.hpl.hp.com> <1164725427.2316.109.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164725427.2316.109.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 28, 2006 at 03:50:27PM +0100, Philip J. Mucci wrote:

> Linux-MIPS users will need the following patch to add the 'cpu'
> directories to sysfs.

This patch is to some file which doesn't even exist in standard
kernels.  Nor should it be done in the perfmon code if it did exist in
the stock kernel.

> Index: perfmon/perfmon_sysfs.c
> ===================================================================
> --- perfmon/perfmon_sysfs.c	(.../perfmon2-post-sf-pre-fixup)	(revision 27882)
> +++ perfmon/perfmon_sysfs.c	(.../perfmon2-post-sf-post-fixup)	(revision 27882)
> @@ -79,6 +79,10 @@
>  
>  static struct kobject pfm_kernel_kobj, pfm_kernel_fmt_kobj;
>  
> +/* Remove this after mips get topology.c files */

Why should there be one?  I guess you were looking for topology_init
which exists since Febuary 20 / linux-2.6.16-rc5 and does register all
CPUs.

> +struct cpu sysfs_cpus[NR_CPUS];
> +
>  static void pfm_reset_stats(int cpu)
>  {
>  	struct pfm_stats *st;
> @@ -400,6 +404,19 @@
>  	int done_kobj_fmt = 0, done_kobj_kernel = 0;
>  	int i, cpu = -1;
>  	
> +	/* This is a hack to be removed */
> +
> +        for_each_present_cpu(i) {
> +          ret = register_cpu(&sysfs_cpus[i],i,NULL);
> +          if (ret)
> +            {
> +              PFM_INFO("cannot register cpu %d: %d\n",i,ret);
> +              goto error;
> +            }
> +        }
> +
> +	/* End hack */

Formatting style, see Documentation/CodingStyle.

  Ralf
