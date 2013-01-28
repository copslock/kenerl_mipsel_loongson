Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 23:06:14 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:60094 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6833504Ab3A1WGMfAKaE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Jan 2013 23:06:12 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id BE2B98F61;
        Mon, 28 Jan 2013 23:06:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BRRsNtP+TeTD; Mon, 28 Jan 2013 23:06:07 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:9c64:e79b:5d5:dc4] (unknown [IPv6:2001:470:1f0b:447:9c64:e79b:5d5:dc4])
        by hauke-m.de (Postfix) with ESMTPSA id CF65C8E1C;
        Mon, 28 Jan 2013 23:06:06 +0100 (CET)
Message-ID: <5106F64B.6040801@hauke-m.de>
Date:   Mon, 28 Jan 2013 23:06:03 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Wim Van Sebroeck <wim@iguana.be>
CC:     linux-watchdog@vger.kernel.org, zajec5@gmail.com,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v4 0/5] watchdog: bcm47xx_wdt.c: add support for SoCs
 with PMU
References: <1358010851-28077-1-git-send-email-hauke@hauke-m.de> <51016C4D.40707@hauke-m.de> <20130128213544.GB3338@spo001.leaseweb.com>
In-Reply-To: <20130128213544.GB3338@spo001.leaseweb.com>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 35607
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

On 01/28/2013 10:35 PM, Wim Van Sebroeck wrote:
> Hi Hauke,
> 
>> what is the status of these patches?
> 
> First reading/checking (v4+v5) seems OK.
> 1 small remark allready: the settimeout functions seem to check the min and max timeout values.
> Can't you use the min and max values of the watchdog structure for this?
> 
> Kind regards,
> Wim.
> 
Hi Wim,

The max_timer_ms attribute in struct bcm47xx_wdt contains the maximum
value the hardware is capable of, the watchdog driver uses a softtimer
if this value is too low and in that case it is no problem if a
userspace application sets the timeout to some value higher than
max_timer_ms.

If I would use max_timeout from struct watchdog_device I would have to
change that values when softtimer is selected.

The best solution would be if the softtimer choice and implementation
would go to watchdog_dev.c as some more watchdog driver do something
similar.

Hauke
