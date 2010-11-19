Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Nov 2010 15:04:31 +0100 (CET)
Received: from mxout1.idt.com ([157.165.5.25]:56155 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491872Ab0KSOE2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Nov 2010 15:04:28 +0100
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id oAJE4Iem030438;
        Fri, 19 Nov 2010 06:04:18 -0800
Received: from corpml3.corp.idt.com (corpml3.corp.idt.com [157.165.140.25])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id oAJE4HSr022869;
        Fri, 19 Nov 2010 06:04:17 -0800 (PST)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml3.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id oAJE4Gm26236;
        Fri, 19 Nov 2010 06:04:16 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: The new "real" console doesn't display printk() messages like "early" console!
Date:   Fri, 19 Nov 2010 06:04:07 -0800
Message-ID: <AEA634773855ED4CAD999FBB1A66D0760136A2F5@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AANLkTimqF-Zy6eQurPRq5m71waB=n4zyRfRbpxyCsWgn@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The new "real" console doesn't display printk() messages like "early" console!
Thread-Index: AcuHf5ATiEo4mLPfSaesmCyQSEQaSgAcbkZA
References: <AEA634773855ED4CAD999FBB1A66D0760136A102@CORPEXCH1.na.ads.idt.com><4CE57C92.6030705@mvista.com><AEA634773855ED4CAD999FBB1A66D0760136A151@CORPEXCH1.na.ads.idt.com><AANLkTinEXDoXQFa1gN6prRQYjqkvc9vSA_H7JOXPLsPw@mail.gmail.com><AEA634773855ED4CAD999FBB1A66D0760136A1F3@CORPEXCH1.na.ads.idt.com> <AANLkTimqF-Zy6eQurPRq5m71waB=n4zyRfRbpxyCsWgn@mail.gmail.com>
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     "Ricardo Mendoza" <ricmm@gentoo.org>
Cc:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips

Hi Ricardo,

I used Octeon just as a model, I added my own PORT_GD and my own
serial_in/out driver functions which work well, I have some messages on
the screen. My problem is that I can see messages like "Freeing unused
kernel memory..." but I cannot see printk() error/warning/debug
messages, like the messages printed by die().

Thanks,
Andrei



-----Original Message-----
From: mendoza.ricardo@gmail.com [mailto:mendoza.ricardo@gmail.com] On
Behalf Of Ricardo Mendoza
Sent: Thursday, November 18, 2010 6:58 PM
To: Ardelean, Andrei
Cc: linux-mips@linux-mips.org
Subject: Re: The new "real" console doesn't display printk() messages
like "early" console!

On Thu, Nov 18, 2010 at 10:01 PM, Ardelean, Andrei
<Andrei.Ardelean@idt.com> wrote:

> Hi Ricardo,
>
> I implemented serial platform driver taking as model serial.c from
> cavium-octeon.
>
> Here is my code:
>
> ...

Why use the Octeon code which has platform specific bits that might
have nothing to do with your platform? Build up from the simple ones.


     Ricardo
