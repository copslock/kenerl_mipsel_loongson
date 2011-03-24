Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2011 13:17:03 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:36959 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491112Ab1CXMQ6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Mar 2011 13:16:58 +0100
Received: by eyh6 with SMTP id 6so2578943eyh.36
        for <multiple recipients>; Thu, 24 Mar 2011 05:16:52 -0700 (PDT)
Received: by 10.213.14.9 with SMTP id e9mr3556677eba.9.1300969012452;
        Thu, 24 Mar 2011 05:16:52 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.104.70])
        by mx.google.com with ESMTPS id b52sm4456721eei.8.2011.03.24.05.16.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 05:16:50 -0700 (PDT)
Message-ID: <4D8B35DA.6020804@mvista.com>
Date:   Thu, 24 Mar 2011 15:15:22 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [patch 10/38] MIPS: JZ4740: GPIO: Use shared irq chip for all
 gpios
References: <20110323210437.398062704@linutronix.de> <20110323210535.525705907@linutronix.de>
In-Reply-To: <20110323210535.525705907@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 24-03-2011 0:08, Thomas Gleixner wrote:

> Currently there is one irq_chip per gpio_chip with the only difference
> being the name. Since the information whether the irq belong to GPIO
> bank A, B, C or D is not that important rewrite the code to simply use
> a single irq_chip for all gpio_chips.

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

    If these 2 patches are from Lars, shouldn't there be "From: Lars-Peter 
Clausen <lars@metafoo.de>" line at the start of the patches?

WBR, Sergei
