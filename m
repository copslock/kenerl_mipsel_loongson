Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2008 15:15:17 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:47797 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28583623AbYCMPPP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Mar 2008 15:15:15 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2DFFEII021367;
	Thu, 13 Mar 2008 15:15:14 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2DFFDG4021366;
	Thu, 13 Mar 2008 15:15:13 GMT
Date:	Thu, 13 Mar 2008 15:15:13 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"tiejun.chen" <tiejun.chen@windriver.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MT-VPE : Fix the usage of kmalloc
Message-ID: <20080313151513.GA4368@linux-mips.org>
References: <47D8BDDC.9010607@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47D8BDDC.9010607@windriver.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 13, 2008 at 01:38:36PM +0800, tiejun.chen wrote:

> The return value of kmalloc() should be check, otherwise it is potential
> risk.
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  vpe.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> 
> diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
> index c06eb81..35767de 100644
> --- a/arch/mips/kernel/vpe.c
> +++ b/arch/mips/kernel/vpe.c
> @@ -885,6 +885,10 @@ static int vpe_elfload(struct vpe * v)
>         }
>  
>         v->load_addr = alloc_progmem(mod.core_size);
> +#ifndef CONFIG_MIPS_VPE_LOADER_TOM
> +       if (!(v->load_addr))
> +               return -ENOMEM;
> +#endif

Your mailer converted the tabs into whitespace so the patch doesn't apply.

Anyway, I fixed things in a slightly different way which hopefully
avoids throwing in more #ifdefs and will safe a little code for the
!CONFIG_MIPS_VPE_LOADER_TOM case.

Thanks,

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index eed2dc4..39804c5 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -262,13 +262,21 @@ void dump_mtregs(void)
 /* Find some VPE program space  */
 static void *alloc_progmem(unsigned long len)
 {
+	void *addr;
+
 #ifdef CONFIG_MIPS_VPE_LOADER_TOM
-	/* this means you must tell linux to use less memory than you physically have */
-	return pfn_to_kaddr(max_pfn);
+	/*
+	 * This means you must tell Linux to use less memory than you
+	 * physically have, for example by passing a mem= boot argument.
+	 */
+	addr = pfn_to_kaddr(max_pfn);
+	memset(addr, 0, len);
 #else
-	// simple grab some mem for now
-	return kmalloc(len, GFP_KERNEL);
+	/* simple grab some mem for now */
+	addr = kzalloc(len, GFP_KERNEL);
 #endif
+
+	return addr;
 }
 
 static void release_progmem(void *ptr)
@@ -884,9 +892,10 @@ static int vpe_elfload(struct vpe * v)
 	}
 
 	v->load_addr = alloc_progmem(mod.core_size);
-	memset(v->load_addr, 0, mod.core_size);
+	if (!v->load_addr)
+		return -ENOMEM;
 
-	printk("VPE loader: loading to %p\n", v->load_addr);
+	pr_info("VPE loader: loading to %p\n", v->load_addr);
 
 	if (relocate) {
 		for (i = 0; i < hdr->e_shnum; i++) {
