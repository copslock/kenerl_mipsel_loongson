Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Nov 2012 13:47:13 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:37584 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823013Ab2KRMrNCnEAD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Nov 2012 13:47:13 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 4C2B98F61;
        Sun, 18 Nov 2012 13:47:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D5iFpu2NUFW9; Sun, 18 Nov 2012 13:47:07 +0100 (CET)
Received: from [192.168.178.21] (host-091-097-254-097.ewe-ip-backbone.de [91.97.254.97])
        by hauke-m.de (Postfix) with ESMTPSA id 563368F60;
        Sun, 18 Nov 2012 13:47:07 +0100 (CET)
Message-ID: <50A8D8C9.1000802@hauke-m.de>
Date:   Sun, 18 Nov 2012 13:47:05 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     ralf@linux-mips.org, john@phrozen.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, florian@openwrt.org
Subject: Re: [PATCH v4 0/3] MIPS: BCM47xx: use gpiolib
References: <1347376511-20953-1-git-send-email-hauke@hauke-m.de> <CACna6rw0Qy2=zo6wHcq20JBM8OJb-wnZJGLH3dksaLGFoyp+=w@mail.gmail.com>
In-Reply-To: <CACna6rw0Qy2=zo6wHcq20JBM8OJb-wnZJGLH3dksaLGFoyp+=w@mail.gmail.com>
X-Enigmail-Version: 1.4.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 35033
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

On 11/18/2012 12:05 PM, Rafał Miłecki wrote:
> 2012/9/11 Hauke Mehrtens <hauke@hauke-m.de>:
>> The original code implemented the GPIO interface itself and this caused
>> some problems. With this patch gpiolib is used.
>>
>> This is based on mips/master.
>>
>> This should go through linux-mips, John W. Linville approved that
>> for the bcma and ssb changes normally maintained in wireless-testing.
> 
> Ping? Did it go upstream? I can't find that commits in
> http://git.kernel.org/?p=linux/kernel/git/ralf/linux.git;a=summary
> 
I talked to John Crispin in IRC, he does not like this patch and I will
send a new version today.

Hauke
