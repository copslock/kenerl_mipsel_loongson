Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2012 15:02:15 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:53990 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903665Ab2CFOBv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Mar 2012 15:01:51 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id A117E3C27E;
        Tue,  6 Mar 2012 15:01:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hkIUsNOP-rn9; Tue,  6 Mar 2012 15:01:50 +0100 (CET)
Received: from zmc.proxad.net (zmc.proxad.net [212.27.53.206])
        by zmc.proxad.net (Postfix) with ESMTP id 6A0C436E7F;
        Tue,  6 Mar 2012 15:01:50 +0100 (CET)
Date:   Tue, 6 Mar 2012 15:01:50 +0100 (CET)
From:   Florian Fainelli <ffainelli@freebox.fr>
Reply-To: Florian Fainelli <ffainelli@freebox.fr>
To:     loody <miloody@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Message-ID: <160192556.459513.1331042510355.JavaMail.root@zmc>
In-Reply-To: <CANudz+ugY7NfCSGh-_kS4pzC91p02ZtYpxXMdCOKsM+spAt37g@mail.gmail.com>
Subject: Re: some questions about mips timer
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.36.7.13]
X-Mailer: Zimbra 7.1.4_GA_2555 (ZimbraWebClient - FF3.0 (Linux)/7.1.4_GA_2555)
X-archive-position: 32604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ffainelli@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,

----- Mail original -----
> hi all:
> I have some questions about mips_hpt_frequency:
> 1. is mips_hpt_frequency == mips cpu frequency?

No, it is usually cpu frequency / 2.

> 2. what does "hpt" mean?

High-precision timer.
--
Florian
