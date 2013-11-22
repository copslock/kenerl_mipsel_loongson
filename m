Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Nov 2013 01:32:06 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35082 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817128Ab3KVAcEGm7YK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Nov 2013 01:32:04 +0100
Date:   Fri, 22 Nov 2013 00:32:04 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: R2300 (not the hay baler)
In-Reply-To: <20131121224301.GY10382@linux-mips.org>
Message-ID: <alpine.LFD.2.03.1311220016030.3267@linux-mips.org>
References: <528B466A.3050906@imgtec.com> <alpine.LFD.2.03.1311191156570.3267@linux-mips.org> <528B60B3.6030406@imgtec.com> <alpine.LFD.2.03.1311211934420.3267@linux-mips.org> <20131121224301.GY10382@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38571
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

On Thu, 21 Nov 2013, Ralf Baechle wrote:

> >  Also I'm not sure what the core file format is for the FP context, it may 
> > be worth double-checking too.
> 
> Is there some test suite for that kind of stuff?

 GDB has some core file support coverage; I'm not sure if it's meticulous 
enough to catch such issues though, and also if it checks OS-produced 
cores or ones made with its own `generate-core-file' (aka `gcore') command 
only.  Besides if ptrace(2) and the core dumper are consistent with each 
other, then chances are that any bugs there cancel each other too.

> >  Please feel free to poke me directly if you have any further issues about 
> > MIPS I ISA compatibility.
> 
> Makes me wonder if there's a MIPS emulator that emulates a MIPS I system
> faithfully.

 The Algorithmics FPU emulator (the original version shipped with their 
SDE kit, not the kernel version we got contributed) could have been 
strapped for true MIPS I support I believe.  Also GNU sim might be able to 
emulate a whole MIPS I CPU, although I haven't checked.  Other than that I 
haven't seen any (QEMU does not).

  Maciej
