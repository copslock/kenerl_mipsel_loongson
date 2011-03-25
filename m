Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2011 14:12:49 +0100 (CET)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:4445 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491082Ab1CYNMq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Mar 2011 14:12:46 +0100
X-TM-IMSS-Message-ID: <533026760002b972@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 533026760002b972 ; Fri, 25 Mar 2011 06:12:38 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 25 Mar 2011 06:13:11 -0700
Date:   Fri, 25 Mar 2011 18:49:16 +0530
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/7] Netlogic XLR/XLS processor IDs.
Message-ID: <20110325131808.GA3402@jayachandranc.netlogicmicro.com>
References: <cover.1301028080.git.jayachandranc@netlogicmicro.com>
 <bf492d3d03640f86bdd9963d892545423567451d.1301028081.git.jayachandranc@netlogicmicro.com>
 <4D8C7C01.9080107@mvista.com>
 <20110325125819.GC18212@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110325125819.GC18212@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 25 Mar 2011 13:13:11.0754 (UTC) FILETIME=[64635AA0:01CBEAEE]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On Fri, Mar 25, 2011 at 01:58:20PM +0100, Ralf Baechle wrote:
> On Fri, Mar 25, 2011 at 02:26:57PM +0300, Sergei Shtylyov wrote:
> 
> > >+static inline void cpu_probe_netlogic(struct cpuinfo_mips *c, int cpu)
> > >+{
> > >+	decode_configs(c);
> > >+
> > >+	c->options = (MIPS_CPU_TLB     |
> > 
> >    Perhaps should align | with others...
> > 
> > >+			MIPS_CPU_4KEX    |
> > >+			MIPS_CPU_COUNTER |
> > >+			MIPS_CPU_DIVEC   |
> > >+			MIPS_CPU_WATCH   |
> > >+			MIPS_CPU_EJTAG   |
> > >+			MIPS_CPU_LLSC);
> 
> I reformatted that.
> 
> > [...]
> > >+	default:
> > >+		printk(KERN_INFO "Unknown Netlogic chip id [%02x]!\n",
> > 
> >    Not %04x?
> 
> I changed this into a panic call.  An unknown CPU type means very little
> chance for the system to actually succesfully boot the system.
> 
> Queued for 2.6.39.  Thanks,

Thanks!

I noticed that the commit messages for the patchset are messed up, it contains
part of the mail header too.

This is what I see in 'git log'
|commit 7271e23649991af8d70da576052312571b71dba3
|Author: Jayachandran C <jayachandranc@netlogicmicro.com>
|Date:   Fri Mar 25 10:29:09 2011 +0530
|
|    From jayachandranc@netlogicmicro.com  Fri Mar 25 05:52:44 2011
|    X-Spam-Checker-Version: SpamAssassin 3.3.2-r929478 (2010-03-31) on
|        eddie.linux-mips.org
|    X-Spam-Level:
|    X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
|        UPPERCASE_75_100 autolearn=no version=3.3.2-r929478

Not sure what caused this, let me know if it was my fault.

Thanks,
JC.
