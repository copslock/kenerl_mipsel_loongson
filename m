Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2011 13:58:42 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52890 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491082Ab1CYM6j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Mar 2011 13:58:39 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p2PCwLP5032433;
        Fri, 25 Mar 2011 13:58:22 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p2PCwKbv032431;
        Fri, 25 Mar 2011 13:58:20 +0100
Date:   Fri, 25 Mar 2011 13:58:20 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Jayachandran C <jayachandranc@netlogicmicro.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/7] Netlogic XLR/XLS processor IDs.
Message-ID: <20110325125819.GC18212@linux-mips.org>
References: <cover.1301028080.git.jayachandranc@netlogicmicro.com>
 <bf492d3d03640f86bdd9963d892545423567451d.1301028081.git.jayachandranc@netlogicmicro.com>
 <4D8C7C01.9080107@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D8C7C01.9080107@mvista.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 25, 2011 at 02:26:57PM +0300, Sergei Shtylyov wrote:

> >+static inline void cpu_probe_netlogic(struct cpuinfo_mips *c, int cpu)
> >+{
> >+	decode_configs(c);
> >+
> >+	c->options = (MIPS_CPU_TLB     |
> 
>    Perhaps should align | with others...
> 
> >+			MIPS_CPU_4KEX    |
> >+			MIPS_CPU_COUNTER |
> >+			MIPS_CPU_DIVEC   |
> >+			MIPS_CPU_WATCH   |
> >+			MIPS_CPU_EJTAG   |
> >+			MIPS_CPU_LLSC);

I reformatted that.

> [...]
> >+	default:
> >+		printk(KERN_INFO "Unknown Netlogic chip id [%02x]!\n",
> 
>    Not %04x?

I changed this into a panic call.  An unknown CPU type means very little
chance for the system to actually succesfully boot the system.

Queued for 2.6.39.  Thanks,

  Ralf
