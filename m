Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Mar 2015 15:47:19 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:44692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013978AbbCQOrQi3Jae (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Mar 2015 15:47:16 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E19AB580;
        Tue, 17 Mar 2015 07:47:21 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8022D3F265;
        Tue, 17 Mar 2015 07:47:04 -0700 (PDT)
Date:   Tue, 17 Mar 2015 14:47:02 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Ismael Ripoll <iripoll@upv.es>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux390@de.ibm.com" <linux390@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "David A. Long" <dave.long@linaro.org>,
        Andrey Ryabinin <a.ryabinin@samsung.com>,
        Arun Chandran <achandran@mvista.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Min-Hua Chen <orca.chen@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Vineeth Vijayan <vvijayan@mvista.com>,
        Jeff Bailey <jeffbailey@google.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Borislav Petkov <bp@suse.de>,
        Jan-Simon =?iso-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 03/10] arm64: standardize mmap_rnd() usage
Message-ID: <20150317144702.GN8399@arm.com>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
 <1425503454-7531-4-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425503454-7531-4-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: will.deacon@arm.com
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

On Wed, Mar 04, 2015 at 09:10:47PM +0000, Kees Cook wrote:
> In preparation for splitting out ET_DYN ASLR, this refactors the use of
> mmap_rnd() to be used similarly to arm and x86. This additionally enables
> mmap ASLR on legacy mmap layouts, which appeared to be missing on arm64,
> and was already supported on arm. Additionally removes a copy/pasted
> declaration of an unused function.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/include/asm/elf.h |  1 -
>  arch/arm64/mm/mmap.c         | 18 +++++++++++-------
>  2 files changed, 11 insertions(+), 8 deletions(-)

Looks fine to me:

  Acked-by: Will Deacon <will.deacon@arm.com>

Do you want me to pick this up, or are you taking it along with the rest of
your series (it doesn't have any obvious dependencies to me)?

Will
