Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Sep 2002 22:15:31 +0200 (CEST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:10807 "EHLO
	ubik.localnet") by linux-mips.org with ESMTP id <S1122961AbSILUPa>;
	Thu, 12 Sep 2002 22:15:30 +0200
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by ubik.localnet (8.12.3/8.12.3/Debian -4) with ESMTP id g8CKFB6m032403;
	Thu, 12 Sep 2002 22:15:11 +0200
Message-ID: <3D80F5CF.1040905@murphy.dk>
Date: Thu, 12 Sep 2002 22:15:11 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Murphy <brian@murphy.dk>
CC: linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.4] Re: ide-dma bug (cache flushing)
References: <3D7FAB4A.4010802@murphy.dk>
Content-Type: multipart/mixed;
 boundary="------------070501060604050701070702"
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070501060604050701070702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

It seems like this problem is (yet again) caused by lack of cache flushing.
The attached patch adds a  dma_cache_wback_inv to pci_map_sg in pci.h
to the if fork in which sg->address is not set.

This fixes my problem.

Can someone with commit access please apply this patch?

/Brian

--------------070501060604050701070702
Content-Type: text/plain;
 name="flush.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="flush.patch"

Index: include/asm-mips/pci.h
===================================================================
RCS file: /cvs/linux-mips/include/asm-mips/pci.h,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 pci.h
--- include/asm-mips/pci.h	19 Aug 2002 18:00:29 -0000	1.1.1.2
+++ include/asm-mips/pci.h	12 Sep 2002 20:06:31 -0000
@@ -200,9 +200,13 @@
 			dma_cache_wback_inv((unsigned long)sg->address,
 			                    sg->length);
 			sg->dma_address = bus_to_baddr(hwdev, __pa(sg->address));
-		} else
+		} else {
 			sg->dma_address = page_to_bus(sg->page) +
 			                  sg->offset;
+			dma_cache_wback_inv(
+				(unsigned long)(page_address(sg->page)+
+						sg->offset), sg->length);
+		}
 	}
 
 	return nents;

--------------070501060604050701070702--
