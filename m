Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2010 00:20:27 +0200 (CEST)
Received: from mxout1.idt.com ([157.165.5.25]:53186 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491123Ab0JMWUY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Oct 2010 00:20:24 +0200
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id o9DMKGcL019027
        for <linux-mips@linux-mips.org>; Wed, 13 Oct 2010 15:20:17 -0700
Received: from corpml3.corp.idt.com (corpml3.corp.idt.com [157.165.140.25])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id o9DMKGMU022649
        for <linux-mips@linux-mips.org>; Wed, 13 Oct 2010 15:20:16 -0700 (PDT)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml3.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id o9DMKFB00966
        for <linux-mips@linux-mips.org>; Wed, 13 Oct 2010 15:20:15 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: How to configure Platform NAND driver?
Date:   Wed, 13 Oct 2010 15:20:13 -0700
Message-ID: <AEA634773855ED4CAD999FBB1A66D076011E6CC3@CORPEXCH1.na.ads.idt.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to configure Platform NAND driver?
Thread-Index: ActrJM6eMRgzSfcTRlWCmixQpFCHDw==
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips

Hi,

I am porting MIPS Linux on a new board and I have a MICRON NAND part
(MT29F4G08). I look in nand-ids.c and it seems that this part is already
supported. I assume that this support is in the plat_nand.c platform
driver. How can I configure this platform driver to use my own
read/write low level functions? How can I configure this driver with my
own mtd_partition structure?

I see some other people wrote their own NAND driver in
.../drivers/mtd/nand folder. Do I need to do that or can I use
plat_nand.c driver?

Thanks,
Andrei
  
