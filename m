Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 May 2004 07:53:07 +0100 (BST)
Received: from mail.ict.ac.cn ([IPv6:::ffff:159.226.39.4]:48788 "HELO
	mail.ict.ac.cn") by linux-mips.org with SMTP id <S8225733AbUEMGxF>;
	Thu, 13 May 2004 07:53:05 +0100
Received: (qmail 30892 invoked from network); 13 May 2004 06:41:15 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.188)
  by mail.ict.ac.cn with SMTP; 13 May 2004 06:41:15 -0000
Message-ID: <40A31B45.7060204@ict.ac.cn>
Date: Thu, 13 May 2004 14:52:53 +0800
From: wuming <wuming@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: problems on D-cache alias in 2.4.22
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Return-Path: <wuming@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuming@ict.ac.cn
Precedence: bulk
X-list: linux-mips

 I am developing in linux-2.4.22 on the machine with virtual address
indexed and physical
address tagged. But when I compile some application programs, I met the
following error:

cc1: internal compiler error: Segmentation fault

I have searched about this error from internet, it's due to some
hardware fault or
a wrong pte fault handler. Because my machine have D-cache aliasing, so
I think
this error should be due to a wrong pte fault handler. After my painful
kernel hacking,
I found some strange problems and it's in function __update_cache( ):

void __update_cache(struct vm_area_struct *vma, unsigned long address,
pte_t pte)
{
unsigned long addr;
struct page *page;

if (!cpu_has_dc_aliases)
return;

page = pte_page(pte);

/*This printk is added by myself*/
printk("<1>valid page:%d\tpage mapping:0x%p\tpage flags:%d\n",\
VALID_PAGE(page), page->mapping, (page->flags & (1UL << PG_dcache_dirty)));

if (VALID_PAGE(page) && page->mapping &&
(page->flags & (1UL << PG_dcache_dirty))) {
if (pages_do_alias((unsigned long) page_address(page), address &
PAGE_MASK)) {
addr = (unsigned long) page_address(page);
flush_data_cache_page(addr);
}
ClearPageDcacheDirty(page);
}
}

When my kernel is running, I found the condition "page->mapping" and
"(page->flags & (1UL << PG_dcache_dirty))"
will never be true at the same time. so the function
flush_data_cache_page( ) will never be called.
Then I commented the two condition, the compiler error disappeared.
I do not understand the phenomenon very clearly, so I need some help.
