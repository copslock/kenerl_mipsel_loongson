Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2012 17:29:07 +0200 (CEST)
Received: from nat28.tlf.novell.com ([130.57.49.28]:33704 "EHLO
        nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903610Ab2HIP3D convert rfc822-to-8bit (ORCPT
        <rfc822;groupwise-linux-mips@linux-mips.org:12:1>);
        Thu, 9 Aug 2012 17:29:03 +0200
Received: from EMEA1-MTA by nat28.tlf.novell.com
        with Novell_GroupWise; Thu, 09 Aug 2012 16:28:57 +0100
Message-Id: <5023F3580200007800093F2C@nat28.tlf.novell.com>
X-Mailer: Novell GroupWise Internet Agent 12.0.0 
Date:   Thu, 09 Aug 2012 16:28:56 +0100
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Andi Kleen" <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Andy Lutomirski" <luto@amacapital.net>,
        "Robert Richter" <robert.richter@amd.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Hugh Dickins" <hughd@google.com>, "Alex Shi" <alex.shu@intel.com>,
        "KAMEZAWA Hiroyuki" <kamezawa.hiroyu@jp.fujitsu.com>,
        <x86@kernel.org>, <linux-mm@kvack.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        <linux-mips@linux-mips.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        <linuxppc-dev@lists.ozlabs.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Mel Gorman" <mgorman@suse.de>,
        <linux-kernel@vger.kernel.org>, <linux-sh@vger.kernel.org>,
        <sparclinux@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 6/6] x86: switch the 64bit uncached page clear
 to SSE/AVX v2
References: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1344524583-1096-7-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1344524583-1096-7-git-send-email-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
X-archive-position: 34084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: JBeulich@suse.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

>>> On 09.08.12 at 17:03, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
>  ENTRY(clear_page_nocache)
>  	CFI_STARTPROC
> -	xorl   %eax,%eax
> -	movl   $4096/64,%ecx
> +	push   %rdi
> +	call   kernel_fpu_begin
> +	pop    %rdi

You use CFI annotations elsewhere, so why don't you use
pushq_cfi/popq_cfi here?

Jan
