Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2011 17:42:03 +0200 (CEST)
Received: from mxout1.idt.com ([157.165.5.25]:34212 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493075Ab1DRPl7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2011 17:41:59 +0200
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id p3IFfpg5009262
        for <linux-mips@linux-mips.org>; Mon, 18 Apr 2011 08:41:51 -0700
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id p3IFfp17017699
        for <linux-mips@linux-mips.org>; Mon, 18 Apr 2011 08:41:51 -0700 (PDT)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id p3IFfoD00568
        for <linux-mips@linux-mips.org>; Mon, 18 Apr 2011 08:41:50 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: How can I access h/w registers in user space?
Date:   Mon, 18 Apr 2011 08:41:48 -0700
Message-ID: <AEA634773855ED4CAD999FBB1A66D07601988DFA@CORPEXCH1.na.ads.idt.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How can I access h/w registers in user space?
Thread-Index: Acv93yESpVtD7h5CTqqtT7JP0JzO/A==
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips

Hi,

1. My video processor has many h/w registers mapped in MIPS CPU physical
memory space. Do I have in Linux MIPS something like iopl() to allow me
to access h/w registers in user space? Is it anything similar available?

2. I studied mmap() solution but what I found unpleased is that I need
to malloc() space in user space equal to the IO memory space I want to
access which it is quite lot and it takes from system DDR RAM available
I have here. What I need is just to access a physical space which I know
that is mapped on internal registers.     

Thanks,
Andrei
  
