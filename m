Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f42KmOr29338
	for linux-mips-outgoing; Wed, 2 May 2001 13:48:24 -0700
Received: from boco.fee.vutbr.cz (boco.fee.vutbr.cz [147.229.9.11])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f42KmMF29320
	for <linux-mips@oss.sgi.com>; Wed, 2 May 2001 13:48:22 -0700
Received: from fest.stud.fee.vutbr.cz (fest.stud.fee.vutbr.cz [147.229.9.16])
	by boco.fee.vutbr.cz (8.11.3/8.11.3) with ESMTP id f42KmJc67694
	(using TLSv1/SSLv3 with cipher EDH-RSA-DES-CBC3-SHA (168 bits) verified OK)
	for <linux-mips@oss.sgi.com>; Wed, 2 May 2001 22:48:20 +0200 (CEST)
Received: (from xmichl03@localhost)
	by fest.stud.fee.vutbr.cz (8.11.2/8.11.2) id f42KmJa91989;
	Wed, 2 May 2001 22:48:19 +0200 (CEST)
From: Michl Ladislav <xmichl03@stud.fee.vutbr.cz>
Date: Wed, 2 May 2001 22:48:19 +0200 (CEST)
X-processed: pine.send
To: <linux-mips@oss.sgi.com>
Subject: VINO - enabling DMA
Message-ID: <Pine.BSF.4.33.0105022139370.85671-100000@fest.stud.fee.vutbr.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

when writing Linux VINO driver i followed documentation found at:
ftp://oss.sgi.com/pub/linux/mips/doc/indy/vino/vino.ps

shortly (if someone is interested, i can send whole code):
/* array of allocated pages */
unsigned long *pages;
/* same as above, but contains physical addresses */
unsigned long *buf_desc;

/* i hope page starts at 4k boundary ;) */
/* i also know that GFP_DMA is useless for MIPS */
buf_desc = (unsigned long *) __get_free_pages(GFP_KERNEL | GFP_DMA, 0);
pages = (unsigned long*) kmalloc(npage *
         sizeof(unsigned long), GFP_KERNEL));
for (i = 0; i < npage; i++) {
	pages[i] = __get_free_pages(GFP_KERNEL | GFP_DMA, 0);
	/* fill with something to see if vino writes data */
	memset((void *) pages[i], i, PAGE_SIZE);
	/* virt_to_bus returns PHYSADDR */
	buf_desc[i] = virt_to_bus((void *)pages[i]);
	mem_map_reserve(virt_to_page(pages[i]));
}
buf_desc[npage] = VINO_DESC_STOP;
/* here set all things according doc (page_index to zero and so on...)
...
/* write descriptor table pointer to vino */
vino_reg_write(virt_to_bus(buf_desc), VINO_A_DESC_TLB_PTR);
vino_reg_write(virt_to_bus(buf_desc), VINO_A_DESC_PTR);
/* and now start DMA */
vino_reg_or(VINO_CTRL_A_DMA_ENBL, VINO_CTRL);

after that memory stays untouched, no data are trasferred. any ideas how
to make DMA working? or better where to get more complete vino
documentation?

regards,
ladislav michl
