Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Sep 2005 03:25:37 +0100 (BST)
Received: from webadmin.ru ([IPv6:::ffff:212.119.32.46]:54022 "EHLO
	mail.webadmin.ru") by linux-mips.org with ESMTP id <S8225601AbVICCZU>;
	Sat, 3 Sep 2005 03:25:20 +0100
Received: (qmail 80088 invoked by uid 89); 3 Sep 2005 02:31:44 -0000
Received: from localhost (HELO ?192.168.1.143?) (maxim@kde.ru@127.0.0.1)
  by localhost with SMTP; 3 Sep 2005 02:31:44 -0000
Message-ID: <43190B15.7080301@kde.ru>
Date:	Sat, 03 Sep 2005 06:31:49 +0400
From:	Maxim Moroz <maxim@kde.ru>
User-Agent: Mozilla Thunderbird 1.0.6-1.1am (X11/20050721)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: framebuffer for au1000 based board.
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maxim@kde.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxim@kde.ru
Precedence: bulk
X-list: linux-mips

Hello, I'm writing framebuffer (800x600@16bpp) for au1000 based board 
for latest linux-2.6.13 mips kernel.
video memory is located at address 0xbe00_0000.
The problem is that I cannot correctly mmap video memory to userspace.

mmap was taken from au1500 lcd framebuffer driver(code follows)

start, fbi->fix.smem_start, off are all equal to 0xbe00_0000 (video 
memory start)

mmaping from userspace is working ok, but writing to mmaped memory gives 
no result
on display.

code like memset(0xbe00_0000,0,FB_MEM_SIZE) from kernel space is working 
as expected.

from userspace running test on mmaped fb gives no visible results.

cat /proc/156/maps
00400000-00407000 r-xp 00000000 08:01 27785      /root/fbtest
00446000-00447000 rw-p 00006000 08:01 27785      /root/fbtest
00447000-00449000 rwxp 00447000 00:00 0          [heap]
2aaa8000-2ab93000 rw-s be000000 08:01 17858      /dev/fb0
7fb12000-7fb27000 rwxp 7fb12000 00:00 0          [stack]

Also I have problems with ioremapping:
  //info->screen_base = ioremap(AU1000VLFB_BASE_PHYS, 
AU1000VLFB_FB_LEN); // <-doesn't work when do 'dd if=/dev/zero 
of=/dev/fb0 count=2048'
  info->screen_base = AU1000VLFB_BASE_PHYS; // <- this one clears screen 
when 'dd if=/dev/zero of=/dev/fb0 count=2048'

ioremap gives me 0xc000_0000 from 0xbe00_0000. I'm not sure if this  
correct.

Can't resolve problem myself.
Thank you in advance!
Best Regards, Maxim Moroz.
---------------------------------------

/* fb_mmap
 * Map video memory in user space. We don't use the generic fb_mmap 
method mainly
 * to allow the use of the TLB streaming flag (CCA=6)
 */
int au1000fb_fb_mmap(struct fb_info *fbi, struct file *file, struct 
vm_area_struct *vma)
{
  unsigned int len;
  unsigned long start=0, off;

  if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT)) {
    return -EINVAL;
  }

  start = fbi->fix.smem_start & PAGE_MASK;
  len = PAGE_ALIGN((start & ~PAGE_MASK) + fbi->fix.smem_len);

  off = vma->vm_pgoff << PAGE_SHIFT;

  if ((vma->vm_end - vma->vm_start + off) > len) {
    return -EINVAL;
  }

  off += start;
  vma->vm_pgoff = off >> PAGE_SHIFT;

  vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
  pgprot_val(vma->vm_page_prot) |= (6 << 9); //CCA=6

  vma->vm_flags |= VM_IO;

  printk("%lu %lu %lu %lu %lu\n",
          fbi->fix.smem_start,
          start,
          off,
          vma->vm_start,
          vma->vm_end - vma->vm_start
          );

  if (remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
        vma->vm_end - vma->vm_start,
        vma->vm_page_prot)) {
    return -EAGAIN;
  }

  return 0;
}
