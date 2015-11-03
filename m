Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2015 14:23:42 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47103 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012417AbbKCNXjgDgMI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Nov 2015 14:23:39 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id tA3DNa6Z015827;
        Tue, 3 Nov 2015 14:23:36 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id tA3DNa5G015826;
        Tue, 3 Nov 2015 14:23:36 +0100
Date:   Tue, 3 Nov 2015 14:23:36 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] MIPS: CONFIG_MIPS_MT_SMP should depend upon
 CPU_MIPSR2
Message-ID: <20151103132335.GA15726@linux-mips.org>
References: <1438814560-19821-1-git-send-email-paul.burton@imgtec.com>
 <1438814560-19821-6-git-send-email-paul.burton@imgtec.com>
 <20150912101638.GA7422@linux-mips.org>
 <20150912151131.GA3831@NP-P-BURTON>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150912151131.GA3831@NP-P-BURTON>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sat, Sep 12, 2015 at 08:11:31AM -0700, Paul Burton wrote:
> Date:   Sat, 12 Sep 2015 08:11:31 -0700
> From: Paul Burton <paul.burton@imgtec.com>
> To: Ralf Baechle <ralf@linux-mips.org>
> CC: linux-mips@linux-mips.org, Markos Chandras
>  <markos.chandras@imgtec.com>, stable@vger.kernel.org,
>  linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 5/6] MIPS: CONFIG_MIPS_MT_SMP should depend upon
>  CPU_MIPSR2
> Content-Type: text/plain; charset="utf-8"
> 
> On Sat, Sep 12, 2015 at 12:16:39PM +0200, Ralf Baechle wrote:
> > >  config MIPS_MT_SMP
> > >  	bool "MIPS MT SMP support (1 TC on each available VPE)"
> > > -	depends on SYS_SUPPORTS_MULTITHREADING
> > > +	depends on SYS_SUPPORTS_MULTITHREADING && CPU_MIPSR2
> > 
> > Right now this line is
> > 
> > depends on SYS_SUPPORTS_MULTITHREADING && !CPU_MIPSR6
> > 
> > which I believe is correct.  The MT SMP support aka VSMP had been
> > carefully crafted to work on older ASEs that is all use of MIPS MT
> > instructions or features was carefully protected by cpu_has_mipsmt
> > or similar.
> 
> I disagree. The "background" section in the introduction to the MT ASE
> spec (MD00376, revision 1.12) reads:
> 
> > Multi-threading, or the concurrent presence of multiple active threads
> > or contexts of execution on the same CPU, is an increasingly
> > widely-used technique for tolerating memory and execution latency and
> > for getting higher utilization out of processor functional units. The
> > MIPS® Multi-threading (MT) Module is an extension to Release 2 (and
> > newer) of the MIPS32® Architecture which provides a framework for
> > multi-threading the MIPS processor architecture.
> 
> MT is quite clearly an extension to r2. The MT bit in Config3 has this
> note in the MIPS32 PRA (MD00088, revision 6.01):
> 
> > For Release 6 and MIPS after, this bit must be 0.
> 
> Thus MT is an option from r2 <= ISA < r6. The current !CPU_MIPSR6
> constraint in Kconfig only enforces half of that. Depending upon
> CPU_MIPSR2 would enforce the whole.

Correct.  Still, VSMP's use of MT instruction is very limited to a few
particular places in the kernel which makes a simple exervise to support
a kernel that is capable of supporting VSMP yet will support MIPS IV,
MIPS 32R1 CPUs or MIPS 32R2+ without MT.

  Ralf
