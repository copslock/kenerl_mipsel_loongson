Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Feb 2017 23:36:29 +0100 (CET)
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:41212 "EHLO
        1.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992143AbdBOWgVw8o9p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Feb 2017 23:36:21 +0100
Received: from player711.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id 91FAB3CCEF
        for <linux-mips@linux-mips.org>; Wed, 15 Feb 2017 23:36:21 +0100 (CET)
Received: from linux-samsung.lan (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player711.ha.ovh.net (Postfix) with ESMTPSA id 0EE03380073;
        Wed, 15 Feb 2017 23:36:17 +0100 (CET)
Subject: Re: [PATCH] MIPS: bcm47xx: Fix button inversion for Asus WL-500W
To:     Mirko Parthey <mirko.parthey@web.de>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20170215223130.GA18959@guitar.localdomain>
Cc:     linux-mips@linux-mips.org
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Message-ID: <48d3fda8-aad1-b90a-03d2-c8e999fdcbb8@milecki.pl>
Date:   Wed, 15 Feb 2017 23:36:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170215223130.GA18959@guitar.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15556840491472752290
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelhedrtdefgddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Return-Path: <rafal@milecki.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rafal@milecki.pl
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

On 02/15/2017 11:31 PM, Mirko Parthey wrote:
> The Asus WL-500W buttons are active high,
> but the software treats them as active low.
> Fix the inverted logic.
>
> Signed-off-by: Mirko Parthey <mirko.parthey@web.de>

Acked-by: Rafał Miłecki <rafal@milecki.pl>
