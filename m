Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2010 21:05:00 +0100 (CET)
Received: from mxout1.idt.com ([157.165.5.25]:35054 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491992Ab0KRUE5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Nov 2010 21:04:57 +0100
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id oAIK4oU3025526;
        Thu, 18 Nov 2010 12:04:50 -0800
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id oAIK4oX7001979;
        Thu, 18 Nov 2010 12:04:50 -0800 (PST)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id oAIK4n116645;
        Thu, 18 Nov 2010 12:04:49 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: The new "real" console doesn't display printk() messages like "early" console!
Date:   Thu, 18 Nov 2010 12:04:26 -0800
Message-ID: <AEA634773855ED4CAD999FBB1A66D0760136A151@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4CE57C92.6030705@mvista.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The new "real" console doesn't display printk() messages like "early" console!
Thread-Index: AcuHWbAJ3WMOvi3FT0K1Uo59L9wjuwAANU5A
References: <AEA634773855ED4CAD999FBB1A66D0760136A102@CORPEXCH1.na.ads.idt.com> <4CE57C92.6030705@mvista.com>
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     "Sergei Shtylyov" <sshtylyov@mvista.com>
Cc:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips

Hi Sergei,

I specified that when the bootloader calls the kernel and I did see that
the baudrate is correct and I have some messages but when the system is
crashing I cannot see printk messages. For instance, I step with JTAG
and I can see that printk(KERNEL_WARNING "unable to open initial
console") is called but on the terminal I cannot see the message. The
same, die() is called but there is no messages on UART terminal.

Thanks,
Andrei
 

-----Original Message-----
From: Sergei Shtylyov [mailto:sshtylyov@mvista.com] 
Sent: Thursday, November 18, 2010 2:21 PM
To: Ardelean, Andrei
Cc: linux-mips@linux-mips.org
Subject: Re: The new "real" console doesn't display printk() messages
like "early" console!

Hello.

Ardelean, Andrei wrote:

> I am porting MIPS Linux on a new platform and my kernel crashes after
> console is switched from early console to the new real console
(8250.c)
> I see messages displayed using the new console like "Freeing prom
> memory: 956k freed" (this is the last message I have) so the new
console
> is up and running. 
> My problem is that the new console doesn't display printk() messages.
> The early console displays all printk() messages.

> What do I need to set at compiling time that the new console to
display
> printk() messages like early console?

    Have you specified "console=ttyS<n>,<baudrate> as the kernel
parameter?

> Thanks,
> Andrei

WBR, Sergei
