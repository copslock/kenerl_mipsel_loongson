Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 23:36:48 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:48981 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825710AbaABWgIGQ0ar (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jan 2014 23:36:08 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 098148F61;
        Thu,  2 Jan 2014 23:36:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z5ZfjqiITx7n; Thu,  2 Jan 2014 23:35:58 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:19e2:b924:c8e0:1c32] (unknown [IPv6:2001:470:1f0b:447:19e2:b924:c8e0:1c32])
        by hauke-m.de (Postfix) with ESMTPSA id 73E57857F;
        Thu,  2 Jan 2014 23:35:58 +0100 (CET)
Message-ID: <52C5E9CC.9040900@hauke-m.de>
Date:   Thu, 02 Jan 2014 23:35:56 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, blogic@openwrt.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/4] MIPS: BCM47XX: add board detection for Linksys WRT54GS
 V1
References: <1388687138-8107-1-git-send-email-hauke@hauke-m.de> <1388687138-8107-3-git-send-email-hauke@hauke-m.de> <CACna6rxX871CsHYw+-=J6nRZRnTNLFWAhLT9dweV=Z0Ut7y0vA@mail.gmail.com>
In-Reply-To: <CACna6rxX871CsHYw+-=J6nRZRnTNLFWAhLT9dweV=Z0Ut7y0vA@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38851
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

On 01/02/2014 09:53 PM, Rafał Miłecki wrote:
> 2014/1/2 Hauke Mehrtens <hauke@hauke-m.de>:
>> This adds board detection for Linksys WRT54GS V1.
> 
> Could you check NVRAM for something that could be more model specific?
> eou_device_id maybe?
> 
I already did that, but I could not find anything more specific.
This is a very old device, they tried to save space ;-)

Hauke
