Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2010 19:53:15 +0100 (CET)
Received: from mxout1.idt.com ([157.165.5.25]:40826 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492149Ab0KLSxM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Nov 2010 19:53:12 +0100
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id oACIr5XY006114
        for <linux-mips@linux-mips.org>; Fri, 12 Nov 2010 10:53:05 -0800
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id oACIr5DY003837
        for <linux-mips@linux-mips.org>; Fri, 12 Nov 2010 10:53:05 -0800 (PST)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id oACIr4d22724
        for <linux-mips@linux-mips.org>; Fri, 12 Nov 2010 10:53:04 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Why do we have ebase located at some high memory address when we use Vectored Interrupts?
Date:   Fri, 12 Nov 2010 10:53:02 -0800
Message-ID: <AEA634773855ED4CAD999FBB1A66D0760132C239@CORPEXCH1.na.ads.idt.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Why do we have ebase located at some high memory address when we use Vectored Interrupts?
Thread-Index: AcuCmtVspzOQ1PvOQLyjfo6oJCB30A==
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips


Hi,

Why do we have ebase located at some high memory address when we use
Vectored Interrupts and for Compatible Mode we have the normal location
close to zero?

Thanks,
Andrei
 


.............................. in void __init trap_init(void):
	if (cpu_has_veic || cpu_has_vint) {
		unsigned long size = 0x200 + VECTORSPACING*64;
		ebase = (unsigned long)
			__alloc_bootmem(size, 1 << fls(size), 0);
	} else {
		ebase = CAC_BASE;
		if (cpu_has_mips_r2)
			ebase += (read_c0_ebase() & 0x3ffff000);
	}
.........................
