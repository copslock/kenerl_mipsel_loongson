Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2011 19:31:15 +0200 (CEST)
Received: from mxout1.idt.com ([157.165.5.25]:60501 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491115Ab1DGRbM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Apr 2011 19:31:12 +0200
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id p37HV4Wo009474
        for <linux-mips@linux-mips.org>; Thu, 7 Apr 2011 10:31:04 -0700
Received: from corpml3.corp.idt.com (corpml3.corp.idt.com [157.165.140.25])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id p37HV4Pj005336
        for <linux-mips@linux-mips.org>; Thu, 7 Apr 2011 10:31:04 -0700 (PDT)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml3.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id p37HV2g14496
        for <linux-mips@linux-mips.org>; Thu, 7 Apr 2011 10:31:03 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: After writing successfully a NAND block is this reliable ar reading as a NOR sector? 
Date:   Thu, 7 Apr 2011 10:31:01 -0700
Message-ID: <AEA634773855ED4CAD999FBB1A66D0760190AFDD@CORPEXCH1.na.ads.idt.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: After writing successfully a NAND block is this reliable ar reading as a NOR sector? 
Thread-Index: Acv1SZCM2iZJg7PmSYSrxfmO5vrwtg==
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips

Hi,

Am interested in using MT29F2G08AABWP NAND Flash memory for a new
embedded design and I couldn't find a clear specification regarding how
reliable is the NAND flash vs. NOR for reading operation.

If I program successfully a NAND block, read back and verify
successfully the information and never erase or program that particular
block again, can I assume that block will remain a good block and the
information written there is safe for READING, roughly as safe as a NOR
sector?

Is it any reason to keep in NAND copies of Kernel, bootloader or RFS? Is
it a standard practice in the industry to keep copies in NAND even
though we do not erase/program those during the normal operation? 
 

Thank you,
Andrei
