Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 02:36:39 +0100 (CET)
Received: from smtprelay4.synopsys.com ([198.182.47.9]:56659 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994774AbdCNBgcJ7wDb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 02:36:32 +0100
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4FCBC24E1F77;
        Mon, 13 Mar 2017 18:36:18 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id 47676DEF;
        Mon, 13 Mar 2017 18:36:18 -0700 (PDT)
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5CDD0DAF;
        Mon, 13 Mar 2017 18:36:14 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Mon, 13 Mar 2017 18:36:14 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Tue, 14 Mar 2017 07:06:11 +0530
Received: from [10.12.196.139] (10.12.196.139) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Tue, 14 Mar 2017 07:06:10 +0530
Subject: Re: [RFC PATCH 10/13] mm: Introduce first class virtual address
 spaces
To:     Till Smejkal <till.smejkal@googlemail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Steven Miao <realmz6@gmail.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@synopsys.COM>
References: <20170313221415.9375-1-till.smejkal@gmail.com>
 <20170313221415.9375-11-till.smejkal@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-alpha@vger.kernel.org>,
        <linux-snps-arc@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <adi-buildroot-devel@lists.sourceforge.net>,
        <linux-hexagon@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <linux-metag@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-parisc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
        <sparclinux@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>,
        <linux-media@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-aio@kvack.org>, <linux-mm@kvack.org>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Ingo Molnar <mingo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>
Newsgroups: gmane.linux.ports.alpha,gmane.linux.kernel.arc,gmane.linux.ports.arm.kernel,gmane.linux.ports.hexagon,gmane.linux.ports.ia64,gmane.linux.kernel.metag,gmane.linux.ports.parisc,gmane.linux.ports.ppc64.devel,gmane.linux.ports.sh.devel,gmane.linux.ports.sparc,gmane.linux.drivers.video-input-infrastructure,
 gmane.linux.drivers.mtd,gmane.linux.usb.general,gmane.linux.file-systems,gmane.linux.kernel.mm,gmane.linux.kernel.api,gmane.linux.kernel.cross-arch,gmane.linux.alsa.devel
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <cd1adda8-bf6a-47ad-bff3-5bc6626ac100@synopsys.com>
Date:   Mon, 13 Mar 2017 18:35:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170313221415.9375-11-till.smejkal@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.12.196.139]
Return-Path: <Vineet.Gupta1@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Vineet.Gupta1@synopsys.com
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

+CC Ingo, tglx

Hi Till,

On 03/13/2017 03:14 PM, Till Smejkal wrote:
> Introduce a different type of address spaces which are first class citizens
> in the OS. That means that the kernel now handles two types of AS, those
> which are closely coupled with a process and those which aren't. While the
> former ones are created and destroyed together with the process by the
> kernel and are the default type of AS in the Linux kernel, the latter ones
> have to be managed explicitly by the user and are the newly introduced
> type.
> 
> Accordingly, a first class AS (also called VAS == virtual address space)
> can exist in the OS independently from any process. A user has to
> explicitly create and destroy them in the system. Processes and VAS can be
> combined by attaching a previously created VAS to a process which basically
> adds an additional AS to the process that the process' threads are able to
> execute in. Hence, VAS allow a process to have different views onto the
> main memory of the system (its original AS and the attached VAS) between
> which its threads can switch arbitrarily during their lifetime.
> 
> The functionality made available through first class virtual address spaces
> can be used in various different ways. One possible way to utilize VAS is
> to compartmentalize a process for security reasons. Another possible usage
> is to improve the performance of data-centric applications by being able to
> manage different sets of data in memory without the need to map or unmap
> them.
> 
> Furthermore, first class virtual address spaces can be attached to
> different processes at the same time if the underlying memory is only
> readable. This mechanism allows sharing of whole address spaces between
> multiple processes that can both execute in them using the contained
> memory.

I've not looked at the patches closely (or read the references paper fully yet),
but at first glance it seems on ARC architecture, we can can potentially
use/leverage this mechanism to implement the shared TLB entries. Before anyone
shouts these are not same as the IA64/x86 protection keys which allow TLB entries
with different protection bits across processes etc. These TLB entries are
actually *shared* by processes.

Conceptually there's shared address spaces, independent of processes. e.g. ldso
code is shared address space #1, libc (code) #2 .... System can support a limited
number of shared addr spaces (say 64, enough for typical embedded sys).

While Normal TLB entries are tagged with ASID (Addr space ID) to keep them unique
across processes, Shared TLB entries are tagged with Shared address space ID.

A process MMU context consists of ASID (a single number) and a SASID bitmap (to
allow "subscription" to multiple Shared spaces. The subscriptions are set up bu
userspace ld.so which knows about the libs process wants to map.

The restriction ofcourse is that the spaces are mapped at *same* vaddr is all
participating processes. I know this goes against whole security, address space
randomization - but it gives much better real time performance. Why does each
process need to take a MMU exception for libc code...

So long story short - it seems there can be multiple uses of this infrastructure !

-Vineet
