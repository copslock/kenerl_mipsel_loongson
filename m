Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7SHHd229477
	for linux-mips-outgoing; Tue, 28 Aug 2001 10:17:39 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7SHHRd29471
	for <linux-mips@oss.sgi.com>; Tue, 28 Aug 2001 10:17:28 -0700
Received: from ginger.sonytel.be (ginger.sonytel.be [10.34.16.6])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id TAA23540
	for <linux-mips@oss.sgi.com>; Tue, 28 Aug 2001 19:17:25 +0200 (MET DST)
Received: (from tea@localhost)
	by ginger.sonytel.be (8.9.3+Sun/8.9.3) id TAA01286
	for linux-mips@oss.sgi.com; Tue, 28 Aug 2001 19:17:25 +0200 (MEST)
X-Authentication-Warning: ginger.sonytel.be: tea set sender to tea@sonycom.com using -f
Date: Tue, 28 Aug 2001 19:17:25 +0200
From: Tom Appermont <tea@sonycom.com>
To: linux-mips@oss.sgi.com
Subject: shared memory
Message-ID: <20010828191725.A1221@sonycom.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Howdy,

Attached are two files (shmm.c and test.c). The first is a simple
implementation of a kernel module that allocates RAM for sharing
memory with a user space application. The second file implements
a simple test to verify that the shared buffer behaves as 
expected, by writing something in shared memory and requesting
the module to check if what was written by the application is 
also visible in kernel space. 

While this works as expected on PC, it does not at all work as
expected on my mips platform (R5231): What is written in user
space is not immediately visible in kernel space. This is with
very recent kernel sources (2.4.8) but the same problem exists
with an older (2.4.5) kernel.

There have been a few mails about mmap() problems in the last 
couple of months, but with very little interesting response. Is 
this a known problem or am I stupidly overlooking something?


Greetz,

Tom



--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="shmm.c"

#ifndef __KERNEL__
#  define __KERNEL__
#endif
#ifndef MODULE
#  define MODULE
#endif

#include <linux/config.h>
#include <linux/module.h>
#include <linux/init.h>

#include <linux/kernel.h>
#include <linux/malloc.h>
#include <linux/fs.h>
#include <linux/errno.h>
#include <linux/types.h>
#include <linux/mm.h>
#include <asm/system.h> 
#include <asm/atomic.h>
#include <asm/uaccess.h>

static int major;
static volatile int* shb;
static unsigned int order;

static ssize_t
shmm_write(struct file* file, char* buffer, size_t length, loff_t *offset)
{
    int i;
    copy_from_user(&i, buffer, sizeof(int)); 
    if (i != *shb) {
	printk("counter = %d, *shb = %d\n", i, *shb);
    }
    return sizeof(int);
}

static inline pgprot_t pgprot_noncached(pgprot_t _prot)
{
#ifdef CONFIG_MIPS
    unsigned long prot = pgprot_val(_prot);   
    prot = (prot & ~_CACHE_MASK) | _CACHE_UNCACHED;
    return __pgprot(prot);
#endif
}


static struct page *
shmm_vm_nopage(struct vm_area_struct *vma,
               unsigned long address,
               int write_access)
{
    unsigned long         physical;
    unsigned long         offset;
    struct page*          pageptr;

    if (address > vma->vm_end) return NOPAGE_SIGBUS; 
    offset   = address - vma->vm_start;
    physical = (unsigned long)shb + offset;
    pageptr = virt_to_page(physical);
 
    vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

    atomic_inc(&pageptr->count); 
    return pageptr;
}

struct vm_operations_struct shmm_vm_ops = {
    nopage:  shmm_vm_nopage
};

static int
shmm_mmap(struct file *file, struct vm_area_struct *vma)
{
  unsigned long vsize     = vma->vm_end - vma->vm_start;
  unsigned long npages    = vsize / PAGE_SIZE;

  order = 0;
  while ((1 << order) < npages) order++;
  npages = 1 << order;
  printk("npages requested = %d, order = %d\n", npages, order);
  shb = (int*)__get_dma_pages(GFP_KERNEL, order);
  if (0 == shb) {
    return -ENOMEM;
  }

  memset(shb,0,npages * PAGE_SIZE);

  vma->vm_ops = &shmm_vm_ops;
  vma->vm_flags |=  VM_LOCKED | VM_SHM; 
  
  return 0;
}


static struct file_operations shmm_fops = {
  write:          shmm_write,
  mmap:           shmm_mmap
};
 
static int shmm_init(void)
{
  /* Dynamically allocate major number.
   * cat /proc/devices to get number in userland.
   */
  major = register_chrdev(0, "shmm", &shmm_fops);
  if (major < 0) {
    printk("register_chrdev() failed.\n");
    return major;
  }

  return  0;
}
 
static void shmm_cleanup(void)
{
  unregister_chrdev(major,"shmm");
}
 
module_init(shmm_init);
module_exit(shmm_cleanup);


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test.c"

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <errno.h>
 
 
int main(void)
{
  int shmm;
  volatile int counter = 0;
  volatile int* address;

  shmm = open("/dev/shmm", O_RDWR);
  if (shmm < 0) {
    printf("File not found\n");
    return 1;
  }
 
  address = mmap(0, getpagesize(), PROT_WRITE | PROT_READ,
                 MAP_PRIVATE , shmm, 0);
 
  if (address == (void *)-1) {
      printf(stderr,"mmap(): %s\n",strerror(errno));
      exit(1);
  }

  while(1) {
    *address = counter;
    write(shmm, &counter, sizeof(counter));
    counter++;
  }

  munmap((void*)address,getpagesize());
  close(shmm);
}

--Kj7319i9nmIyA2yE--
