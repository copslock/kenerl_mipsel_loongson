Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2004 07:40:04 +0000 (GMT)
Received: from dfpost.ru ([IPv6:::ffff:194.85.103.225]:38318 "EHLO
	mail.dfpost.ru") by linux-mips.org with ESMTP id <S8225230AbULHHj7>;
	Wed, 8 Dec 2004 07:39:59 +0000
Received: from toch.dfpost.ru (toch.dfpost.ru [192.168.7.60])
	by mail.dfpost.ru (Postfix) with SMTP id 14A6D3E517;
	Wed,  8 Dec 2004 10:34:21 +0300 (MSK)
Date: Wed, 8 Dec 2004 10:40:17 +0300
From: Dmitriy Tochansky <toch@dfpost.ru>
To: Dan Malek <dan@embeddededge.com>
Cc: linux-mips@linux-mips.org
Subject: Re: mmap problem
Message-Id: <20041208104017.2f71acc2.toch@dfpost.ru>
In-Reply-To: <AD0D6ED2-4868-11D9-BB64-003065F9B7DC@embeddededge.com>
References: <20041207184258.071bf401.toch@dfpost.ru>
	<AD0D6ED2-4868-11D9-BB64-003065F9B7DC@embeddededge.com>
Organization: Special Technology Center
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <toch@dfpost.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: toch@dfpost.ru
Precedence: bulk
X-list: linux-mips

On Tue, 7 Dec 2004 10:57:20 -0500
Dan Malek <dan@embeddededge.com> wrote:

> >   ret = remap_page_range( start, 0x40000000, size, vma->vm_page_prot
> >   
> > ); //
> 
> Use io_remap_page_range, it has the same parameters, and is
> designed to work with > 32-bit physical addresses.
  Well, I test it. On module load - unresolved symbol remap_page_range_high. I looking for some ifdefs
where this function blocked, but seems like everithing is ok. :(

> 
> Also, you should really use pci_resource_* functions to get
> information about the pci address, size, etc.  Don't hardcode this,
> even for testing.

There is a new variant. If I by hand make io_remap_page_range visible - system hangs. :(
  

#define MAX_DEV 4

struct pci_dev *devs[MAX_DEV];
struct pci_dev *dev = NULL;

...

static unsigned long *offset;

static int mdrv_mmap(struct file * file, struct vm_area_struct *vma)                                   
{                                                                                                      
                                                                                                       
 int ret;                                                                                              
 struct inode *inode;                                                                                  
 inode = file->f_dentry->d_inode;                                                                      
 
 ret = -EINVAL;                                                                                        
 unsigned long start = vma->vm_start;                                                                  
 unsigned long size = (vma->vm_end-vma->vm_start);                                                     
 
 struct pci_dev *curdev = NULL;
 
 int minor = MINOR(inode->i_rdev);
 
 printk("minor = %d\n",minor);
 
 curdev = (devs[minor]);
 
 offset = (unsigned long *)pci_resource_start(curdev,0);
 
 printk("offset = 0x%X\n", offset );

 ret = io_remap_page_range( start, offset, size, vma->vm_page_prot );

 return ret;                                                               
}
