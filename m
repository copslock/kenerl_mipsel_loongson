Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Mar 2004 17:08:59 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:28622 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225598AbUCORI5>; Mon, 15 Mar 2004 17:08:57 +0000
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1B2va7-000790-00
	for <linux-mips@linux-mips.org>; Mon, 15 Mar 2004 11:08:51 -0600
Message-ID: <4055E320.8080808@realitydiluted.com>
Date: Mon, 15 Mar 2004 12:08:48 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] [RFC] r4k_dma_cache_wback_inv function fails when size=0...
Content-Type: multipart/mixed;
 boundary="------------010605080001030505010809"
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010605080001030505010809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greetings.

The 'r4k_dma_cache_wback_inv' function will fail when the requested
size equals 0 AND when the address is a multiple of the line size. I
discovered this bug while using the National Semiconductor DP8381x
series PCI ethernet driver. I have attached a test program showing
the bug as well as a patch for comment. Okay to apply?

-Steve

--------------010605080001030505010809
Content-Type: text/x-c;
 name="test-faulty-inv.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test-faulty-inv.c"

/*
 * Test program for faulty 'r4k_dma_cache_wback_inv' routine where
 * calculated end address can be incorrect when the size = 0.
 *
 * Copyright (C) 2004 TimeSys Corp.
 *                    S. James Hill (James.Hill@timesys.com)
 *                                  (sjhill@realitydiluted.com)
 *
 *  This program is free software; you can redistribute it and/or modify it
 *  under the terms of the GNU General Public License as published by the
 *  Free Software Foundation; either version 2 of the License, or (at your
 *  option) any later version.
 *
 *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
 *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
 *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
 *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  675 Mass Ave, Cambridge, MA 02139, USA.
 */
#include <stdio.h>

int main (void)
{
	unsigned long addr, a, end;
	unsigned int size, line_size;

	/*
	 * Choose an arbitrary test start address and ending address
	 * (not the calculated end address).
	 */
	for (addr = 0x803e4000; addr < 0x803e8000; addr+=4)
	{
		/*
		 * We assume cache line sizes are always a multiple
		 * of 16 bytes.
		 */
		line_size = 16;
		//line_size = 32;
		{
			/*
			 * We try all 4-byte aligned sizes up to
			 * the size of a page.
			 */
			for (size = 0; size < 4096; size+=4)
			{
				a = addr & ~(line_size - 1);
				end = (addr + size - 1) & ~(line_size - 1);
				if (end < a)
					printf("FAIL: a=0x%08lx, end=0x%08lx,"
						"line_size=%i, size=%i\n",
						a, end, line_size, size);
			}
		}
	}

	return 0;
}

--------------010605080001030505010809
Content-Type: text/x-patch;
 name="c-r4k-faulty-wback-inv.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="c-r4k-faulty-wback-inv.patch"

Index: c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.3.2.67
diff -d -u -r1.3.2.67 c-r4k.c
--- c-r4k.c	5 Mar 2004 02:47:11 -0000	1.3.2.67
+++ c-r4k.c	15 Mar 2004 17:03:29 -0000
@@ -482,7 +482,7 @@
 		}
 
 		a = addr & ~(sc_lsize - 1);
-		end = (addr + size - 1) & ~(sc_lsize - 1);
+		end = (addr + size + sc_lsize - 1) & ~(sc_lsize - 1);
 		while (1) {
 			flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
 			if (a == end)
@@ -504,7 +504,7 @@
 
 		R4600_HIT_CACHEOP_WAR_IMPL;
 		a = addr & ~(dc_lsize - 1);
-		end = (addr + size - 1) & ~(dc_lsize - 1);
+		end = (addr + size + dc_lsize - 1) & ~(dc_lsize - 1);
 		while (1) {
 			flush_dcache_line(a);	/* Hit_Writeback_Inv_D */
 			if (a == end)
@@ -529,7 +529,7 @@
 		}
 
 		a = addr & ~(sc_lsize - 1);
-		end = (addr + size - 1) & ~(sc_lsize - 1);
+		end = (addr + size + sc_lsize - 1) & ~(sc_lsize - 1);
 		while (1) {
 			flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
 			if (a == end)
@@ -546,7 +546,7 @@
 
 		R4600_HIT_CACHEOP_WAR_IMPL;
 		a = addr & ~(dc_lsize - 1);
-		end = (addr + size - 1) & ~(dc_lsize - 1);
+		end = (addr + size + dc_lsize - 1) & ~(dc_lsize - 1);
 		while (1) {
 			flush_dcache_line(a);	/* Hit_Writeback_Inv_D */
 			if (a == end)

--------------010605080001030505010809--
