Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jan 2013 13:57:37 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:58355 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6832832Ab3AQM5gEVh1c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jan 2013 13:57:36 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 3B9388F61;
        Thu, 17 Jan 2013 13:57:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eIp0TCh5FupW; Thu, 17 Jan 2013 13:57:29 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:bcb8:fe27:f188:5366] (unknown [IPv6:2001:470:1f0b:447:bcb8:fe27:f188:5366])
        by hauke-m.de (Postfix) with ESMTPSA id 073318E1C;
        Thu, 17 Jan 2013 13:57:28 +0100 (CET)
Message-ID: <50F7F537.6020000@hauke-m.de>
Date:   Thu, 17 Jan 2013 13:57:27 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Arend Van Spriel <arend@broadcom.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mips: bcm47xx: select GPIOLIB for BCMA on bcm47xx platform
References: <1357323005-28008-1-git-send-email-arend@broadcom.com> <A47087626F2942499CF47E79803E771E04294E30@SJEXCHMB13.corp.ad.broadcom.com>
In-Reply-To: <A47087626F2942499CF47E79803E771E04294E30@SJEXCHMB13.corp.ad.broadcom.com>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 35478
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

On 01/17/2013 12:07 PM, Arend Van Spriel wrote:
>> From: Arend van Spriel [arend@broadcom.com]
>> Sent: Friday, January 04, 2013 7:10 PM
>>
>> The Kconfig items BCM47XX_BCMA and BCM47XX_SSB selected
>> respectively BCMA_DRIVER_GPIO and SSB_DRIVER_GPIO. These
>> options depend on GPIOLIB without explicitly selecting it
>> so it results in a warning when GPIOLIB is not set:
> 
> Hi Ralf
> 
> Are you still intending to take this patch or did it slip by?
> 
> Gr. AvS

This was applied by Ralf in his tree for linux next integration [0] [1].

@Ralf could you please also send these patches to Linus for 3.8.

Hauke

[0]:
http://git.linux-mips.org/?p=ralf/upstream-sfr.git;a=commitdiff;h=a9e985783ed936376de9f27eff54e37d584fb855;hp=3d2d03247632920aa21b42a0b032a4ffd44ce15e
[1]:
http://git.linux-mips.org/?p=ralf/upstream-sfr.git;a=commitdiff;h=b26d9ac76b22f53f1553d63c676dc2e70a8e3157;hp=a9e985783ed936376de9f27eff54e37d584fb855
