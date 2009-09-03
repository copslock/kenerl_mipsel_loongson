Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Sep 2009 16:28:11 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.159]:31867 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492730AbZICO2F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Sep 2009 16:28:05 +0200
Received: by fg-out-1718.google.com with SMTP id d23so713112fga.6
        for <multiple recipients>; Thu, 03 Sep 2009 07:28:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=2Mz1fNpKyOuCkvuXUpWr7MH4bQw4fBnydVsXOvmRxKE=;
        b=lF+ZVOkSf/l4coaJq2y2xU7P9bUCSnQ42ODZK14WTua3JAVew4aIGdAE2k4F+EWRM6
         HCDBMPYBhxDlXY0p852cEt8nUsU0dbl76qFpp3VvKyHLKz0q0wDv0jJ/PJJPgYy5Y4xI
         sStgSd0CIyPbKYIXYIOJ8C5wdP/J45krn8qbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=KqD4P4dC3SlUEkaRHFQbgLYaAOkf9QaE5wkhWSQiFOsqPnyIJVEPbMI9DXWGgMDBBR
         O4y2bXCTx6V9zRP+GpZuK8RvEJ2erJ+M4Ac8NmdKK+/Akg7/xlCU+nnED95/3snXs8RD
         fxQaVq7GmcUrE59ZsKGMGKrDMzLSTNiox9szg=
Received: by 10.87.42.14 with SMTP id u14mr3949776fgj.28.1251988084206;
        Thu, 03 Sep 2009 07:28:04 -0700 (PDT)
Received: from desktop ([58.31.9.46])
        by mx.google.com with ESMTPS id l19sm62248fgb.1.2009.09.03.07.27.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Sep 2009 07:27:59 -0700 (PDT)
Date:	Thu, 3 Sep 2009 22:27:53 +0800
From:	Wu Fei <at.wufei@gmail.com>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Shrink the size of tlb handler and fix vmalloc()
Message-ID: <20090903142753.GA6482@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <at.wufei@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: at.wufei@gmail.com
Precedence: bulk
X-list: linux-mips

This patch tries to shrink the size of the 64bit tlb handler and also fix
an vmalloc bug at the same time.

By combining the swapper_pg_dir and module_pg_dir, several checks in tlb
handler, particularly build_get_pgd_vmalloc64, are not necessary. The reason
they can be combined is that, the effective virtual address of vmalloc returned
is at the bottom, and of module_alloc returned is at the top.

In the normal case of 4KB page size:
  VMALLOC_START, VMALLOC_END	0xc0000000 00000000 - 0xc0000100 00000000
  MODULE_START,  MODULE_END	0xffffffff c0000000 - 0xffffffff +xxxxxxx
Change it to:
  VMALLOC_START, VMALLOC_END	0xc0000000 00000000 - 0xc00000ff 00000000
  MODULE_START,  MODULE_END	0xffffffff c0000000 - 0xffffffff +xxxxxxx
We use the least 40 bits to traverse the page table, the change makes it still
one-to-one mapping without more checking. "+" is in the range of [c,d,e,f], 
so there even are big holes bewteen them.

With this patch, the tlb refill handler only contains about 28 instructions,
instead of the original 38.


And this patch also fix a bug in vmalloc, which happens when its returned
address is not covered by the first pgd. e.g. if we do two vmallocs, the first
returned address is 0xc0000000 00000000, and the 2nd is 0xc0000000 40000000,

  vmalloc -> __vmalloc_node -> __vmalloc_area_node -> __vmalloc_area_node
  -> map_vm_area -> pgd_offset_k

pgd_offset_k doesn't use the address to index the pgd, just return the first one:

  #define pgd_offset_k(address) \ 
        ((address) >= MODULE_START ? module_pg_dir : pgd_offset(&init_mm, 0UL))     

This is wrong, then the 2 addresses are mapped to the same pte. This bug doesn't
happen because even in the 4KB page case, one pgd can cover 1GB size, and it looks
like the system won't vmalloc so much area.
