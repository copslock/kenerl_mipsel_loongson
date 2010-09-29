Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Sep 2010 18:52:54 +0200 (CEST)
Received: from mxout1.idt.com ([157.165.5.25]:54264 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491135Ab0I2Qwv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Sep 2010 18:52:51 +0200
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id o8TGqiZp012288;
        Wed, 29 Sep 2010 09:52:44 -0700
Received: from corpml3.corp.idt.com (corpml3.corp.idt.com [157.165.140.25])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id o8TGqhWO010334;
        Wed, 29 Sep 2010 09:52:44 -0700 (PDT)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml3.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id o8TGqhJ22784;
        Wed, 29 Sep 2010 09:52:43 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: How to setup interrupts for a new board?
Date:   Wed, 29 Sep 2010 09:52:39 -0700
Message-ID: <AEA634773855ED4CAD999FBB1A66D0760115A691@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4CA36859.2050506@caviumnetworks.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
thread-topic: How to setup interrupts for a new board?
thread-index: Actf8nJM26aZ0Bb9SMuMRKhgiT2saQAA2pIg
References: <AEA634773855ED4CAD999FBB1A66D0760115A5BC@CORPEXCH1.na.ads.idt.com> <4CA36859.2050506@caviumnetworks.com>
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     "David Daney" <ddaney@caviumnetworks.com>
Cc:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
X-archive-position: 27891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                
X-UID: 23494

Hi David,

I checked in the MIPS documentation and I couldn't find relevant
information about this particular way of implementation. Unfortunately
in the MIPS kernel source there are no enough comments.

Thanks,
Andrei

-----Original Message-----
From: David Daney [mailto:ddaney@caviumnetworks.com] 
Sent: Wednesday, September 29, 2010 12:25 PM
To: Ardelean, Andrei
Cc: linux-mips@linux-mips.org
Subject: Re: How to setup interrupts for a new board?

On 09/29/2010 07:06 AM, Ardelean, Andrei wrote:
> Hi,
>
> I created new board specific files gd_xxxx similar with malta_xxxx and
I
> am trying to configure Linux interrupts in gd-int.c.
> My board has no external interrupt controller like Malta has, it has
no
> PCI, I use Vectored interrupt mode and a mux routes the external
> interrupts to the MIPS h/w interrupts.
> Wthat is the meaning of the following switches and how to set them:
> cpu_has_divec		
> cpu_has_vce		
> cpu_has_llsc
> cpu_has_counter
> cpu_has_vint
>
> What is the difference between:
> setup_irq()
> set_irq_handler()
> set_vi_handler()
>
> Can you point me to document regarding interrupts implementation in
MIPS
> Linux?

Other than the Linux Kernel source code, make sure you have a copy of:

MD00090-2B-MIPS32PRA-AFP, the "MIPS32(r) Architecture for Programmers 
Volume III: The MIPS32(r) Privileged Resource Architecture"

It can be downloaded from mips.com

David Daney


>
> Thanks,
> Andrei
>
>
