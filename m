Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Sep 2016 12:24:49 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39960 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991232AbcIZKYmY020z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Sep 2016 12:24:42 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u8QAOdZG005062;
        Mon, 26 Sep 2016 12:24:39 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u8QAOcRI005061;
        Mon, 26 Sep 2016 12:24:38 +0200
Date:   Mon, 26 Sep 2016 12:24:38 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     kbuild test robot <fengguang.wu@intel.com>
Cc:     James Hogan <james.hogan@imgtec.com>, kbuild-all@01.org,
        linux-mips@linux-mips.org
Subject: Re: [mips-sjhill:mips-for-linux-next 58/62]
 arch/mips/kernel/uprobes.c:304:15: error: variable or field 'kstart'
 declared void
Message-ID: <20160926102437.GB12981@linux-mips.org>
References: <201609240204.arLAdO5Z%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201609240204.arLAdO5Z%fengguang.wu@intel.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sat, Sep 24, 2016 at 02:06:11AM +0800, kbuild test robot wrote:

> From: kbuild test robot <fengguang.wu@intel.com>
> To: James Hogan <james.hogan@imgtec.com>
> Cc: kbuild-all@01.org, linux-mips@linux-mips.org, Ralf Baechle
>  <ralf@linux-mips.org>
> Subject: [mips-sjhill:mips-for-linux-next 58/62]
>  arch/mips/kernel/uprobes.c:304:15: error: variable or field 'kstart'
>  declared void
> Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
> 
> tree:   git://git.linux-mips.org/pub/scm/sjhill/linux-sjhill.git mips-for-linux-next
> head:   3cd97a2d95ac84bf17d4d538960d3e17585a791c
> commit: a0b7ccb92e7b57f3c4cf5bf8a875fe7ecf00fe2c [58/62] MIPS: uprobes: Flush icache via kernel address
> config: mips-allmodconfig (attached as .config)
> compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout a0b7ccb92e7b57f3c4cf5bf8a875fe7ecf00fe2c
>         # save the attached .config to linux build tree
>         make.cross ARCH=mips 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    arch/mips/kernel/uprobes.c: In function 'arch_uprobe_copy_ixol':
> >> arch/mips/kernel/uprobes.c:304:15: error: variable or field 'kstart' declared void
>      void *kaddr, kstart;
>                   ^~~~~~
> >> arch/mips/kernel/uprobes.c:308:9: warning: assignment makes integer from pointer without a cast [-Wint-conversion]
>      kstart = kaddr + (vaddr & ~PAGE_MASK);
>             ^
> >> arch/mips/kernel/uprobes.c:309:9: warning: passing argument 1 of 'memcpy' makes pointer from integer without a cast [-Wint-conversion]
>      memcpy(kstart, src, len);
>             ^~~~~~
>    In file included from include/linux/string.h:18:0,
>                     from include/linux/bitmap.h:8,
>                     from include/linux/cpumask.h:11,
>                     from arch/mips/include/asm/processor.h:15,
>                     from arch/mips/include/asm/thread_info.h:15,
>                     from include/linux/thread_info.h:54,
>                     from include/asm-generic/preempt.h:4,
>                     from ./arch/mips/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:59,
>                     from include/linux/spinlock.h:50,
>                     from include/linux/wait.h:8,
>                     from include/linux/fs.h:5,
>                     from include/linux/highmem.h:4,
>                     from arch/mips/kernel/uprobes.c:1:
>    arch/mips/include/asm/string.h:138:14: note: expected 'void *' but argument is of type 'int'
>     extern void *memcpy(void *__to, __const__ void *__from, size_t __n);
>                  ^~~~~~
> 
> vim +/kstart +304 arch/mips/kernel/uprobes.c
> 
>    298				*(uprobe_opcode_t *)&auprobe->orig_inst[0].word);
>    299	}
>    300	
>    301	void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>    302					  void *src, unsigned long len)
>    303	{
>  > 304		void *kaddr, kstart;
>    305	
>    306		/* Initialize the slot */
>    307		kaddr = kmap_atomic(page);
>  > 308		kstart = kaddr + (vaddr & ~PAGE_MASK);
>  > 309		memcpy(kstart, src, len);
>    310		flush_icache_range(kstart, kstart + len);
>    311		kunmap_atomic(kaddr);
>    312	}

Something like below patch should do the trick.  James?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/kernel/uprobes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
index 9a507ab..a896417 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -301,14 +301,14 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 				  void *src, unsigned long len)
 {
-	void *kaddr, kstart;
+	unsigned long kaddr, kstart;
 
 	/* Initialize the slot */
-	kaddr = kmap_atomic(page);
+	kaddr = (unsigned long)kmap_atomic(page);
 	kstart = kaddr + (vaddr & ~PAGE_MASK);
-	memcpy(kstart, src, len);
+	memcpy((void *)kstart, src, len);
 	flush_icache_range(kstart, kstart + len);
-	kunmap_atomic(kaddr);
+	kunmap_atomic((void *)kaddr);
 }
 
 /**
