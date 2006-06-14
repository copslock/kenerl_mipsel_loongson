Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2006 16:23:36 +0100 (BST)
Received: from [62.154.208.154] ([62.154.208.154]:49888 "EHLO
	firewall1.addi-data.de") by ftp.linux-mips.org with ESMTP
	id S8133544AbWFNPXV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Jun 2006 16:23:21 +0100
Received: from [172.16.2.26] (helo=security01.addi-data.intra)
	by firewall1.addi-data.de with esmtp (Exim 4.43)
	id 1FqXD9-0003Sf-12
	for linux-mips@linux-mips.org; Wed, 14 Jun 2006 17:23:15 +0200
Received: from security1.addi-data.de (exchange01.addi-data.intra) by 
    security01.addi-data.intra (Clearswift SMTPRS 5.2.3) with ESMTP id 
    <T78dffa3a91ac10021a1478@security01.addi-data.intra> for 
    <linux-mips@linux-mips.org>; Wed, 14 Jun 2006 17:23:13 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Bigphysarea and MIPS
Date:	Wed, 14 Jun 2006 17:23:13 +0200
Message-ID: <DD0BA80209AFF04091B518EA708D0A0B48A97F@exchange01.addi-data.intra>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Bigphysarea and MIPS
Thread-Index: AcaPxX63590XRhrqQtK/+I7f3/rcjA==
From:	"Francois Beauregard" <Beauregard.Francois@addi-data.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <beauregard.francois@addi-data.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Beauregard.Francois@addi-data.com
Precedence: bulk
X-list: linux-mips

Hello everybody,


it's my first post on the list, so be indulgent, I'm a newbee.
I'm writing a driver using a DMA transfer between on board RAM of a card and a memory ring buffer in kernel space. The processor is a Toshiba Tx49. The PCI controller is a PLX PCI9054 rev AC. It's seems to work fine.
The ring buffer in kernel space is then mmap()'ed in user's space using remap_page_range().
The kernel is a 2.4.22 - bigphys version.


The driver writes the pattern 0123456789 in this ring buffer (as uint32_t), and transfers those data on the on board ram thanks to the DMA (pci->local).
Then I transfer those data into the same ring buffer, but 10 uint32_t further. (local->pci)
So I may read 01234567890123456789.

I have to use a continuous memory ring buffer (about 2MBytes) due to the speed of the card.
That's why I allocated it firstly with bigphysarea patch. (I will describe it later)
As I encountered a problem with this patch, I tried to use pci_alloc_consistent (arch/mips/kernel/pci-dma.c) instead (after I read the O'Reilly Linux Driver book).
With this function, the DMA transfer succeeds (the pattern is ok: 01234567890123456789), but the mmap() call raised a PCI Bus error.
(I have seen in the mailing list that I probably have to modify mk_pte_phys(). Am I wrong?)

Now, my problem with bigphysarea.
The allocation of the ring buffer is done trough bigphysarea_alloc_pages (mm/bigphysarea.c). (I add bigphysarea=[number] as described in the documentation).

After boot, sometimes I read 01234567890000000000. Sometimes 01234567890000000089.
Then the next DMA transfer returns: 01234567890000006789
I tried to pass different flags to bigphysarea_alloc_pages (GFP_ATOMIC|GFP_DMA, GFP_KERNEL|GFP_DMA ...) without success.

I took a look at the source code of the two functions, and I tried to understand the difference, but the code is too dependent on the hardware for my knowledge))-;
pci_alloc_consistent and bigphysarea patch call finally __get_free_pages, but bigphysarea uses kmalloc call whereas pci_alloc_consistent makes some operation with dma_cache_wback_inv.
I know that the flag CONFIG_NONCOHERENT_IO is set.
The addresses of the ring buffer are respectively 0x27820000 and 0x002FA000 with bigphysarea and pci_alloc_consistent.

Are'nt bigphysarea and mips compliant?
How could I solve this problem?
Did anyone succeed with bigphysarea and mips in association?


Thanks a lot.

Regards,





/*this function allocated the ring buffer,with bigphysarea or pci_alloc_consistent
* bigphysarea is a global variable
*/
int alloc_ring_buffer(struct pci_dev *dev, uint32_t number_of_pages)
{
	uint32_t free_mem=0;
	PRIVDATA (dev)->PC_ring_buffer_size=number_of_pages*PAGE_SIZE;

	if (bigphysarea){
		printk("Using Bigphysarea\n");
		bigphysarea_kinfo(&Free_Mem); /*returns the size of avialable memory*/
	
		if (free_mem<number_of_pages*PAGE_SIZE)
			printk("The bigphysarea reserved memory is too short\n");
		else{
			unsigned long size=PRIVDATA (dev)->PC_ring_buffer_size;
			/*pci_alloc_consistent seems to use the flags : GFP_ATOMIC and GFP_DMA*/
			PRIVDATA (dev)->PC_ring_buffer_virt_addr= (uint32_t* )
 			bigphysarea_alloc_pages (number_of_pages,1,/*GFP_ATOMIC|GFP_DMA*/GFP_KERNEL);


			if (PRIVDATA (dev)->PC_ring_buffer_virt_addr) {
				unsigned long adr = (unsigned long)PRIVDATA (dev)->PC_ring_buffer_virt_addr;
				while (size > 0) {
					mem_map_reserve(virt_to_page(phys_to_virt(adr)));
					adr += PAGE_SIZE;
					size -= PAGE_SIZE;
				}
			}

			PRIVDATA (dev)->PC_ring_buffer_bus_addr=virt_to_bus (PRIVDATA (dev)->PC_ring_buffer_virt_addr);
		}
	}else{
		printk("Using pci_alloc_consistent\n");
		free_mem=free_mem;/*remove warning*/

		/*allocation*/
		PRIVDATA (dev)->PC_ring_buffer_virt_addr= pci_alloc_consistent(dev, PRIVDATA (dev)->PC_ring_buffer_size, &PRIVDATA (dev)->PC_ring_buffer_bus_addr);

		/*put a flag to all the allocated pages*/
		if (PRIVDATA (dev)->PC_ring_buffer_virt_addr){
			struct page *page,*end_page;

			/*the last page*/
			end_page=virt_to_page(PRIVDATA (dev)->PC_ring_buffer_virt_addr+PRIVDATA (dev)->PC_ring_buffer_size-1);

			for (page=virt_to_page(PRIVDATA (dev)->PC_ring_buffer_virt_addr);page<=end_page;page++)
				set_bit(PG_reserved,&page->flags);

		}
	}

	if (!(PRIVDATA (dev)->PC_ring_buffer_virt_addr)){
		printk("Can't allocated contiguous memory\n");
 		return -ENOMEM;
	}
	else
		printk("Allocation of the contiguous memory OK\nVirtual Address: %lX\n"\
		"Bus physical Address: %lX\n",(unsigned long)PRIVDATA (dev)->PC_ring_buffer_virt_addr,(unsigned long)PRIVDATA (dev)->PC_ring_buffer_bus_addr);

	memset(PRIVDATA (dev)->PC_ring_buffer_virt_addr,0,number_of_pages*PAGE_SIZE);

	return 0;
}





/*-----------------------------------------------------------/
*                     pci_alloc_consistent
*
/*-----------------------------------------------------------*/
void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
                           dma_addr_t * dma_handle)
{
        void *ret;
        int gfp = GFP_ATOMIC;
        struct pci_bus *bus = NULL;

#ifdef CONFIG_ISA
        if (hwdev == NULL || hwdev->dma_mask != 0xffffffff)
                gfp |= GFP_DMA;
#endif
        ret = (void *) __get_free_pages(gfp, get_order(size));

        if (ret != NULL) {
                memset(ret, 0, size);
                if (hwdev)
                        bus = hwdev->bus;
                *dma_handle = bus_to_baddr(bus, __pa(ret));
#ifdef CONFIG_NONCOHERENT_IO
                dma_cache_wback_inv((unsigned long) ret, size);
                ret = UNCAC_ADDR(ret);
#endif
        }

        return ret;
}

/*-----------------------------------------------------------/
*                     bigphysarea_alloc_pages
*
/*-----------------------------------------------------------*/


caddr_t bigphysarea_alloc_pages(int count, int align, int priority)
{
        range_t *range, **range_ptr, *new_range, *align_range;
        caddr_t aligned_base;

        if (init_level < 2)
                if (init2(priority))
                        return 0;
        new_range   = NULL;
        align_range = NULL;

        if (align == 0)
                align = PAGE_SIZE;
        else
                align = align * PAGE_SIZE;
        /*
         * Search a free block which is large enough, even with alignment.
         */
        range_ptr = &free_list;
        while (*range_ptr != NULL) {
                range = *range_ptr;
                aligned_base =
                  (caddr_t)((((unsigned long)range->base + align - 1) / align) * align);
                if (aligned_base + count * PAGE_SIZE <=
                    range->base + range->size)
                        break;
             range_ptr = &range->next;
        }
        if (*range_ptr == NULL)
                return 0;
        range = *range_ptr;
        /*
         * When we have to align, the pages needed for alignment can
         * be put back to the free pool.
         * We check here if we need a second range data structure later
         * and allocate it now, so that we don't have to check for a
         * failed kmalloc later.
         */
        if (aligned_base - range->base + count * PAGE_SIZE < range->size) {
                new_range = kmalloc(sizeof(range_t), priority);
                if (new_range == NULL)
                        return NULL;
        }
        if (aligned_base != range->base) {
                align_range = kmalloc(sizeof(range_t), priority);
                if (align_range == NULL) {
                        if (new_range != NULL)
                                kfree(new_range);
                        return NULL;
                }
                align_range->base = range->base;
                align_range->size = aligned_base - range->base;
                range->base = aligned_base;
                range->size -= align_range->size;
                align_range->next = range;
                *range_ptr = align_range;
                range_ptr = &align_range->next;
        }
        if (new_range != NULL) {
                /*
                 * Range is larger than needed, create a new list element for
                 * the used list and shrink the element in the free list.
                 */
                new_range->base        = range->base;
                new_range->size        = count * PAGE_SIZE;
                range->base = new_range->base + new_range->size;
                range->size = range->size - new_range->size;
        } else {
                /*
                 * Range fits perfectly, remove it from free list.
                 */
                *range_ptr = range->next;
                new_range = range;
        }
        /*
         * Insert block into used list
         */
        new_range->next = used_list;
        used_list = new_range;

        return new_range->base;
}









**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote confirms that this email message has been scanned for 
the presence of computer viruses.
**********************************************************************
