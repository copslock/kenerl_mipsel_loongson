Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2010 19:56:10 +0100 (CET)
Received: from mxout1.idt.com ([157.165.5.25]:59541 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492603Ab0KRSzv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Nov 2010 19:55:51 +0100
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id oAIItiB7020580
        for <linux-mips@linux-mips.org>; Thu, 18 Nov 2010 10:55:44 -0800
Received: from corpml3.corp.idt.com (corpml3.corp.idt.com [157.165.140.25])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id oAIIthBh024441
        for <linux-mips@linux-mips.org>; Thu, 18 Nov 2010 10:55:43 -0800 (PST)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml3.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id oAIItfr24175
        for <linux-mips@linux-mips.org>; Thu, 18 Nov 2010 10:55:42 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: The new "real" console doesn't display printk() messages like "early" console!
Date:   Thu, 18 Nov 2010 10:55:39 -0800
Message-ID: <AEA634773855ED4CAD999FBB1A66D0760136A102@CORPEXCH1.na.ads.idt.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The new "real" console doesn't display printk() messages like "early" console!
Thread-Index: AcuHUjGIdgCnRPbVSCuuNdXyXpkKCw==
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips

Hi,

I am porting MIPS Linux on a new platform and my kernel crashes after
console is switched from early console to the new real console (8250.c)
I see messages displayed using the new console like "Freeing prom
memory: 956k freed" (this is the last message I have) so the new console
is up and running. 
My problem is that the new console doesn't display printk() messages.
The early console displays all printk() messages.

What do I need to set at compiling time that the new console to display
printk() messages like early console?

Thanks,
Andrei
 
