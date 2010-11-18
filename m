Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2010 22:21:09 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:53870 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490955Ab0KRVVG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Nov 2010 22:21:06 +0100
Received: by ewy19 with SMTP id 19so2301365ewy.36
        for <linux-mips@linux-mips.org>; Thu, 18 Nov 2010 13:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=AqQpor/PyVvtH2gllAhYZMfb+BscoMhO16i5Nh8SSIg=;
        b=I8/c3eqPuKq9+Nxz6a8fxRZvbBieiHQ6mNMPeJhG0I4dm3DO1dyyl0O/XoU6YjgEnm
         mOUH3RXmivbPSgZxUuKwtoJ9pHhlVqJAs0t3INYLiWEwzQFfQq35ix9kLI2DegSoUcHm
         sYuSU4nAo3bLaUU5CxcF1gmgHJG45ceMEAgsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=ZeJYWCsvnH/znrtsxjcUsqonqg/GRJ5eeqV63Nxw8CsBziZcRvaSRJWJUc5o3wbCNT
         secaf6NoOxQW7zvyG8DIMREvGYeQeMa2AibgBlKaPDQWT2VxNWmgjoTCd4JkL1EmrUGD
         Wd175aQkqyZpDoTpeMHE8/PzY4hhBuXfaoZvI=
MIME-Version: 1.0
Received: by 10.216.28.77 with SMTP id f55mr29133wea.91.1290115266223; Thu, 18
 Nov 2010 13:21:06 -0800 (PST)
Received: by 10.216.91.8 with HTTP; Thu, 18 Nov 2010 13:21:06 -0800 (PST)
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D0760136A151@CORPEXCH1.na.ads.idt.com>
References: <AEA634773855ED4CAD999FBB1A66D0760136A102@CORPEXCH1.na.ads.idt.com>
        <4CE57C92.6030705@mvista.com>
        <AEA634773855ED4CAD999FBB1A66D0760136A151@CORPEXCH1.na.ads.idt.com>
Date:   Thu, 18 Nov 2010 21:21:06 +0000
X-Google-Sender-Auth: a3tyewqjAZn6z2_50a5ZE_2QhFk
Message-ID: <AANLkTinEXDoXQFa1gN6prRQYjqkvc9vSA_H7JOXPLsPw@mail.gmail.com>
Subject: Re: The new "real" console doesn't display printk() messages like
 "early" console!
From:   Ricardo Mendoza <ricmm@gentoo.org>
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <mendoza.ricardo@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricmm@gentoo.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 18, 2010 at 8:04 PM, Ardelean, Andrei
<Andrei.Ardelean@idt.com> wrote:

> I specified that when the bootloader calls the kernel and I did see that
> the baudrate is correct and I have some messages but when the system is
> crashing I cannot see printk messages. For instance, I step with JTAG
> and I can see that printk(KERNEL_WARNING "unable to open initial
> console") is called but on the terminal I cannot see the message. The
> same, die() is called but there is no messages on UART terminal.

You say you are porting to a new system, perhaps you didn't set up
your 8250 platform device. Most boards will have an example for you in
the tree.


     Ricardo
