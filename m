Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 14:54:07 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:738 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022394AbXIDNx6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Sep 2007 14:53:58 +0100
Received: from localhost (p7110-ipad205funabasi.chiba.ocn.ne.jp [222.146.102.110])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 22469D7AB; Tue,  4 Sep 2007 22:52:36 +0900 (JST)
Date:	Tue, 04 Sep 2007 22:54:02 +0900 (JST)
Message-Id: <20070904.225402.106261140.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: flush_kernel_dcache_page() not needed ?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <46DD53BE.2070004@gmail.com>
References: <46DC29F0.3060200@gmail.com>
	<20070904.005400.52128244.anemo@mba.ocn.ne.jp>
	<46DD53BE.2070004@gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 04 Sep 2007 14:46:54 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > Indeed.  But copy_strings() is not rare case (called on each execve),
> > so there might be some constraints which make us free from the
> > aliasing problem.
> 
> The point is that this _generic_ function has been created so we need
> to understand if MIPS architecture needs to implement it or not,
> whatever its current usages. This was actually what I was trying to
> understand with this thread.
> 
> Whatever the constraints, they don't seem to be intended at all since
> flush_kernel_dcache_page() is called... So even if the current code is
> working fine, it seems very fragile _if_ MIPS needs to implement this
> cache helper.

Yes, agreed.

> > I'll look at it further, but any testcase are welcome.

I found the reason.

do_execve()
  copy_strings()
    flush_kernel_dcache_page()
  search_binary_handler()
    load_elf_binary()
      setup_arg_pages()
        shift_arg_pages()
          move_page_tables()
            flush_cache_range()

And MIPS flush_cache_range() blasts whole dcache!  That's why empty
flush_kernel_dcache_page() was enough for now.  

Anyway, here is a patch.


Subject: [MIPS] Implement flush_kernel_dcache_page()

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/cacheflush.h b/include/asm-mips/cacheflush.h
index 4933b49..82e734d 100644
--- a/include/asm-mips/cacheflush.h
+++ b/include/asm-mips/cacheflush.h
@@ -79,6 +79,13 @@ extern void (*flush_icache_all)(void);
 extern void (*local_flush_data_cache_page)(void * addr);
 extern void (*flush_data_cache_page)(unsigned long addr);
 
+#define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+static inline void flush_kernel_dcache_page(struct page *page)
+{
+	if (cpu_has_dc_aliases)
+		flush_data_cache_page((unsigned long)page_address(page));
+}
+
 /*
  * This flag is used to indicate that the page pointed to by a pte
  * is dirty and requires cleaning before returning it to the user.
