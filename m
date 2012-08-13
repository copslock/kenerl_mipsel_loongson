Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2012 19:03:54 +0200 (CEST)
Received: from mail.skyhub.de ([78.46.96.112]:54093 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903392Ab2HMRDu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Aug 2012 19:03:50 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTP id B8C111D955E;
        Mon, 13 Aug 2012 19:03:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alien8.de; s=alien8;
        t=1344877428; bh=xUJSbN6+F+aQVvyXRywqeV1Sk1a8qHtl6cKkZV8AYvQ=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To; b=D2QJno6npxZLQ8AXGE0jhDWuH1BDTs2Pe/6JJV
        w3ZczPL9GEhklbw3Lr+A00deAW+AIHowbm6qT/7rbfjyHLL8abAvyWxNrpYqtTopbXz
        mF2q/fzSsKEI6H55C17znTprUWJMWaKKhmDrCtkhf7ZRT+d2NzgU5JzEiCODC0boCk=
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (door.skyhub.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id G0ADsSwuKOSy; Mon, 13 Aug 2012 19:03:48 +0200 (CEST)
Received: from x1.localdomain (unknown [217.9.48.21])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 236FC1D955A;
        Mon, 13 Aug 2012 19:03:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alien8.de; s=alien8;
        t=1344877428; bh=xUJSbN6+F+aQVvyXRywqeV1Sk1a8qHtl6cKkZV8AYvQ=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To; b=D2QJno6npxZLQ8AXGE0jhDWuH1BDTs2Pe/6JJV
        w3ZczPL9GEhklbw3Lr+A00deAW+AIHowbm6qT/7rbfjyHLL8abAvyWxNrpYqtTopbXz
        mF2q/fzSsKEI6H55C17znTprUWJMWaKKhmDrCtkhf7ZRT+d2NzgU5JzEiCODC0boCk=
Received: by x1.localdomain (Postfix, from userid 1000)
        id CAFE1AA0CB; Mon, 13 Aug 2012 19:04:02 +0200 (CEST)
Date:   Mon, 13 Aug 2012 19:04:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Jan Beulich <JBeulich@suse.com>, Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Robert Richter <robert.richter@amd.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Alex Shi <alex.shu@intel.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        x86@kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/6] x86: Add clear_page_nocache
Message-ID: <20120813170402.GB15530@x1.osrc.amd.com>
Mail-Followup-To: Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jan Beulich <JBeulich@suse.com>, Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Robert Richter <robert.richter@amd.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Alex Shi <alex.shu@intel.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, x86@kernel.org,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1344524583-1096-5-git-send-email-kirill.shutemov@linux.intel.com>
 <5023F1BC0200007800093EF0@nat28.tlf.novell.com>
 <20120813114334.GA21855@otc-wbsnb-06>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20120813114334.GA21855@otc-wbsnb-06>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bp@alien8.de
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

On Mon, Aug 13, 2012 at 02:43:34PM +0300, Kirill A. Shutemov wrote:
> $ cat test.c
> #include <stdio.h>
> #include <sys/mman.h>
> 
> #define SIZE 1024*1024*1024
> 
> void clear_page_nocache_sse2(void *page) __attribute__((regparm(1)));
> 
> int main(int argc, char** argv)
> {
>         char *p;
>         unsigned long i, j;
> 
>         p = mmap(NULL, SIZE, PROT_WRITE|PROT_READ,
>                         MAP_PRIVATE|MAP_ANONYMOUS|MAP_POPULATE, -1, 0);
>         for(j = 0; j < 100; j++) {
>                 for(i = 0; i < SIZE; i += 4096) {
>                         clear_page_nocache_sse2(p + i);
>                 }
>         }
> 
>         return 0;
> }
> $ cat clear_page_nocache_unroll32.S
> .globl clear_page_nocache_sse2
> .align 4,0x90
> clear_page_nocache_sse2:
> .cfi_startproc
>         mov    %eax,%edx
>         xorl   %eax,%eax
>         movl   $4096/32,%ecx
>         .p2align 4
> .Lloop_sse2:
>         decl    %ecx
> #define PUT(x) movnti %eax,x*4(%edx)
>         PUT(0)
>         PUT(1)
>         PUT(2)
>         PUT(3)
>         PUT(4)
>         PUT(5)
>         PUT(6)
>         PUT(7)
> #undef PUT
>         lea     32(%edx),%edx
>         jnz     .Lloop_sse2
>         nop
>         ret
> .cfi_endproc
> .type clear_page_nocache_sse2, @function
> .size clear_page_nocache_sse2, .-clear_page_nocache_sse2
> $ cat clear_page_nocache_unroll64.S
> .globl clear_page_nocache_sse2
> .align 4,0x90
> clear_page_nocache_sse2:
> .cfi_startproc
>         mov    %eax,%edx

This must still be the 32-bit version becaue it segfaults here. Here's
why:

mmap above gives a ptr which, on 64-bit, is larger than 32-bit, i.e. it
looks like 0x7fffxxxxx000, i.e. starting from top of userspace.

Now, the mov above truncates that ptr and the thing segfaults.

Doing s/edx/rdx/g fixes it though.

Thanks.

-- 
Regards/Gruss,
Boris.
