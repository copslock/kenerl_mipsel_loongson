Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2006 19:57:59 +0000 (GMT)
Received: from vweb.sina.net ([202.108.3.191]:42231 "EHLO vweb.sina.net")
	by ftp.linux-mips.org with ESMTP id S8133732AbWAKT5k (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Jan 2006 19:57:40 +0000
Received: (qmail 21488 invoked by uid 99); 11 Jan 2006 20:00:35 -0000
Message-ID: <20060111200035.21487.qmail@sina.com>
From:	yzzhang@sy-imatec.com
To:	linux-mips@linux-mips.org
CC:	linux-cvs@linux-mips.org
Subject: au1200 mae mmap problem
Date:	Thu, 12 Jan 2006 04:00:35 +0800
X-Mailer: SinaMail(3.0)
X-Priority: 3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-Path: <yzzhang@sy-imatec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yzzhang@sy-imatec.com
Precedence: bulk
X-list: linux-mips

I wrote a simple program to test Au1200 MAE.
The result is always that program will return -1 because pmms->struct_size=0, though it is assigned
a value of 0xdc during initialization in the kernel.
anyone could explain the reason for me? Thanks in advance. 
-----------------------------------------------------------------------
In user space:
  if ((fmae = open("/dev/mae", O_RDWR)) < 0) {
        printf("mae open failed.\n");
        return -1;
    }
 gMemSize = ioctl(fmae, AU1XXXMAE_INIT, &ioc);
 maeaddr = mmap (0, gMemSize, PROT_READ|PROT_WRITE, MAP_SHARED | MAP_NONCACHED, fmae, 0);
 if (maeaddr == MAP_FAILED)
    {
        printf("mae: attempt to map memory failed.\n");
        return -1;
    }
 pmms = (PMAE_MASTER_T)maeaddr;
 if (pmms->struct_size < sizeof(MAE_MASTER_T))
    {
      printf("mae_driver, structure size mismatch: driver=%x interface=%d\n",pmms->struct_size, sizeof(MAE_MASTER_T));
        return -1;
    }

-----------------------------------------------------------------------------------------
In kernel space,au1200's driver is listed as below: 

int au1xxxmae_mmap(struct file *filp, struct vm_area_struct *vma ) 
{
    unsigned long size = vma->vm_end - vma->vm_start;
    unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
    offset += mae_phys_address;
    vma->vm_page_prot = pgprot_cached(vma->vm_page_prot);    
    if(remap_pfn_range(vma, vma->vm_start, offset >> PAGE_SHIFT, size, vma->vm_page_prot))    
    {
         DBGPRINT(ERRORS,"Could not remap the page range\n");
         return -EFAULT;
    }

    vma->vm_flags &= ~VM_IO;
    vma->vm_ops = &au1xxx_vmaops;
    au1xxx_vma_open(vma);
    return 0;
}

void init_mae_structs(void) 
{
    unsigned char k,x[10];

    pmms = (PMAE_MASTER_T) KRNL_MAE_MASTER_STRUCT; // pmms means ptr to mae master struct
    // initialize the master structure
    memset((PVOID)KRNL_MAE_MASTER_STRUCT, 0, sizeof(MAE_MASTER_T));
    pmms->struct_size=sizeof(MAE_MASTER_T);   //pmms->struct_size = 0xdc
    ... ... 
}
