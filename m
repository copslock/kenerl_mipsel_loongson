Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2011 12:22:37 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:54316 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491042Ab1CCLWe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Mar 2011 12:22:34 +0100
Received: by bwz1 with SMTP id 1so1092505bwz.36
        for <multiple recipients>; Thu, 03 Mar 2011 03:22:26 -0800 (PST)
Received: by 10.204.23.15 with SMTP id p15mr1301653bkb.108.1299151346022;
        Thu, 03 Mar 2011 03:22:26 -0800 (PST)
Received: from [192.168.2.2] ([91.79.88.81])
        by mx.google.com with ESMTPS id w3sm668170bkt.5.2011.03.03.03.22.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Mar 2011 03:22:24 -0800 (PST)
Message-ID: <4D6F79A0.6050903@mvista.com>
Date:   Thu, 03 Mar 2011 14:21:04 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.14) Gecko/20110221 Thunderbird/3.1.8
MIME-Version: 1.0
To:     Jamie Iles <jamie@jamieiles.com>
CC:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V2 05/10] MIPS: lantiq: add watchdog support
References: <1298996006-15960-1-git-send-email-blogic@openwrt.org> <1298996006-15960-6-git-send-email-blogic@openwrt.org> <4D6E286D.9050100@mvista.com> <20110303101527.GE2955@pulham.picochip.com>
In-Reply-To: <20110303101527.GE2955@pulham.picochip.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 03-03-2011 13:15, Jamie Iles wrote:

>>> +static int
>>> +ltq_wdt_remove(struct platform_device *dev)

>>     __exit?

> No, I think this should be __devexit and the probe function should be
> __devinit.  When assigning the exit function to the platform_driver it
> should be surrounded with __devexit_p().

    Why? Is WDT really a hotplug device?

> Jamie

WBR, Sergei
