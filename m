Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Sep 2010 16:06:43 +0200 (CEST)
Received: from mxout1.idt.com ([157.165.5.25]:46225 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491013Ab0I2OGk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Sep 2010 16:06:40 +0200
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id o8TE6Vef000546
        for <linux-mips@linux-mips.org>; Wed, 29 Sep 2010 07:06:32 -0700
Received: from corpml3.corp.idt.com (corpml3.corp.idt.com [157.165.140.25])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id o8TE6SPp018948
        for <linux-mips@linux-mips.org>; Wed, 29 Sep 2010 07:06:31 -0700 (PDT)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml3.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id o8TE6QX29776
        for <linux-mips@linux-mips.org>; Wed, 29 Sep 2010 07:06:27 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: How to setup interrupts for a new board?
Date:   Wed, 29 Sep 2010 07:06:25 -0700
Message-ID: <AEA634773855ED4CAD999FBB1A66D0760115A5BC@CORPEXCH1.na.ads.idt.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
thread-topic: How to setup interrupts for a new board?
thread-index: Actf34C76BixbCLDQ+2ojen6Bg71LQ==
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
X-archive-position: 27889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 23359

Hi,

I created new board specific files gd_xxxx similar with malta_xxxx and I
am trying to configure Linux interrupts in gd-int.c.
My board has no external interrupt controller like Malta has, it has no
PCI, I use Vectored interrupt mode and a mux routes the external
interrupts to the MIPS h/w interrupts.
Wthat is the meaning of the following switches and how to set them:
cpu_has_divec		 
cpu_has_vce		
cpu_has_llsc
cpu_has_counter
cpu_has_vint

What is the difference between:
setup_irq()
set_irq_handler()
set_vi_handler()

Can you point me to document regarding interrupts implementation in MIPS
Linux?

Thanks,
Andrei
