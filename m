Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2012 22:05:56 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:48221 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6828056Ab2KUVF4HYj5X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2012 22:05:56 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 1CFDD8F61;
        Wed, 21 Nov 2012 22:05:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9-pk+9woT5Lr; Wed, 21 Nov 2012 22:05:51 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:f536:59fd:62a4:4bda] (unknown [IPv6:2001:470:1f0b:447:f536:59fd:62a4:4bda])
        by hauke-m.de (Postfix) with ESMTPSA id C809D8F60;
        Wed, 21 Nov 2012 22:05:50 +0100 (CET)
Message-ID: <50AD422C.50005@hauke-m.de>
Date:   Wed, 21 Nov 2012 22:05:48 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     ralf@linux-mips.org, john@phrozen.org
CC:     Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: BCM47XX: select BOOT_RAW
References: <1347806915-25132-1-git-send-email-hauke@hauke-m.de> <CAJiQ=7B+ohpoksFcH2Z9Twwc=3SbED1hSvssfmx5-kfb4dPJnQ@mail.gmail.com>
In-Reply-To: <CAJiQ=7B+ohpoksFcH2Z9Twwc=3SbED1hSvssfmx5-kfb4dPJnQ@mail.gmail.com>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 35074
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

On 09/16/2012 05:38 PM, Kevin Cernekee wrote:
> On Sun, Sep 16, 2012 at 7:48 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> All the boot loaders I have seen are booting the kernel in raw mode by
>> default. CFE seams to support elf kernel images too, but the default
> 
> Nitpick: "seems"
> 
>> case is raw for the devices I know of. Select this option to make the
>> kernel boot on most of the devices with the default options.
> 
> CONFIG_BOOT_RAW only adds about 8 bytes to the kernel image.  Since
> early 2008 it's just been implemented as a single jump instruction,
> and it's harmless on platforms that don't need it.
> 
> Do you think it is worthwhile to delete the Kconfig option, and enable
> BOOT_RAW behavior on all builds?
> 
Ralf should I change the patch to activate BOOT_RAW on all builds like
Kevin suggested?

I just came up with the small change in these patches to make the
bcm47xx SoC boot again without any other patches.

Hauke
