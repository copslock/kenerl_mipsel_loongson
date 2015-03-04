Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 00:56:26 +0100 (CET)
Received: from ozlabs.org ([103.22.144.67]:42633 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007079AbbCDX4YGyXIM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Mar 2015 00:56:24 +0100
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4B1C114007F;
        Thu,  5 Mar 2015 10:56:20 +1100 (AEDT)
Message-ID: <1425513380.32154.13.camel@ellerman.id.au>
Subject: Re: [PATCH 4/5] mm: split ET_DYN ASLR from mmap ASLR
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "x86@kernel.org" <x86@kernel.org>,
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
        Jan-Simon =?ISO-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Date:   Thu, 05 Mar 2015 10:56:20 +1100
In-Reply-To: <CAGXu5j+Pu-xeCBcMZZqTgLfKss7Er0pfCxp04a4eWDWhuDryTQ@mail.gmail.com>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
         <1425341988-1599-5-git-send-email-keescook@chromium.org>
         <1425442601.9084.9.camel@ellerman.id.au>
         <CAGXu5j+Pu-xeCBcMZZqTgLfKss7Er0pfCxp04a4eWDWhuDryTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

On Wed, 2015-03-04 at 13:13 -0800, Kees Cook wrote:
> 
> I had a question in the powerpc-specific change that may have gone unnoticed:
> 
> Can mmap ASLR be safely enabled in the legacy mmap case here? Other archs
> use "mm->mmap_base = TASK_UNMAPPED_BASE + random_factor".
> 
> Separate from this series, do you happen to know if this improvement
> can be made, or if the legacy mmap on powerpc can't handle this?

Yeah I saw that. The short answer is I'm not sure.

I assume we have that distinction for some good reason, but whether we still
need it I don't know. I'll dig a bit and see if anyone can remember the details.

cheers
