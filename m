Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Feb 2013 12:35:29 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45558 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817128Ab3BCLf2Zm5Ws (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Feb 2013 12:35:28 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id A7B068F62;
        Sun,  3 Feb 2013 12:35:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eT0uZ6Y7ojg0; Sun,  3 Feb 2013 12:35:22 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:b54f:3623:690c:6cea] (unknown [IPv6:2001:470:1f0b:447:b54f:3623:690c:6cea])
        by hauke-m.de (Postfix) with ESMTPSA id 933358F60;
        Sun,  3 Feb 2013 12:35:22 +0100 (CET)
Message-ID: <510E4B79.3040903@hauke-m.de>
Date:   Sun, 03 Feb 2013 12:35:21 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: CPU hang on cpu_wait in CPU_74K
References: <CACna6rxU3LX+PBgyddMqGtM4=_zvzLZMehB1W1PwN36ZUwF3sA@mail.gmail.com>
In-Reply-To: <CACna6rxU3LX+PBgyddMqGtM4=_zvzLZMehB1W1PwN36ZUwF3sA@mail.gmail.com>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 35694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 02/01/2013 11:44 PM, Rafał Miłecki wrote:
> Hello again ;)
> 
> I'm hacking a BCM4706 based board which uses a 74K CPU. The problem is
> that wait_cpu (see cpu-probe.c) hangs my machine (is happens as soon
> as the first [um]sleep is called).
> 
> The hang is related to the cpu-probe.c and:
>> cpu_wait = r4k_wait;
>> if ((c->processor_id & 0xff) >= PRID_REV_ENCODE_332(2, 1, 0))
>> 	cpu_wait = r4k_wait_irqoff;
> 
> If I remove that lines completely [um]sleep doesn't hang machine
> anymore. I'm not sure if removing that code is a proper solution. I'm
> not sure what is the
>> c->processor_id & 0xff
> on my machine, but I've tried forcing both:
>> cpu_wait = r4k_wait;
> and
>> cpu_wait = r4k_wait_irqoff;
> and both are causing hangs.
> 
> If I recall correctly, Hauke was checking Broadcom's code and they're
> using the same solution: removing that lines completely.
> 
> Do you have any idea how this could be solved?
> 
Hello Rafał,

In the Linux kernel form the Broadcom SDK the lines you mentioned are
removed, but we can not do this in the mainline kernel as this would
also affect some other non broken Broadcom MIPS CPUs. I talked about
this with Ralf some days ago and he said we should add cpu_wait = NULL;
somewhere in the platform specific code. This problem seams to just
affect the 74K CPU used on the BCM4706 and not on the other Broadcom SoC
using a 74K CPU.

Hauke
