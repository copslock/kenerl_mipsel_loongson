Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2008 18:07:10 +0000 (GMT)
Received: from po-out-1718.google.com ([72.14.252.157]:30328 "EHLO
	po-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S23137098AbYKDSHI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Nov 2008 18:07:08 +0000
Received: by po-out-1718.google.com with SMTP id c31so11775433poi.4
        for <linux-mips@linux-mips.org>; Tue, 04 Nov 2008 10:07:06 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=LuSTCn46vx9vZ69A92ghltP0Fu5ByPodJ5t3d3Gw37U=;
        b=fl5nPcSAyMiLjTSzYR91pc/lW+MUGt3+2h/xLMj2IJwoSC3wh04MvTQ2oDikyjwJBI
         u+EZwAW48J+R8II9ZcxSxHbcknnuNaU7eXooX5L04FbHFTZ1CHb3lHCAbHQSLpciihsD
         LrE7Crkv2ABJaqoZtJV8zhKLGURENl5kBPWKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=fEcsgXUfvZPK/qYKWjHBlEtX28hjEx9Y48jzjgH6pgWQNvyDyZ/fJNui5DZzZDdLoq
         nHpDw4Pycf2fSDXeyoJBD0EXkonCfNIpNmruSEDa9AhJ5js+WMqRPSC87GAsQ4aJJ3l3
         lQH7SY6kJugKFwSgRbFkVQSDwRl8ELnXfSVoQ=
Received: by 10.114.94.12 with SMTP id r12mr1108694wab.122.1225822026049;
        Tue, 04 Nov 2008 10:07:06 -0800 (PST)
Received: by 10.114.190.3 with HTTP; Tue, 4 Nov 2008 10:07:05 -0800 (PST)
Message-ID: <ff8dda500811041007u78bbb496m2c65be7d3486e114@mail.gmail.com>
Date:	Tue, 4 Nov 2008 13:07:05 -0500
From:	"Lance Richardson" <lance604@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.24][MIPS]Work in progress: fix HIGHMEM-enabled dcache flushing on 32-bit processor
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <lance604@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lance604@gmail.com
Precedence: bulk
X-list: linux-mips

I've been working with this patch on an SB1250 (configured for 32-bit
due to some
non-technical constraints).  I have tracked down the cause of a crash that only
occurs with SMP enabled, and wondered there might be a better approach than
the one I took for fixing it.

The crash scenario involves one CPU having an atomic mapping of type KM_USER0
in use when the other CPU happens to call r4k_flush_cachee_page(),
which in turn
calls r4k_on_each_cpu() for local_r4k_flush_cache_page().  The original CPU is
interrupted (still with an active KM_USER0 mapping),
local_r4k_flush_cache_page()
is called, and in the process another KM_USER0 mapping is attempted (and fails
in flames.)

The diffs below (against 2.6.26.1) appear to have eliminated this
problem - does this
make sense, and is there a better way?

     Lance

Index: linux26/arch/mips/mm/c-r4k.c
===================================================================
RCS file: /export/cvsroot/exos/linux26/arch/mips/mm/Attic/c-r4k.c,v
retrieving revision 1.1.4.1
diff -u -r1.1.4.1 c-r4k.c
--- linux26/arch/mips/mm/c-r4k.c	9 Sep 2008 20:25:44 -0000	1.1.4.1
+++ linux26/arch/mips/mm/c-r4k.c	4 Nov 2008 14:46:17 -0000
@@ -436,6 +436,7 @@
 	struct vm_area_struct *vma;
 	unsigned long addr;
 	unsigned long pfn;
+        __u32         cpu;
 };

 static inline void local_r4k_flush_cache_page(void *args)
@@ -452,6 +453,12 @@
 	pmd_t *pmdp;
 	pte_t *ptep;
 	void *vaddr;
+        enum km_type kmtype;
+
+        if (fcp_args->cpu == smp_processor_id())
+                kmtype = KM_USER0;
+        else
+                kmtype = KM_FLUSH_CACHE_PAGE;

 	/*
 	 * If ownes no valid ASID yet, cannot possibly have gotten
@@ -485,7 +492,7 @@
 		if (map_coherent)
 			vaddr = kmap_coherent(page, addr);
 		else
-			vaddr = kmap_atomic(page, KM_USER0);
+			vaddr = kmap_atomic(page, kmtype);
 		addr = (unsigned long)vaddr;
 	}

@@ -508,7 +515,7 @@
 		if (map_coherent)
 			kunmap_coherent();
 		else
-			kunmap_atomic(vaddr, KM_USER0);
+			kunmap_atomic(vaddr, kmtype);
 	}
 }

@@ -520,6 +527,7 @@
 	args.vma = vma;
 	args.addr = addr;
 	args.pfn = pfn;
+        args.cpu = smp_processor_id();

 	r4k_on_each_cpu(local_r4k_flush_cache_page, &args, 1, 1);
 }
Index: linux26/include/asm-mips/kmap_types.h
===================================================================
RCS file: /export/cvsroot/exos/linux26/include/asm-mips/Attic/kmap_types.h,v
retrieving revision 1.1.4.1
diff -u -r1.1.4.1 kmap_types.h
--- linux26/include/asm-mips/kmap_types.h	10 Sep 2008 12:48:21 -0000	1.1.4.1
+++ linux26/include/asm-mips/kmap_types.h	4 Nov 2008 14:46:19 -0000
@@ -22,7 +22,8 @@
 D(10)	KM_IRQ1,
 D(11)	KM_SOFTIRQ0,
 D(12)	KM_SOFTIRQ1,
-D(13)	KM_TYPE_NR
+D(13)	KM_FLUSH_CACHE_PAGE,
+D(14)	KM_TYPE_NR
 };

 #undef D
