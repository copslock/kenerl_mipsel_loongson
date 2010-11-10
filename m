Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Nov 2010 16:49:43 +0100 (CET)
Received: from mxout1.idt.com ([157.165.5.25]:42575 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491189Ab0KJPtk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Nov 2010 16:49:40 +0100
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id oAAFnWPB031635
        for <linux-mips@linux-mips.org>; Wed, 10 Nov 2010 07:49:32 -0800
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id oAAFnUBo008726
        for <linux-mips@linux-mips.org>; Wed, 10 Nov 2010 07:49:31 -0800 (PST)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id oAAFnUU19135
        for <linux-mips@linux-mips.org>; Wed, 10 Nov 2010 07:49:30 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Kernel is stuck in Calibrating delay loop 
Date:   Wed, 10 Nov 2010 07:49:27 -0800
Message-ID: <AEA634773855ED4CAD999FBB1A66D0760132BB00@CORPEXCH1.na.ads.idt.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel is stuck in Calibrating delay loop 
Thread-Index: AcuA7trpS8wH/gWjRwSJWvIpood+/g==
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips

Hi,

I am porting MIPS Malta on a new platform and during the boot process
the Kernel remains in a infinite loop in "Calibrating delay loop ..." in
calibrate.c.
I checked and the timer interrupt which is supposed to be wired on h/w 5
interrupt (MIPS 7 irq) is not activated in MIPS Status.IM7 register.
Where in the Kernel the MIPS irq wired to the timer interrupt needs to
be enabled?  Can I use enable_irq()?
On my platform I don't have any 8259 and I am trying to use MIPS
Count/Compare internal timer for Kernel tick.

Thanks,
Andrei

  
