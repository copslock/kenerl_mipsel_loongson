Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2004 16:39:57 +0000 (GMT)
Received: from dfpost.ru ([IPv6:::ffff:194.85.103.225]:44957 "EHLO
	mail.dfpost.ru") by linux-mips.org with ESMTP id <S8225305AbULHQjv>;
	Wed, 8 Dec 2004 16:39:51 +0000
Received: from toch.dfpost.ru (toch.dfpost.ru [192.168.7.60])
	by mail.dfpost.ru (Postfix) with SMTP id A823A3E517
	for <linux-mips@linux-mips.org>; Wed,  8 Dec 2004 19:34:10 +0300 (MSK)
Date: Wed, 8 Dec 2004 19:40:14 +0300
From: Dmitriy Tochansky <toch@dfpost.ru>
To: linux-mips@linux-mips.org
Subject: mmap problem another :)
Message-Id: <20041208194014.1302df6f.toch@dfpost.ru>
Organization: Special Technology Center
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <toch@dfpost.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: toch@dfpost.ru
Precedence: bulk
X-list: linux-mips

Ok. I did as you say and got that mmap func:

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
  
  printk("offset = 0x%X\n",(unsigned int)offset);

  ret = remap_page_range_high (start, offset, size, vma->vm_page_prot);
  
  return ret;
}

And it works fine but... but when I try to do mmap not /dev/mboard0 but /dev/mboard1 Im again
have the "bad" result. :( Is there something specific to mmap several devices?
