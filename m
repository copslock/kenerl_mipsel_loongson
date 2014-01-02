Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 23:35:31 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:48964 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825710AbaABWfSR0aWg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jan 2014 23:35:18 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 6E3E28F61;
        Thu,  2 Jan 2014 23:35:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UAwVWMVMiXpV; Thu,  2 Jan 2014 23:35:13 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:19e2:b924:c8e0:1c32] (unknown [IPv6:2001:470:1f0b:447:19e2:b924:c8e0:1c32])
        by hauke-m.de (Postfix) with ESMTPSA id 8A729857F;
        Thu,  2 Jan 2014 23:35:12 +0100 (CET)
Message-ID: <52C5E99E.1090408@hauke-m.de>
Date:   Thu, 02 Jan 2014 23:35:10 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, blogic@openwrt.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/4] MIPS: BCM47XX: fix detection for some boards
References: <1388687138-8107-1-git-send-email-hauke@hauke-m.de> <1388687138-8107-2-git-send-email-hauke@hauke-m.de> <CACna6rw3Y7GwitM4nma+MHVj1spqOyv1F4GWJtaA+e5TTHjnug@mail.gmail.com>
In-Reply-To: <CACna6rw3Y7GwitM4nma+MHVj1spqOyv1F4GWJtaA+e5TTHjnug@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38850
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

On 01/02/2014 09:47 PM, Rafał Miłecki wrote:
> 2014/1/2 Hauke Mehrtens <hauke@hauke-m.de>:
>> When a nvram reset was performed from CFE, it sometimes does not
>> contain the productid value in nvram, but it still contains
>> hardware_version.
> 
> It seems you switched to a very solid detection with that.
> 
> Why not remove old entries?
> 
Yes I will remove them.

Hauke
