Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 07:12:48 +0100 (BST)
Received: from rex.securecomputing.com ([203.24.151.4]:37074 "EHLO
	cyberguard.com.au" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S20024522AbZETGMm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 07:12:42 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by bne.snapgear.com (Postfix) with ESMTP id 00F65EBBAF
	for <linux-mips@linux-mips.org>; Wed, 20 May 2009 16:12:33 +1000 (EST)
X-Virus-Scanned: amavisd-new at snapgear.com
Received: from bne.snapgear.com ([127.0.0.1])
	by localhost (bne.snapgear.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KAFJVWiC5k4O for <linux-mips@linux-mips.org>;
	Wed, 20 May 2009 16:12:33 +1000 (EST)
Received: from [10.46.12.2] (unknown [10.46.12.2])
	by bne.snapgear.com (Postfix) with ESMTP
	for <linux-mips@linux-mips.org>; Wed, 20 May 2009 16:12:33 +1000 (EST)
Message-ID: <4A139F50.7050409@snapgear.com>
Date:	Wed, 20 May 2009 16:12:32 +1000
From:	Greg Ungerer <gerg@snapgear.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: system lockup with 2.6.29 on Cavium/Octeon
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <gerg@snapgear.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gerg@snapgear.com
Precedence: bulk
X-list: linux-mips


Hi All,

I have a system lockup problem that I have been looking at on a custom
Cavium/Octeon 5010 based design. I am running on linux-2.6.29 with
David Daney's latest round of PCI and ethernet patches (posted here
on this list).

I have tracked the problem back to local_flush_tlb_kernel_range() in
arch/mips/mm/tlb-r4k.c. At the top of this function is:

     void local_flush_tlb_kernel_range(unsigned long start, unsigned 
long end)
     {
         unsigned long flags;
         int size;

         ENTER_CRITICAL(flags);
         size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
         size = (size + 1) >> 1;
         if (size <= current_cpu_data.tlbsize / 2) {

The problem is that typical example values I see passed in for start
and end are:

     start = c000000000006000
     end   = ffffffffc01d8000

Now the vmalloc area starts at 0xc000000000000000 and the kernel code
and data is all at 0xffffffff80000000 and above. I don't know if the
start and end are reasonable values, but I can see some logic as to
where they come from. The code path that leads to this is via
__vunmap() and __purge_vmap_area_lazy(). So it is not too difficult
to see how we end up with values like this.

But the size calculation above with these types of values will result
in still a large number. Larger than the 32bit "int" that is "size".
I see large negative values fall out as size, and so the following
tlbsize check becomes true, and the code spins inside the loop inside
that if statement for a _very_ long time trying to flush tlb entries.

This is of course easily fixed, by making that size "unsigned long".
The patch below trivially does this.

But is this analysis correct?

Regards
Greg




The address range size calculation inside local_flush_tlb_kernel_range()
is being truncated by a too small size variable holder on 64bit systems.
The truncated size can result in an erroneous tlbsize check that means
we sit spinning inside a loop trying to flush a hige number of TLB
entries. This is for all intents and purposes a system hang. Fix by
using an appropriately sized valiable to hold the size.

Signed-off-by: Greg Ungerer <gerg@snapgear.com>

---

--- ORG.linux-2.6.29/arch/mips/mm/tlb-r4k.c.org	2009-05-20 
15:30:28.000000000 +1000
+++ ORG.linux-2.6.29/arch/mips/mm/tlb-r4k.c	2009-05-20 
15:30:56.000000000 +1000
@@ -161,7 +161,7 @@ void local_flush_tlb_range(struct vm_are
  void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
  {
  	unsigned long flags;
-	int size;
+	unsigned long size;

  	ENTER_CRITICAL(flags);
  	size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
