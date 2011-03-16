Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2011 14:27:53 +0100 (CET)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:3737 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491063Ab1CPN1u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Mar 2011 14:27:50 +0100
X-TM-IMSS-Message-ID: <24e4c43d00014081@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 24e4c43d00014081 ; Wed, 16 Mar 2011 06:27:39 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 16 Mar 2011 06:19:37 -0700
Date:   Wed, 16 Mar 2011 18:54:43 +0530
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/7] Netlogic XLR/XLS processor IDs.
Message-ID: <20110316132442.GB15774@jayachandranc.netlogicmicro.com>
References: <cover.1300275485.git.jayachandranc@netlogicmicro.com>
 <d1e612aba3921501184783470ef06de5fbc2bc51.1300275485.git.jayachandranc@netlogicmicro.com>
 <4D80A691.2020902@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D80A691.2020902@mvista.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 16 Mar 2011 13:19:37.0558 (UTC) FILETIME=[CCA09F60:01CBE3DC]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

On Wed, Mar 16, 2011 at 03:01:21PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 16-03-2011 14:57, Jayachandran C wrote:
> 
> >Add Netlogic Microsystems company ID and processor IDs for XLR
> >and XLS processors for CPU probe. Add CPU_XLR to cpu_type_enum.
> 
> >Signed-off-by: Jayachandran C<jayachandranc@netlogicmicro.com>
> [...]
> 
> >diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> >index f65d4c8..a995d56 100644
> >--- a/arch/mips/kernel/cpu-probe.c
> >+++ b/arch/mips/kernel/cpu-probe.c
> >@@ -988,6 +988,59 @@ static inline void cpu_probe_ingenic(struct cpuinfo_mips *c, unsigned int cpu)
> >  	}
> >  }
> >
> >+static inline void cpu_probe_netlogic(struct cpuinfo_mips *c, int cpu)
> >+{
> >+	decode_configs(c);
> >+
> >+	c->options = (MIPS_CPU_TLB     |
> >+			MIPS_CPU_4KEX    |
> >+			MIPS_CPU_COUNTER |
> >+			MIPS_CPU_DIVEC   |
> >+			MIPS_CPU_WATCH   |
> >+			MIPS_CPU_EJTAG   |
> >+			MIPS_CPU_LLSC);
> >+
> >+	switch (c->processor_id&  0xff00) {
> >+	case PRID_IMP_NETLOGIC_XLR732:
> >+	case PRID_IMP_NETLOGIC_XLR716:
> >+	case PRID_IMP_NETLOGIC_XLR532:
> >+	case PRID_IMP_NETLOGIC_XLR308:
> >+	case PRID_IMP_NETLOGIC_XLR532C:
> >+	case PRID_IMP_NETLOGIC_XLR516C:
> >+	case PRID_IMP_NETLOGIC_XLR508C:
> >+	case PRID_IMP_NETLOGIC_XLR308C:
> >+		c->cputype = CPU_XLR;
> >+		__cpu_name[cpu] = "Netlogic XLR";
> >+		break;
> >+
> >+	case PRID_IMP_NETLOGIC_XLS608:
> >+	case PRID_IMP_NETLOGIC_XLS408:
> >+	case PRID_IMP_NETLOGIC_XLS404:
> >+	case PRID_IMP_NETLOGIC_XLS208:
> >+	case PRID_IMP_NETLOGIC_XLS204:
> >+	case PRID_IMP_NETLOGIC_XLS108:
> >+	case PRID_IMP_NETLOGIC_XLS104:
> >+	case PRID_IMP_NETLOGIC_XLS616B:
> >+	case PRID_IMP_NETLOGIC_XLS608B:
> >+	case PRID_IMP_NETLOGIC_XLS416B:
> >+	case PRID_IMP_NETLOGIC_XLS412B:
> >+	case PRID_IMP_NETLOGIC_XLS408B:
> >+	case PRID_IMP_NETLOGIC_XLS404B:
> >+		c->cputype = CPU_XLR;
> >+		__cpu_name[cpu] = "Netlogic XLS";
> >+		break;
> >+
> >+	default:
> >+		printk(KERN_INFO "Unknown Netlogic chip id [%02x]!\n",
> >+		       c->processor_id);
> >+		c->cputype = CPU_XLR;
> 
>    Why repeat this assignemnt in every case? Do it once only.

We will need to add new cases for c->cputype CPU_XLP in the next series
of patches. So it reduces a few lines in the next patchset....

-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
jchandra@freebsd.org                               (The FreeBSD Project)
