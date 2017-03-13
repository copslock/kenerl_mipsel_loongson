Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2017 23:16:59 +0100 (CET)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:35547
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994231AbdCMWOsRL0Km (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2017 23:14:48 +0100
Received: by mail-wr0-x243.google.com with SMTP id u108so21795058wrb.2;
        Mon, 13 Mar 2017 15:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w1PmDJLan+xfSF/rM9imHbrliay2fd7B6HTp+CfyaRo=;
        b=lBWkLxsHgVY0ngzVkbZiPlFp3j10nEh7hc9XvgJQ+S5b6T7tpcUDHGAlngomo+JBN1
         qrbpMiXdm6pwyA02aBpEz0GM6hIx1cSm2NFC5O87STigFLhTJV3sgH2sr/ebac0H4Yln
         QmEt3s53BvSZ6r9I1YMPLR48Vpszu8Fxv0Sv7gFspAmi5CBNHIY0pYb17aQgcGzereIR
         ZFJL4RNiJ27IUwMtQQsxo4AZPDNrhi1iMH0uEnt61yIWJzUJf1CLgsZMNkgqEdZFGubS
         CKxkHEO0+fQ7zl9SDi+iE3w+lmYVqQ7TadF9zX01jDJ2YE2SQ8FijxZZHa/HV9pBo9gj
         EyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w1PmDJLan+xfSF/rM9imHbrliay2fd7B6HTp+CfyaRo=;
        b=gKTko2368RljLs40sTAtAI7Exo82j9yLwr90GZiuEDONGDCusCjgNGAjApKvlUmvoq
         RD/Q7f6E3PBg5+6ctWjEc2l2yumAqJ+fA7Bx+F47FMHSMYMXsmt5DRooGnXBotefClUt
         SgdW60VCt5j8xEs+7haVbEYFa7CNMo9Rd109Ypojf1niL+GN7lZ0D4+5UFGYMYauuvbB
         7InLvW8d19uASx8cffoIH0My4U3MleWdDedJabaEh8gi9VbF/CqxkbU6Jdyb9F+opXaN
         bDIzGVN3T/VjpmjQCu6TSiNiu+XYu5kNzgnhUJ5pujK8her/+cKOmh4Lf4ma4ZN4seSQ
         xgqw==
X-Gm-Message-State: AMke39kcXA6S3HdqlEiz2DlYs45n1JU6oEhFHJ5aS/BgpXZ272FvpEONs6xQYBz0spzCxQ==
X-Received: by 10.223.160.231 with SMTP id n36mr34046585wrn.167.1489443282992;
        Mon, 13 Mar 2017 15:14:42 -0700 (PDT)
Received: from localhost (login1.zih.tu-dresden.de. [141.76.16.140])
        by smtp.googlemail.com with ESMTPSA id w4sm12834302wmg.25.2017.03.13.15.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Mar 2017 15:14:42 -0700 (PDT)
From:   Till Smejkal <till.smejkal@googlemail.com>
X-Google-Original-From: Till Smejkal <till.smejkal@gmail.com>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Steven Miao <realmz6@gmail.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-mm@kvack.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [RFC PATCH 06/13] mm/mmap: Export 'vma_link' and 'find_vma_links' to mm subsystem
Date:   Mon, 13 Mar 2017 15:14:08 -0700
Message-Id: <20170313221415.9375-7-till.smejkal@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170313221415.9375-1-till.smejkal@gmail.com>
References: <20170313221415.9375-1-till.smejkal@gmail.com>
Return-Path: <till.smejkal@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: till.smejkal@googlemail.com
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

Make the functions 'vma_link' and 'find_vma_links' accessible to other
source files in the mm/ source directory of the kernel so that other files
in that directory can also perform low level changes to mm_struct data
structures.

Signed-off-by: Till Smejkal <till.smejkal@gmail.com>
---
 mm/internal.h | 11 +++++++++++
 mm/mmap.c     | 12 ++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 7aa2ea0a8623..e22cb031b45b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -76,6 +76,17 @@ static inline void set_page_refcounted(struct page *page)
 extern unsigned long highest_memmap_pfn;
 
 /*
+ * in mm/mmap.c
+ */
+extern void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
+		     struct vm_area_struct *prev, struct rb_node **rb_link,
+		     struct rb_node *rb_parent);
+extern int find_vma_links(struct mm_struct *mm, unsigned long addr,
+			  unsigned long end, struct vm_area_struct **pprev,
+			  struct rb_node ***rb_link,
+			  struct rb_node **rb_parent);
+
+/*
  * in mm/vmscan.c:
  */
 extern int isolate_lru_page(struct page *page);
diff --git a/mm/mmap.c b/mm/mmap.c
index 3f60c8ebd6b6..d35c6b51cadf 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -466,9 +466,9 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
 
-static int find_vma_links(struct mm_struct *mm, unsigned long addr,
-		unsigned long end, struct vm_area_struct **pprev,
-		struct rb_node ***rb_link, struct rb_node **rb_parent)
+int find_vma_links(struct mm_struct *mm, unsigned long addr,
+		   unsigned long end, struct vm_area_struct **pprev,
+		   struct rb_node ***rb_link, struct rb_node **rb_parent)
 {
 	struct rb_node **__rb_link, *__rb_parent, *rb_prev;
 
@@ -580,9 +580,9 @@ __vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
 }
 
-static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct vm_area_struct *prev, struct rb_node **rb_link,
-			struct rb_node *rb_parent)
+void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
+	      struct vm_area_struct *prev, struct rb_node **rb_link,
+	      struct rb_node *rb_parent)
 {
 	struct address_space *mapping = NULL;
 
-- 
2.12.0
