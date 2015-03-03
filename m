Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2015 08:31:45 +0100 (CET)
Received: from mail-wg0-f49.google.com ([74.125.82.49]:39416 "EHLO
        mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006779AbbCCHbnLz7KS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Mar 2015 08:31:43 +0100
Received: by wggx12 with SMTP id x12so38126080wgg.6;
        Mon, 02 Mar 2015 23:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bEJRDpNTx6PykpJ674CppB7jD48X4TET+E/xYZxVYGk=;
        b=QEc35ydBVReBF8sEy08+7CCc812bT7D+i6APFUONkY67Qa38Xa+sGZoUw+ETyJW5TT
         cSSeNcjNFsQuUSeg7JYRzgLE/bOj5lY8qpWKLrB7nSD7Mw/OdiCndWvh6TIj7tBPclA7
         mqB5NgGFGsho4OJcSg/GRQbU/Y36bM9h9vFg6IUMHHOi5xb9ICc8HzHYy4uG02UP87qT
         U97CAN6fq8aEh4u1S0jQ1LYcfNW0C/jF00offc2wx2tsZGbSM6dDAu4RwwPnpp6rY84p
         5hv51K6v6ypmxXqrA2LXCtQTH4PyiHUAbPPlu+SwJcaLtY01MX13BbCv5wmEDiDGAkoB
         ufYw==
X-Received: by 10.180.207.6 with SMTP id ls6mr43798834wic.13.1425367898432;
        Mon, 02 Mar 2015 23:31:38 -0800 (PST)
Received: from gmail.com (540334ED.catv.pool.telekom.hu. [84.3.52.237])
        by mx.google.com with ESMTPSA id jy7sm19255366wid.22.2015.03.02.23.31.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2015 23:31:36 -0800 (PST)
Date:   Tue, 3 Mar 2015 08:31:32 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "David A. Long" <dave.long@linaro.org>,
        Andrey Ryabinin <a.ryabinin@samsung.com>,
        Arun Chandran <achandran@mvista.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Min-Hua Chen <orca.chen@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Jeff Bailey <jeffbailey@google.com>,
        Vineeth Vijayan <vvijayan@mvista.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Borislav Petkov <bp@suse.de>,
        Jan-Simon =?iso-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/5] split ET_DYN ASLR from mmap ASLR
Message-ID: <20150303073132.GA30602@gmail.com>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425341988-1599-1-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* Kees Cook <keescook@chromium.org> wrote:

> To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
> ASLR from mmap ASLR, as already done on s390. The architectures
> that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
> and x86), have their various forms of arch_mmap_rnd() made available
> via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
> arch_randomize_brk() is collapsed as well.
> 
> This is an alternative to the solutions in:
> https://lkml.org/lkml/2015/2/23/442

Looks good so far:

Reviewed-by: Ingo Molnar <mingo@kernel.org>

While reviewing this series I also noticed that the following code 
could be factored out from architecture mmap code as well:

  - arch_pick_mmap_layout() uses very similar patterns across the 
    platforms, with only few variations. Many architectures use 
    the same duplicated mmap_is_legacy() helper as well. There's 
    usually just trivial differences between mmap_legacy_base() 
    approaches as well.

  - arch_mmap_rnd(): the PF_RANDOMIZE checks are needlessly
    exposed to the arch routine - the arch routine should only 
    concentrate on arch details, not generic flags like
    PF_RANDOMIZE.

In theory the mmap layout could be fully parametrized as well: i.e. no 
callback functions to architectures by default at all: just 
declarations of bits of randomization desired (or, available address 
space bits), and perhaps an arch helper to allow 32-bit vs. 64-bit 
address space distinctions.

'Weird' architectures could provide special routines, but only by 
overriding the default behavior, which should be generic, safe and 
robust.

Thanks,

	Ingo
