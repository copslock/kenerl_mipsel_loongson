Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Dec 2004 07:51:39 +0000 (GMT)
Received: from dfpost.ru ([IPv6:::ffff:194.85.103.225]:55223 "EHLO
	mail.dfpost.ru") by linux-mips.org with ESMTP id <S8225208AbULNHvd>;
	Tue, 14 Dec 2004 07:51:33 +0000
Received: from toch.dfpost.ru (toch.dfpost.ru [192.168.7.60])
	by mail.dfpost.ru (Postfix) with SMTP id C8B243E4AC
	for <linux-mips@linux-mips.org>; Tue, 14 Dec 2004 10:45:17 +0300 (MSK)
Date: Tue, 14 Dec 2004 10:51:54 +0300
From: Dmitriy Tochansky <toch@dfpost.ru>
To: linux-mips@linux-mips.org
Subject: Re: mmap problem another :)
Message-Id: <20041214105154.2bed14df.toch@dfpost.ru>
In-Reply-To: <AC350838-49EF-11D9-A745-003065F9B7DC@embeddededge.com>
References: <20041209161207.39140f0d.toch@dfpost.ru>
	<AC350838-49EF-11D9-A745-003065F9B7DC@embeddededge.com>
Organization: Special Technology Center
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <toch@dfpost.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: toch@dfpost.ru
Precedence: bulk
X-list: linux-mips

On Thu, 9 Dec 2004 09:36:11 -0500
Dan Malek <dan@embeddededge.com> wrote:

> Read the memory mapping docuemntation and understand the APIs.
> All of the Linux mapping functions, whether mmap() from an application
> or in the kernel are going to align on page boundaries.
> 
> The address of 0x40002040 is going to be aligned to a page boundary,
> so you have to consider the offset into that page to the base of the
> device, plus the register offset.  The kernel mapping functions,
> like remap_page_range, are going to force the alignment because
> that is what we expect in the kernel.  An mmap() with an unaligned
> address will generate an error.
  Ok. I understand. But still havent fun. :(
Yes, Im assume that offset if pagealligned:

static int
mdrv_mmap (struct file *file, struct vm_area_struct *vma)
{
  unsigned long offset = 0;
  int ret;
  struct inode *inode;
  inode = file->f_dentry->d_inode;
  struct pci_dev *curdev = NULL;
  int minor = MINOR (inode->i_rdev);
  printk("minor = 0x%X\n",minor);
  curdev = (devs[minor]);
  unsigned long start = vma->vm_start;
  unsigned long size = (vma->vm_end - vma->vm_start);
  offset = pci_resource_start (curdev, IOMEM0);
  offset &= PAGE_MASK;
  printk("start= 0x%X offset = 0x%X size=0x%X\n",start, (unsigned int)offset, (unsigned int) size);
  ret = remap_page_range_high(start, offset, size, vma->vm_page_prot);
  return ret;
}

 This code, AFAIK will return me a pointer to begin of page where my ioaddr is. ?

 Then in my testcode I compensate shift by adding it to addr:

---

#include "mdrv.h"
#include <sys/mman.h>
#include <stdio.h>
#include <fcntl.h>

#define MMAP_SIZE 0x40

int fd, fd2;

int
main ()
{

  fd = open ("/dev/mboard1", O_RDWR);

  unsigned long *x;

  x = mmap (NULL, MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

  printf ("mmap return: 0x%X", x);

  if (x == MAP_FAILED)
    {
      printf (" it is very bad! :(\n");
      perror ("mmap:");
      return -1;
    }

  printf (" its ok!\n");
  
  printf("x = 0x%X\n",x);

#define CONS 0
//0x2040 >> 2
  
  x += CONS;
  
  printf("x = 0x%X\n",x);
  unsigned long m = 0xEF;
  
  printf("m = 0x%X\n",m);
  
  //printf ("%p\n", x[(0x3C)>>2]); //We have to get 0xE6 here
  
  m = x[(0x40>>2)+(0x3C>>2)];
  
  printf("m = 0x%p\n", m);
  
  x -= CONS;  
  
  munmap (x, MMAP_SIZE);
  close(fd);
  
  return 0;
}

---

DEbug output shows that mmap - success. I get pointer and size = 0x1000(one page). Then
I try to read m from board register. BTW, if I just read apps finishing but when I try to output
to console(as in src) "m" programm hangs.

Have no idea what the ... is goin on. Some hints please.
