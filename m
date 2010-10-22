Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2010 21:25:56 +0200 (CEST)
Received: from mxout1.idt.com ([157.165.5.25]:44287 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491065Ab0JVTZx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Oct 2010 21:25:53 +0200
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id o9MJPjVZ026827
        for <linux-mips@linux-mips.org>; Fri, 22 Oct 2010 12:25:46 -0700
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id o9MJPhxY014622
        for <linux-mips@linux-mips.org>; Fri, 22 Oct 2010 12:25:45 -0700 (PDT)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id o9MJPgI08171
        for <linux-mips@linux-mips.org>; Fri, 22 Oct 2010 12:25:43 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Is it any serial8250 platform driver available?
Date:   Fri, 22 Oct 2010 12:23:49 -0700
Message-ID: <AEA634773855ED4CAD999FBB1A66D0760126B496@CORPEXCH1.na.ads.idt.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Is it any serial8250 platform driver available?
Thread-Index: ActyHqeeS096zxxaRLCIqZ0IHsaJvQ==
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips

Hi,

I am porting MIPS Linux from MALTA to a new board. I ported early
console code from malta_console.c and I am looking now to use a
interrupt driven driver for TTY. My UART is compatible with 8250 (1 UART
port only) but the UART registers are directly mapped in CPU memory map.
There is no PCI bus. My problem is that the driver implemented in 8250.c
is very complex and it seems to be hardcode for ISA bus, is it any
simple platform UART driver available to be directly mapped in the CPU
space? Can you give me some advice what would be a good approach for my
case?

Thanks,
Andrei
  
