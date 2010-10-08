Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 17:25:59 +0200 (CEST)
Received: from mxout1.idt.com ([157.165.5.25]:43751 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491201Ab0JHPZ4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 17:25:56 +0200
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id o98FPj75002085
        for <linux-mips@linux-mips.org>; Fri, 8 Oct 2010 08:25:46 -0700
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id o98FPjm6012618
        for <linux-mips@linux-mips.org>; Fri, 8 Oct 2010 08:25:45 -0700 (PDT)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id o98FPjp13370
        for <linux-mips@linux-mips.org>; Fri, 8 Oct 2010 08:25:45 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: How to add Ethernet and USB drivers to the Linux Kernel?
Date:   Fri, 8 Oct 2010 08:25:43 -0700
Message-ID: <AEA634773855ED4CAD999FBB1A66D076011E62CF@CORPEXCH1.na.ads.idt.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
thread-topic: How to add Ethernet and USB drivers to the Linux Kernel?
thread-index: Actm/RJWmw+F8ruqR5GVL20/7bKasQ==
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips

Hi,

I am porting MIPS Linux from Malta board to a new board. On Malta board
network and USB devices reside on PCI bus. In my case the new video
processor contains MIPS core, network and USB controllers, and those
controllers registers are in the direct memory map of MIPS core, there
is no PCI bus. Give me some advice how to add Ethernet and USB drivers
to the Kernel. Do I need to create a new virtual platform bus/device or
the Kernel has already what I need? If all the peripheral h/w blocks are
memory mapped directly in MIPS processor core space, can I have a single
bus for all of them?  

Thanks,
Andrei
  
