Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Sep 2010 15:31:41 +0200 (CEST)
Received: from mxout1.idt.com ([157.165.5.25]:51312 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491950Ab0I3Nbi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Sep 2010 15:31:38 +0200
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id o8UDVThk028697;
        Thu, 30 Sep 2010 06:31:29 -0700
Received: from corpml3.corp.idt.com (corpml3.corp.idt.com [157.165.140.25])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id o8UDVRhv027972;
        Thu, 30 Sep 2010 06:31:28 -0700 (PDT)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml3.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id o8UDVOD01179;
        Thu, 30 Sep 2010 06:31:24 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: How to setup interrupts for a new board?
Date:   Thu, 30 Sep 2010 06:31:23 -0700
Message-ID: <AEA634773855ED4CAD999FBB1A66D0760115A95C@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <alpine.LFD.2.00.1009300306230.21189@eddie.linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
thread-topic: How to setup interrupts for a new board?
thread-index: ActgR8lIqo7HbQzzQ6ufyhxNt69iXQAWR4JQ
References: <AEA634773855ED4CAD999FBB1A66D0760115A5BC@CORPEXCH1.na.ads.idt.com> <4CA36859.2050506@caviumnetworks.com> <AEA634773855ED4CAD999FBB1A66D0760115A691@CORPEXCH1.na.ads.idt.com> <alpine.LFD.2.00.1009300306230.21189@eddie.linux-mips.org>
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     "David Daney" <ddaney@caviumnetworks.com>,
        <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
X-archive-position: 27903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 24207

Hi Maciej,

I have read all the books you suggested and I work having all of them on
my desk. I come back to them frequently to check diverse stuff. My
problems are: 
- Why Malta implementation doesn't activate cpu_has_veic although they
have 8259 external interrupt controller? Malta implementation doesn't
activate cpu_has_vint too although Vectored interrupt mode should be the
minimum recommended mode if external controller is not present.
- Looking at Malta_xxxx specific files, it seems to me that they do not
follow Linux Porting Guide document I have read on MIPS Linux.

In addition, my company pays Timesys for support and regarding
cpu-feature.h define switches, they said that they know nothing.

What I was hoping was to find a MIPS Linux implementation which uses
Vectored Interrupt Mode (VI) with few h/w interrupts including the timer
routed to the MIPS processor or at least some document with some details
of implementation. That will shorten significantly my porting. Sure, if
I find nothing, I'll write from scratch as I understand, but it takes
for sure much longer and is worth to try first finding a close example.
    
Thanks,
Andrei



-----Original Message-----
From: Maciej W. Rozycki [mailto:macro@linux-mips.org] 
Sent: Wednesday, September 29, 2010 10:32 PM
To: Ardelean, Andrei
Cc: David Daney; linux-mips@linux-mips.org
Subject: RE: How to setup interrupts for a new board?

Hi Andrei,

> I checked in the MIPS documentation and I couldn't find relevant
> information about this particular way of implementation. Unfortunately
> in the MIPS kernel source there are no enough comments.

 With reasonable understanding what the MIPS architecture features
covered 
by these macros, functions, etc. are you should be able to infer from 
Linux code what it actually does.

 May I suggest some reading on the architecture first then?  I realise 
MIPS Technologies' architecture specifications may not be the best way
to 
learn how the architecture works, so why not try a MIPS textbook
instead, 
such as Dominic Sweetman's excellent "See MIPS Run Linux" (ISBN 
978-0-12-088421-6)?  While not covering such details of Linux as you are

looking for, it includes related introductory subjects to get you
started.  
And of course it covers the MIPS architecture itself.  You may be able
to 
find the book at your nearby (or less near) library.

 I think it's about as much as we can help -- you need to get down to 
understanding the details yourself or you'll be bound to asking around 
helplessly all the time.

  Maciej
