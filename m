Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 07:30:03 +0100 (CET)
Received: from asavdk4.altibox.net ([109.247.116.15]:36573 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009709AbcAZGaBej40u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 07:30:01 +0100
Received: from ravnborg.org (unknown [188.228.89.252])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 070EE802E0;
        Tue, 26 Jan 2016 07:29:52 +0100 (CET)
Date:   Tue, 26 Jan 2016 07:29:51 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-parisc@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 02/16] sparc/compat: Provide an accurate
 in_compat_syscall implementation
Message-ID: <20160126062951.GA17107@ravnborg.org>
References: <cover.1453759363.git.luto@kernel.org>
 <e520030f750b29d14486aa1e99c271a0fa18f19e.1453759363.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e520030f750b29d14486aa1e99c271a0fa18f19e.1453759363.git.luto@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.1 cv=OIGHpXuB c=1 sm=1 tr=0
        a=Ij76tQDYWdb01v2+RnYW5w==:117 a=Ij76tQDYWdb01v2+RnYW5w==:17
        a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
        a=VwQbUJbxAAAA:8 a=ncVs1cyC0FsadXMmyMIA:9 a=CjuIK1q_8ugA:10
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
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

On Mon, Jan 25, 2016 at 02:24:16PM -0800, Andy Lutomirski wrote:
> On sparc64 compat-enabled kernels, any task can make 32-bit and
> 64-bit syscalls.  is_compat_task returns true in 32-bit tasks, which
> does not necessarily imply that the current syscall is 32-bit.
> 
> Provide an in_compat_syscall implementation that checks whether the
> current syscall is compat.
> 
> As far as I know, sparc is the only architecture on which
> is_compat_task checks the compat status of the task and on which the
> compat status of a syscall can differ from the compat status of the
> task.  On x86, is_compat_task checks the syscall type, not the task
> type.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/sparc/include/asm/compat.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
> index 830502fe62b4..5467404857fc 100644
> --- a/arch/sparc/include/asm/compat.h
> +++ b/arch/sparc/include/asm/compat.h
> @@ -307,4 +307,10 @@ static inline int is_compat_task(void)
>  	return test_thread_flag(TIF_32BIT);
>  }
>  
> +static inline bool in_compat_syscall(void)
> +{
> +	return pt_regs_trap_type(current_pt_regs()) == 0x110;
Could you please add a comment about where 0x110 comes from.
I at least failed to track this down.

	Sam
