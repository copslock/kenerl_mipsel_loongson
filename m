Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2010 15:31:56 +0200 (CEST)
Received: from mxout1.idt.com ([157.165.5.25]:40567 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491159Ab0HRNbv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Aug 2010 15:31:51 +0200
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id o7IDViXf021736
        for <linux-mips@linux-mips.org>; Wed, 18 Aug 2010 06:31:44 -0700
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id o7IDViwd029479
        for <linux-mips@linux-mips.org>; Wed, 18 Aug 2010 06:31:44 -0700 (PDT)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id o7IDVhl22879
        for <linux-mips@linux-mips.org>; Wed, 18 Aug 2010 06:31:43 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Does Mips Linux rely on Yamon h/w initialization (other than DDR memory which is strictly necessary)?
Date:   Wed, 18 Aug 2010 06:31:42 -0700
Message-ID: <AEA634773855ED4CAD999FBB1A66D076FC3BDF@CORPEXCH1.na.ads.idt.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
thread-topic: Does Mips Linux rely on Yamon h/w initialization (other than DDR memory which is strictly necessary)?
thread-index: Acs+2bHgPx6CyZgoTAC+IXnMlqMzfA==
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips

Hi,

Malta board has Yamon monitor which initializes the DDR memory and other
h/w. Does Mips Linux rely on Yamon h/w initialization (except memory)
like PCI, NET, UART, etc in order to boot? Does Mips Linux re-initialize
the h/w again? 
I am booting Linux on Malta with a small monitor which initializes only
the memory. I pass the environment vars array, command line arguments
and memory size as Yamon would do. The ASCII display shows "Linux on
Malta" scrolling text so Linux kernel it seems that at least it started
but there is no NET activity and no messages on UART.

Thanks,
Andrei
