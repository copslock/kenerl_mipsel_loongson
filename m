Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 14:38:36 +0100 (CET)
Received: from phoenix.mvhi.com ([195.224.96.167]:24838 "EHLO
	phoenix.infradead.org") by linux-mips.org with ESMTP
	id <S8225221AbSLKNif>; Wed, 11 Dec 2002 14:38:35 +0100
Received: from hch by phoenix.infradead.org with local (Exim 4.10)
	id 18M74J-00051X-00; Wed, 11 Dec 2002 13:38:31 +0000
Date: Wed, 11 Dec 2002 13:38:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: ilya@theIlya.com
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: O2 VICE support
Message-ID: <20021211133831.A19300@infradead.org>
References: <20021210191120.GE609@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021210191120.GE609@gateway.total-knowledge.com>; from ilya@theIlya.com on Tue, Dec 10, 2002 at 11:11:20AM -0800
Return-Path: <hch@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@infradead.org
Precedence: bulk
X-list: linux-mips


On Tue, Dec 10, 2002 at 11:11:20AM -0800, ilya@theIlya.com wrote:
> RCS file: /home/cvs/linux/arch/mips64/kernel/ioctl32.c,v
> retrieving revision 1.26
> diff -u -r1.26 ioctl32.c
> --- arch/mips64/kernel/ioctl32.c	12 Nov 2002 15:26:11 -0000	1.26
> +++ arch/mips64/kernel/ioctl32.c	10 Dec 2002 17:02:29 -0000
> @@ -55,6 +57,10 @@
>  
>  #include <linux/rtc.h>
>  
> +#ifdef CONFIG_O2_VICE
> +#include <linux/vice.h>
> +#endif

Just include the header unconditionally.

>  static int w_long(unsigned int fd, unsigned int cmd, unsigned long arg)
> @@ -827,6 +968,12 @@
>  COMPATIBLE_IOCTL(TIOCGSERIAL)
>  COMPATIBLE_IOCTL(TIOCSSERIAL)
>  COMPATIBLE_IOCTL(TIOCSERGETLSR)
> +#ifdef CONFIG_O2_VICE
> +COMPATIBLE_IOCTL(VICE_IOCTL_MAP_DMA)
> +COMPATIBLE_IOCTL(VICE_IOCTL_MSP_RUN)
> +COMPATIBLE_IOCTL(VICE_IOCTL_BSP_RUN)
> +COMPATIBLE_IOCTL(VICE_IOCTL_DO_DMA)
> +#endif

Dito.  COMPATIBLE_IOCTL() isn't a big burgden, so it doesn't harm to get
rid of the ifdefs.

> +source drivers/char/o2vice/Kconfig

I think it should be in drivers/media/vice (i.e. it's one of the media
devices, and I don't think you need the o2, especially as you don't
use it e.g. in the header name).

> --- /dev/null	Sun Jul 17 16:46:18 1994
> +++ drivers/char/o2vice/Makefile	Thu Sep 12 00:12:16 2002
> @@ -0,0 +1,21 @@
> +#
> +# drivers/char/o2vice/Makefile
> +#
> +# Makefile for the O2 VICE Engine driver.
> +#
> +
> +SUB_DIRS     := 
> +MOD_SUB_DIRS := $(SUB_DIRS)
> +ALL_SUB_DIRS := $(SUB_DIRS)
> +
> +#O_TARGET := vice.o
> +
> +obj-y		:=
> +obj-m		:=
> +obj-n		:=
> +obj-		:=

This is 2.2 crap.  Just get rid of it..

> +
> +obj-$(CONFIG_O2_VICE)	+= main.o msp.o bsp.o dma.o
> +#obj-$(CONFIG_O2_VICE_DBG) += vicedebug.o
> +
> +include $(TOPDIR)/Rules.make

The include isn't needed anymore either in 2.5.

> +#include <linux/ioctl.h> /* needed for the _IOW etc stuff used later */
> +#ifdef __KERNEL__
> +#include <asm/pci.h>
> +#endif
> +#include <linux/types.h>	/* size_t */
> +
> +#ifndef __KERNEL__
> +typedef __u64 u64;
> +typedef __u32 u32;
> +typedef __u16 u16;
> +#endif /* __KERNEL */

Urgg.  Usually kernel headers aren't supposed to be used in userspace.
If you want to use a copy anyway it should be done with much less burden
on the kernel code.

> +#ifdef VICE_DEBUG
> +# define DPRINTK(fmt, args...) printk( KERN_DEBUG "vice: " fmt, ## args)
> +#else
> +# define DPRINTK(fmt, args...) /* not debugging: nothing */
> +#endif
> +
> +#define PDEBUG DPRINTK

Just use pr_debug?

> +
> +#ifndef VICE_MAJOR
> +#define VICE_MAJOR 240   /* dynamic major by default */
> +#endif

Comment doesn't match code.

> +/*
> + * Prototypes for shared functions
> + */
> +ssize_t vice_read (struct file *filp, char *buf, size_t count,
> +                    loff_t *f_pos);
> +ssize_t vice_write (struct file *filp, const char *buf, size_t count,
> +                     loff_t *f_pos);
> +loff_t  vice_llseek (struct file *filp, loff_t off, int whence);
> +int     vice_ioctl (struct inode *inode, struct file *filp,
> +                     unsigned int cmd, unsigned long arg);

Exported file operations are usually a very bad sign.  But it looks like
you could just make them static anyway :)

> +/*
> + * VICE ioctl commands
> + */
> +#ifdef __KERNEL__
> +#define VICE_IOCTL_MAGIC	0x96
> +#define VICE_IOCTL_MAP_DMA	_IOR(VICE_IOCTL_MAGIC,1,unsigned long)
> +#define VICE_IOCTL_MSP_RUN	_IOR(VICE_IOCTL_MAGIC,2,msp_run)
> +#define VICE_IOCTL_BSP_RUN	_IOR(VICE_IOCTL_MAGIC,3,bsp_run)
> +#define VICE_IOCTL_DO_DMA	_IOWR(VICE_IOCTL_MAGIC,4,dma_run)
> +#else
> +#define VICE_IOCTL_MAP_DMA	0x40089601
> +#define VICE_IOCTL_MSP_RUN	0x400c9602
> +#define VICE_IOCTL_BSP_RUN	0x400c9603
> +#define VICE_IOCTL_DO_DMA	0xc00c9604
> +#endif

Ummm..

> +static inline int vice_dma_mem_init(vice_dev *vice)
> +{
> +    int i;
> +    for (i=0; i<64*2;i++){
> +	if(!(vice->dma_kmem[i]=pci_alloc_consistent(0,VICE_PAGE_SIZE,&(vice->dma_mem[i])))) {
> +	    DPRINTK("failed at page# %i\n",i);
> +    	    return -ENOMEM;
> +	}
> +    }
> +    return 0;

Please adopt to Documentation/CodingStyle

> +    DPRINTK("Falling asleep\n");
> +    while(vice->msp_status==VICE_RES_STATUS_INPROGRESS) {
> +        interruptible_sleep_on(&wq);

sleep_on is racy.  You should at least use wait_even, but it doesn't look
like vice->msp_status is atomically updated anyway.

> --- /dev/null	Sun Jul 17 16:46:18 1994
> +++ drivers/char/o2vice/Makefile	Thu Sep 12 00:12:16 2002

The diff seems to include the same hunk twice..

> +/* In vice_open, the fop_array is used according to TYPE(dev) */
> +int vice_open(struct inode *inode, struct file *filp)
> +{
> +    vice_dev *vice=vice_device;		/* device information */
> +    int res;
> +
> +    MOD_INC_USE_COUNT;		/* Before we maybe sleep */

Please set .owner in the file_operations instead.

> +
> +    if(vice->is_open)
> +	return -EBUSY;

This seems pretty racy.

> +
> +    if (!filp->private_data) {
> +	filp->private_data = vice_device;
> +    }

filp->private_data can't be set.

> +ssize_t vice_read(struct file * filp, char *buf, size_t count, loff_t * f_pos)
> +{
> +    printk(KERN_WARNING
> +	   "Processing bit streams through reading/writing is not supported yet\n");
> +    return -ENOSYS;
> +}
> +
> +ssize_t vice_write(struct file * filp, const char *buf, size_t count,
> +	   loff_t * f_pos)
> +{
> +    printk(KERN_WARNING
> +	   "Processing bit streams through reading/writing is not supported (yet)\n");
> +    return -ENOSYS;
> +}

What about just not implementing the methods instead?

> +static void vice_vma_open(struct vm_area_struct *vma)
> +{ MOD_INC_USE_COUNT; }
> +
> +static void vice_vma_close(struct vm_area_struct *vma)
> +{ MOD_DEC_USE_COUNT; }

This is silly.  You get a reference for vma->vm_file as long as you
have any mmaps.  That's enough for the refcounting.

> +static struct vm_operations_struct vice_vm_ops = {
> +    open:  vice_vma_open,
> +    close: vice_vma_close,
> +    nopage: vice_vma_nopage,
> +};

Please use C99-initializers (i.e. .foo = bar)

> +void vice_cleanup_module(void)
> +{
> +#ifndef CONFIG_DEVFS_FS
> +    /* cleanup_module is never called if registering failed */
> +    unregister_chrdev(vice_major, "vice");
> +#endif

Umm, just because someone makes the mistake of enabling devfs he
doesn't have to use it.. :)

> +#ifndef VICE_DEBUG
> +    EXPORT_NO_SYMBOLS;		/* otherwise, leave global symbols visible */
> +#endif

EXPORT_NO_SYMBOLS is a noop on 2.5
