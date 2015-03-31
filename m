Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 21:40:18 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:50422 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014858AbbCaTkQM3wYt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 21:40:16 +0200
Received: from [10.172.68.52]
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <kamal@canonical.com>)
        id 1Yd21E-0000Ms-Ni; Tue, 31 Mar 2015 19:40:13 +0000
Message-ID: <1427830809.32761.6.camel@fourier>
Subject: Re: [3.13.y-ckt stable] Patch "MIPS: Export FP functions used by
 lose_fpu(1) for KVM" has been added to staging queue
From:   Kamal Mostafa <kamal@canonical.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, kernel-team@lists.ubuntu.com
Date:   Tue, 31 Mar 2015 12:40:09 -0700
In-Reply-To: <20150331190803.GD9457@jhogan-linux.le.imgtec.org>
References: <1427827603-26295-1-git-send-email-kamal@canonical.com>
         <20150331190803.GD9457@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

On Tue, 2015-03-31 at 20:08 +0100, James Hogan wrote:
> Hi Kamal,
> 
> On Tue, Mar 31, 2015 at 11:46:43AM -0700, Kamal Mostafa wrote:
> > This is a note to let you know that I have just added a patch titled
> > 
> >     MIPS: Export FP functions used by lose_fpu(1) for KVM
> > 
> > to the linux-3.13.y-queue branch of the 3.13.y-ckt extended stable tree 
> > which can be found at:
> > 
> >  http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.13.y-queue
> > 
> > This patch is scheduled to be released in version 3.13.11-ckt18.
> > 
> > If you, or anyone else, feels it should not be added to this tree, please 
> > reply to this email.
> > 
> > For more information about the 3.13.y-ckt tree, see
> > https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable
> > 
> > Thanks.
> > -Kamal
> > 
> > ------
> > 
> > From 7adee277d64254de602234e7e53691d729f5e50c Mon Sep 17 00:00:00 2001
> > From: James Hogan <james.hogan@imgtec.com>
> > Date: Tue, 10 Feb 2015 10:02:59 +0000
> > Subject: MIPS: Export FP functions used by lose_fpu(1) for KVM
> > 
> > commit 3ce465e04bfd8de9956d515d6e9587faac3375dc upstream.
> > 
> > Export the _save_fp asm function used by the lose_fpu(1) macro to GPL
> > modules so that KVM can make use of it when it is built as a module.
> > 
> > This fixes the following build error when CONFIG_KVM=m due to commit
> > f798217dfd03 ("KVM: MIPS: Don't leak FPU/DSP to guest"):
> > 
> > ERROR: "_save_fp" [arch/mips/kvm/kvm.ko] undefined!
> > 
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Fixes: f798217dfd03 (KVM: MIPS: Don't leak FPU/DSP to guest)
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@imgtec.com>
> > Cc: Gleb Natapov <gleb@kernel.org>
> > Cc: kvm@vger.kernel.org
> > Cc: linux-mips@linux-mips.org
> > Patchwork: https://patchwork.linux-mips.org/patch/9260/
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> > Signed-off-by: Kamal Mostafa <kamal@canonical.com>
> > ---
> >  arch/mips/kernel/mips_ksyms.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
> > index 6e58e97..60adf79 100644
> > --- a/arch/mips/kernel/mips_ksyms.c
> > +++ b/arch/mips/kernel/mips_ksyms.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/mm.h>
> >  #include <asm/uaccess.h>
> >  #include <asm/ftrace.h>
> > +#include <asm/fpu.h>
> > 
> >  extern void *__bzero(void *__s, size_t __count);
> >  extern long __strncpy_from_user_nocheck_asm(char *__to,
> > @@ -26,6 +27,11 @@ extern long __strnlen_user_nocheck_asm(const char *s);
> >  extern long __strnlen_user_asm(const char *s);
> > 
> >  /*
> > + * Core architecture code
> > + */
> > +EXPORT_SYMBOL_GPL(_save_fp);
> 
> Before v3.16 this will cause a build error with cavium_octeon_defconfig.
> I submitted an updated stable patch for v3.10, v3.12, and v3.14, which
> should be suitable for v3.13 too. See:
> https://marc.info/?l=linux-mips&m=142557178417268&w=2

Okay, replaced this in 3.13-stable with your backport.  Thanks very
much, James!

 -Kamal


> Cheers
> James
> 
> > +
> > +/*
> >   * String functions
> >   */
> >  EXPORT_SYMBOL(memset);
> > --
> > 1.9.1
> > 
