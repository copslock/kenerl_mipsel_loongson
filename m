Received:  by oss.sgi.com id <S305157AbQCGWO2>;
	Tue, 7 Mar 2000 14:14:28 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:56929 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQCGWOJ>;
	Tue, 7 Mar 2000 14:14:09 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA06396; Tue, 7 Mar 2000 14:09:34 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA50659
	for linux-list;
	Tue, 7 Mar 2000 14:05:28 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA35548
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 7 Mar 2000 14:05:25 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA05319
	for <linux@cthulhu.engr.sgi.com>; Tue, 7 Mar 2000 14:05:11 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from lithium (lithium.tucc.uab.edu [138.26.15.219])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id QAA21654
	for <linux@cthulhu.engr.sgi.com>; Tue, 7 Mar 2000 16:05:07 -0600
Date:   Tue, 7 Mar 2000 16:05:07 -0600 (CST)
From:   "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@lithium
To:     Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: problem with most recent 2.3 CVS kernel
Message-ID: <Pine.LNX.3.96.1000307160335.13309I-100000@lithium>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Everything goes well until just after the SCSI disk detection.  Then I
get:


scsi : detected 2 SCSI disks total.                                             
scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=160, scaling              
scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=128, scaling              
scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=96, scaling               
scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=80, scaling               
scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=64, scaling               
scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=48, scaling               
      WARNING, not enough memory, pool not expanded
Unable to handle kernel paging request at virtual address 00000000, epc ==
880a4
Oops in fault.c:do_page_fault, line 153:                                        
$0 : 00000000 881100e0 00000000 00000021                                        
$4 : 00000019 00000008 00000008 00000001                                        
$8 : 1004fc00 1000001f 00000003 88631e54                                        
$12: 00000000 0000000a 00000000 88115840                                        
$16: 00000000 bfbc0003 00000008 00000001                                        
$20: 00000080 00000049 0000003a 1004fc00                                        
$24: 00000020 bfbd9833                                                          
$28: 88008000 88009e08 88635800 880a7714                                        
epc   : 880a77a4


Any hints on this one?

-Andrew
