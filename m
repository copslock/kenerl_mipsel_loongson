Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 15:03:38 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:33435
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994823AbeCIOC1p5KVM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 15:02:27 +0100
Received: by mail-wm0-x242.google.com with SMTP id s206so3610766wme.0
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2018 06:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bFC+dOL1kofLW/Fz0q3F9Mambpm3ECJQAGpTBpsRBqY=;
        b=KlhatkzHSpgVRHDvB7Xo8ArpzJdEHpIrp8YwbhdYo36/+atn/MwbTUVLka2ecwucpk
         zBkNsc/ZMMJC76qRsNG3L0OoPeCXCuFE7Kwg/k6sQTOci9s0Te+5aqQGcaddiMIp8+48
         cotuP8JIMQkN1iOw5U/gZASe/hLxJgyCR6kF8N6NJqAioxDCKZAMC5XrY+pSXPTrP1hG
         ymOU5dlpgdVaUvbvPpc5rS+PJ/C75VxYJYfyyyQFf8mKnfu4cQY9WZaCPo5Cs73J1Qcw
         jX3tqNstWDM+vhRI5hDVJ//BT12ne/5yFiHKvWzTjTCQMbeyPVZJVe1wN4cmr/5fq4d4
         o+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bFC+dOL1kofLW/Fz0q3F9Mambpm3ECJQAGpTBpsRBqY=;
        b=Y5qCFkPGi2ewhTkngZy6qjAdswLgTvtwwRUFmmeFzzC0UXCOa87hmcYfv+8fnSpotu
         b5yNTCv3Z3tkuPhuGUhVywpWet1/PXTMESlJxXhlCHynu1UaXTTfQ8PCyMm68nX6HLvA
         Pp7K6TM84VWGq1HLHzEmU1vTHdXsA4q3XnVI3Y1lKCBKfXx1SAO5HbZqbGPm0FSP96vk
         k5HTW6UAbZNqO33py1Q/qEskh7BR4D8H10uH0zeFZd+awC/SirxqWDWsCJ5mjo+Z8Gaq
         6mF2txazP7eaBvQw+xmijEaFaMDwtE6jN5fxbm/JU0jGWJw6c7cQw8f32FepyEPhkxXa
         2aiA==
X-Gm-Message-State: AElRT7HP27MO3+gBWp6XMb4g+giB/pyCygGuBaaXo7LKEIkFvEGtesBJ
        HlrT02o3K6p+cPbqanKtueL3Dw==
X-Google-Smtp-Source: AG47ELur63iUzTcj/SxULK7/n9/IiOYomFoFueFSfoU9XvqGgqC5/NqRiMXXZBMSOAU5srV8yEvX2w==
X-Received: by 10.28.230.68 with SMTP id d65mr2300974wmh.13.1520604141250;
        Fri, 09 Mar 2018 06:02:21 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id f3sm994484wre.72.2018.03.09.06.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 06:02:20 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <jhogan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-am33-list@redhat.com, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [RFC PATCH 4/6] mm, arm64: untag user addresses in mm/gup.c
Date:   Fri,  9 Mar 2018 15:02:02 +0100
Message-Id: <becebff594deda3a5881e64a21bf405f030991ad.1520600533.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <cover.1520600533.git.andreyknvl@google.com>
References: <cover.1520600533.git.andreyknvl@google.com>
In-Reply-To: <cover.1520600533.git.andreyknvl@google.com>
References: <cover.1520600533.git.andreyknvl@google.com>
Return-Path: <andreyknvl@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreyknvl@google.com
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

mm/gup.c provides a kernel interface that accepts user addresses and
manipulates user pages directly (for example get_user_pages, that is used
by the futex syscall). Here we also need to handle the case of tagged user
pointers.

Untag addresses passed to this interface.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/gup.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 1b46e6e74881..4d820c4792d7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -386,6 +386,8 @@ struct page *follow_page_mask(struct vm_area_struct *vma,
 	struct page *page;
 	struct mm_struct *mm = vma->vm_mm;
 
+	address = untagged_addr(address);
+
 	*page_mask = 0;
 
 	/* make this handle hugepd */
@@ -647,6 +649,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 	if (!nr_pages)
 		return 0;
 
+	start = untagged_addr(start);
+
 	VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
 
 	/*
@@ -801,6 +805,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	int ret, major = 0;
 
+	address = untagged_addr(address);
+
 	if (unlocked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 
@@ -854,6 +860,8 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 	long ret, pages_done;
 	bool lock_dropped;
 
+	start = untagged_addr(start);
+
 	if (locked) {
 		/* if VM_FAULT_RETRY can be returned, vmas become invalid */
 		BUG_ON(vmas);
@@ -1746,6 +1754,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	unsigned long flags;
 	int nr = 0;
 
+	start = untagged_addr(start);
+
 	start &= PAGE_MASK;
 	addr = start;
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
@@ -1798,6 +1808,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	unsigned long addr, len, end;
 	int nr = 0, ret = 0;
 
+	start = untagged_addr(start);
+
 	start &= PAGE_MASK;
 	addr = start;
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
-- 
2.16.2.395.g2e18187dfd-goog
