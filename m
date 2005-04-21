Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2005 20:31:45 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.205]:31882 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225327AbVDUTb3> convert rfc822-to-8bit;
	Thu, 21 Apr 2005 20:31:29 +0100
Received: by wproxy.gmail.com with SMTP id 57so734724wri
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2005 12:31:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=D60B2tHUFnS9YzRqJ4ivn/4IMygWRZJNG1ZMcldT2w6Tjxpi0Ls+yUhYCSxW5wMkQ5ZI3PFvD3rNVKTVcIjdsjNpemMvUijFs678fZ61ilxD8zdSky46dLyjWtzrZooxKAPrCDr7gf+MOH9GBQwcUB7qttr9tbaceLaqMKAuO3o=
Received: by 10.54.5.61 with SMTP id 61mr35579wre;
        Thu, 21 Apr 2005 12:31:21 -0700 (PDT)
Received: by 10.54.41.29 with HTTP; Thu, 21 Apr 2005 12:31:21 -0700 (PDT)
Message-ID: <ecb4efd10504211231748d2525@mail.gmail.com>
Date:	Thu, 21 Apr 2005 15:31:21 -0400
From:	Clem Taylor <clem.taylor@gmail.com>
Reply-To: Clem Taylor <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: troubles writing to a mmapped PCI BAR
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

I'm working on a Au1550 driver for a PCI based co-processor. The
driver provides mmap() that allows the mapping of a PCI BAR. From
userspace I can happily read from the mmaped region, but writes just
hang the user space program. gdb shows that the user program is
sitting at the write statement. The read() and write() system calls
work just fine as well.

In the driver mmap() does:
vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
return io_remap_page_range(vma, vma->vm_start,
    barStart + (vma->vm_pgoff << PAGE_SHIFT),
    vma->vm_end - vma->vm_start, vma->vm_page_prot);

The user space program does:
u32 *mem;
fd = open("/dev/moo-0", O_RDWR);
mem = mmap(NULL, 4*1024*1024. PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
...
fprintf(stderr, "mem[42]=0x%08X\n", mem[42]);
mem[42] = 0xDEADBEEF;

When I run the test, it will print the current value of mem[42], then
hang on the write to mem[42]. /proc/pid/maps shows the mmap with rw-s
permissions:
2abd4000-2afd4000 rw-s 00000000 00:09 134        /dev/moo-0
top shows that the test process is consuming ~100% of the CPU.

I'm really at a loss as to what is happening. I'd imagine that the
userspace program is page faulting (not sure how to verify that) and
the fault handler is not returning. Any ideas what I might be missing?

                       Thanks,
                       Clem
