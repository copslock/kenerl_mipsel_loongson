Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 May 2013 08:36:48 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:38945 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817667Ab3ERGgnZX4NJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 18 May 2013 08:36:43 +0200
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4I6aY2Y010572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 18 May 2013 02:36:35 -0400
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r4I6aYZX013694;
        Sat, 18 May 2013 02:36:34 -0400
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id 27A641336CE; Sat, 18 May 2013 09:36:33 +0300 (IDT)
Date:   Sat, 18 May 2013 09:36:33 +0300
From:   Gleb Natapov <gleb@redhat.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Sanjay Lal <sanjayl@kymasys.com>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, ralf@linux-mips.org, mtosatti@redhat.com
Subject: Re: [PATCH] KVM/MIPS32: Export min_low_pfn.
Message-ID: <20130518063633.GC12957@redhat.com>
References: <n>
 <1368824818-22503-1-git-send-email-sanjayl@kymasys.com>
 <5196A458.7080400@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5196A458.7080400@gmail.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Return-Path: <gleb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gleb@redhat.com
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

On Fri, May 17, 2013 at 02:42:48PM -0700, David Daney wrote:
> On 05/17/2013 02:06 PM, Sanjay Lal wrote:
> >The KVM module uses the standard MIPS cache management routines, which use min_low_pfn.
> >This creates and indirect dependency, requiring min_low_pfn to be exported.
> >
> >Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
> >---
> >  arch/mips/kernel/mips_ksyms.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> >diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
> >index 6e58e97..0299472 100644
> >--- a/arch/mips/kernel/mips_ksyms.c
> >+++ b/arch/mips/kernel/mips_ksyms.c
> >@@ -14,6 +14,7 @@
> >  #include <linux/mm.h>
> >  #include <asm/uaccess.h>
> >  #include <asm/ftrace.h>
> >+#include <linux/bootmem.h>
> >
> >  extern void *__bzero(void *__s, size_t __count);
> >  extern long __strncpy_from_user_nocheck_asm(char *__to,
> >@@ -60,3 +61,8 @@ EXPORT_SYMBOL(invalid_pte_table);
> >  /* _mcount is defined in arch/mips/kernel/mcount.S */
> >  EXPORT_SYMBOL(_mcount);
> >  #endif
> >+
> >+/* The KVM module uses the standard MIPS cache functions which use
> >+ * min_low_pfn, requiring it to be exported.
> >+ */
> >+EXPORT_SYMBOL(min_low_pfn);
> 
> I think I asked this before, but I don't remember the answer:
> 
> Why not put EXPORT_SYMBOL(min_low_pfn) in mm/bootmem.c adjacent to
> where the symbol is defined?
> 
He did answered here:
http://permalink.gmane.org/gmane.comp.emulators.kvm.devel/109895.

I suggested mips_ksyms.c solution as an option.

> Cluttering up the kernel with multiple architectures all doing
> architecture specific exports of the same symbol is not a clean way
> of doing things.
> 
> The second time something needs to be done, it should be factored
> out into common code.
> 
Exports are different. You define interface between the kernel and modules
here, exporting the symbol may not be desirable for some arch. And 
min_low_pfn is not the only example. Anything in arch _ksyms files is like that:
exported by some archs but not the others. 

--
			Gleb.
