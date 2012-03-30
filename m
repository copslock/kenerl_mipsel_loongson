Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2012 16:27:00 +0200 (CEST)
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:1354 "EHLO
        smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903611Ab2C3O0x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Mar 2012 16:26:53 +0200
Received: from starbug-2.trinair2002 (dhcp-089-098-069-120.chello.nl [89.98.69.120])
        (authenticated bits=0)
        by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id q2UEQY6u067963;
        Fri, 30 Mar 2012 16:26:35 +0200 (CEST)
        (envelope-from maarten@treewalker.org)
Received: from hyperion.localnet (hyperion.trinair2002 [192.168.0.43])
        by starbug-2.trinair2002 (Postfix) with ESMTP id 480AE3DF2B;
        Fri, 30 Mar 2012 16:26:34 +0200 (CEST)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: JZ4740: reset: Initialize hibernate wakeup counters.
Date:   Fri, 30 Mar 2012 16:32:52 +0200
Message-ID: <2064508.Z8gKJpV0Ti@hyperion>
User-Agent: KMail/4.8.0 (Linux/3.1.9-1.4-default; KDE/4.8.1; x86_64; ; )
In-Reply-To: <27793108.UosBlGQXP9@hyperion>
References: <1333037998-18762-1-git-send-email-maarten@treewalker.org> <4F75A5C3.9000405@mvista.com> <27793108.UosBlGQXP9@hyperion>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Virus-Scanned: by XS4ALL Virus Scanner
X-archive-position: 32829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maarten@treewalker.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Friday 30 March 2012 16:07:41, I wrote:

> Actually the variable can be 32-bit: rtc_rate is in kHz, so the
> computation would wrap around for an RTC clock of over 40 GHz and I'm
> sure that is far more than the hardware supports.

Correction: rtc_rate is in Hz, therefore the computation would wrap around 
at 40 MHz, but that's likely still far more than the hardware supports. The 
typical RTC clock value is 32 kHz.

Bye,
		Maarten
