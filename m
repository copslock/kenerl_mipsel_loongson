Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2010 20:22:15 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:57144 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492617Ab0KRTWM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Nov 2010 20:22:12 +0100
Received: by eyd9 with SMTP id 9so2192443eyd.36
        for <linux-mips@linux-mips.org>; Thu, 18 Nov 2010 11:22:10 -0800 (PST)
Received: by 10.213.105.145 with SMTP id t17mr4046964ebo.65.1290108130501;
        Thu, 18 Nov 2010 11:22:10 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id b52sm686275eei.1.2010.11.18.11.22.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 11:22:09 -0800 (PST)
Message-ID: <4CE57C92.6030705@mvista.com>
Date:   Thu, 18 Nov 2010 22:20:50 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
CC:     linux-mips@linux-mips.org
Subject: Re: The new "real" console doesn't display printk() messages like
 "early" console!
References: <AEA634773855ED4CAD999FBB1A66D0760136A102@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D0760136A102@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ardelean, Andrei wrote:

> I am porting MIPS Linux on a new platform and my kernel crashes after
> console is switched from early console to the new real console (8250.c)
> I see messages displayed using the new console like "Freeing prom
> memory: 956k freed" (this is the last message I have) so the new console
> is up and running. 
> My problem is that the new console doesn't display printk() messages.
> The early console displays all printk() messages.

> What do I need to set at compiling time that the new console to display
> printk() messages like early console?

    Have you specified "console=ttyS<n>,<baudrate> as the kernel parameter?

> Thanks,
> Andrei

WBR, Sergei
