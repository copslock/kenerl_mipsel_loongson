Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Oct 2002 03:18:57 +0200 (CEST)
Received: from sj-msg-core-4.cisco.com ([171.71.163.54]:25269 "EHLO
	sj-msg-core-4.cisco.com") by linux-mips.org with ESMTP
	id <S1123905AbSJRBS4>; Fri, 18 Oct 2002 03:18:56 +0200
Received: from bbozarth-lnx.cisco.com (bbozarth-lnx.cisco.com [128.107.165.13])
	by sj-msg-core-4.cisco.com (8.12.2/8.12.2) with ESMTP id g9I1Imot016566
	for <linux-mips@linux-mips.org>; Thu, 17 Oct 2002 18:18:48 -0700 (PDT)
Received: from localhost (bbozarth@localhost)
	by bbozarth-lnx.cisco.com (8.11.6/8.11.6) with ESMTP id g9I1Imf02344
	for <linux-mips@linux-mips.org>; Thu, 17 Oct 2002 18:18:48 -0700
X-Authentication-Warning: bbozarth-lnx.cisco.com: bbozarth owned process doing -bs
Date: Thu, 17 Oct 2002 18:18:47 -0700 (PDT)
From: Brad Bozarth <prettygood@cs.stanford.edu>
X-X-Sender: bbozarth@bbozarth-lnx.cisco.com
Reply-To: prettygood@cs.stanford.edu
To: linux-mips@linux-mips.org
Subject: [patch] atomic.h
Message-ID: <Pine.LNX.4.44.0210171814120.493-100000@bbozarth-lnx.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <prettygood@cs.stanford.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prettygood@cs.stanford.edu
Precedence: bulk
X-list: linux-mips

The atomic_inc_and_test has a typo, diff below:

atomic.h ~/netapp/new/linux/include/asm-mips/atomic.h                           
--- atomic.hFri Sep 27 14:48:34 2002                                            
+++ /users/bbozarth/netapp/new/linux/include/asm-mips/atomic.hThu Oct 17 
18:12:\46 2002                                                                         
@@ -228,7 +228,7 @@                                                               
* other cases.  Note that the guaranteed                                        
* useful range of an atomic_t is only 24 bits.                                  
*/                                                                            
-#define atomic_inc_and_test(v) (atomic_inc_return(1, (v)) == 0)                
+#define atomic_inc_and_test(v) (atomic_add_return(1, (v)) == 0)                                                                                                 
/*                                                                               
* atomic_dec_and_test - decrement by 1 and test
