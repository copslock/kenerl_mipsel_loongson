Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2004 15:42:46 +0000 (GMT)
Received: from dfpost.ru ([IPv6:::ffff:194.85.103.225]:64388 "EHLO
	mail.dfpost.ru") by linux-mips.org with ESMTP id <S8225242AbULGPml>;
	Tue, 7 Dec 2004 15:42:41 +0000
Received: from toch.dfpost.ru (toch.dfpost.ru [192.168.7.60])
	by mail.dfpost.ru (Postfix) with SMTP id 21ECF3E517
	for <linux-mips@linux-mips.org>; Tue,  7 Dec 2004 18:37:05 +0300 (MSK)
Date: Tue, 7 Dec 2004 18:42:58 +0300
From: Dmitriy Tochansky <toch@dfpost.ru>
To: linux-mips@linux-mips.org
Subject: mmap problem
Message-Id: <20041207184258.071bf401.toch@dfpost.ru>
Organization: Special Technology Center
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <toch@dfpost.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: toch@dfpost.ru
Precedence: bulk
X-list: linux-mips

Hi!
I try to write small driver to make access to pci device resource from 
userland using mmap.
Code below didnt work. :(
From I module in debug I make some testes - I can read from device registers
but after mmap from userspace I reading just part of memory. :(
Some cache?

CPU - au1500

.....

static unsigned long *offset;

static int mdrv_mmap(struct file * file, struct vm_area_struct *vma)                                   
{                                                                                                      
                                                                                                       
 int ret;                                                                                              
 struct inode *inode;                                                                                  
 inode = file->f_dentry->d_inode;                                                                      
 
 ret = -EINVAL;                                                                                        
 unsigned long start = vma->vm_start;                                                                  
 unsigned long size = (vma->vm_end-vma->vm_start);                                                     
 
 offset = ioremap(0x40000000,0x40);
 
 printk("0x%p\n",__pa(offset));


  printk("lb 0x%X\n",offset[ 0x3C>>2 ] );

  vma->vm_flags |= VM_LOCKED;

  printk("+++++0x%X 0x%X\n",start,size);

  vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
                                   
  ret = remap_page_range( start, 0x40000000, size, vma->vm_page_prot ); //0x40000000 is first iomem range of pci device

  return ret;                                                               
}

struct file_operations mdrv_fops = {
  .open = mdrv_open,
  .release = mdrv_close,
  .read = mdrv_read,
  .write = mdrv_write,
  .mmap = mdrv_mmap
};

....


Here is userland 
#include "mdrv.h"
#include <sys/mman.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <linux/kernel.h>
#include <string.h>

int fd,fd2;

int
main ()
{

  fd = open("/dev/mboard0",O_RDWR);
  
  unsigned long *x;
  x = mmap(NULL,64,PROT_READ|PROT_WRITE,MAP_SHARED,fd,0);

  printf("mmap return: 0x%X",x);

  if(x == MAP_FAILED)
  {
   printf(" it is very bad! :(\n");
   perror("mmap:");
   return -1;
  }
 
  printf(" its ok!\n");

  int i;
  for(i=0;i<16;i++)
  {
  printf(" %d = 0x%X\n",i,x[i]);
  }
  munmap(x,64);
  
  return 0;
}
