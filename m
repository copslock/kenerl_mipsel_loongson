Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2017 10:40:47 +0100 (CET)
Received: from smtpout.microchip.com ([198.175.253.82]:10728 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992186AbdBAJkkAmj1p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Feb 2017 10:40:40 +0100
Received: from [10.159.245.112] (10.10.76.4) by chn-sv-exch06.mchp-main.com
 (10.10.76.107) with Microsoft SMTP Server id 14.3.181.6; Wed, 1 Feb 2017
 02:40:31 -0700
Subject: Re: [PATCH 4.10-rc3 03/13] net: macb: fix build errors when
 linux/phy*.h is removed from net/dsa.h
To:     Russell King <rmk+kernel@armlinux.org.uk>,
        <linux-mips@linux-mips.org>, <linux-nfs@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <target-devel@vger.kernel.org>
References: <20170131191704.GA8281@n2100.armlinux.org.uk>
 <E1cYdws-0000W9-GV@rmk-PC.armlinux.org.uk>
CC:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>
From:   Nicolas Ferre <nicolas.ferre@atmel.com>
Organization: atmel
Message-ID: <0a75edf8-df17-fb7f-294f-8c1e04479a3b@atmel.com>
Date:   Wed, 1 Feb 2017 10:40:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <E1cYdws-0000W9-GV@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: =?utf-8?B?SDRzSUFBQUFBQUFBQytOZ0ZuckRLc1dSV2xHU1dwU1htS1BFeHNYQ3hlWERv?=
 =?utf-8?B?c3UvZG1LRVFlZjNtWnY1TGVhY2IyR3grUFh1Q0x2RmhLbVQyQzB1SERqTmF0?=
 =?utf-8?B?RjlmUWVieGFKbHJjd1diMWJjWWJjNHRrRE00bEwvUkNhTDFxVnZtUnk0UEM1?=
 =?utf-8?B?ZnU4anNzV1hsVFNhUG5iUHVzbnNjWGJtV3llUHpKcmtBMWlqV3pMeWsvSW9F?=
 =?utf-8?B?MW93N0w3SUtubkZWZkpyMWw3R0JjUkpuRnlNWGg1REFja2FKcFgrZU0zVXhj?=
 =?utf-8?B?bklJQytSSzdINitrQjBrSVNMd2pWSGk3c2FMckNBSklZRTBpZjdYZThGc1pv?=
 =?utf-8?B?RXdpYnNMbXRoQmJEWUJYWW16RTU2d2RURnljUEFMQ0V1Y21Sb1BFdVlWc0pF?=
 =?utf-8?B?NHVQOExJNGpOSXFBaU1XUCtkVmFRRWxHQkNJbUd3K2tRSllJU0oyYytZUUd4?=
 =?utf-8?B?T1FYTUpRN3N2QUpXd2l5Z0tiRitsejdFSW5tSjVxMnptU0VPVUpIb2U5OFB0?=
 =?utf-8?B?bFJDSUZCaStjUjlMQkMyazhUL2xUT2g0bllTaDZkZmhMSWRKTzdmbjhFR1Uz?=
 =?utf-8?B?Tnc2M01vVzF0aSs2dDlyQkMyanNTMmcvMVFjMndsOXN5WXlBUmh1MHM4ZUxR?=
 =?utf-8?B?Y3l2YVZtUFd3QWFvbVN1SlUvMmZXQ1l4U3M1QjhNQXZoNmxsSXJsN0F5THlL?=
 =?utf-8?B?VWRyWncwODNPRXpYTmNMWnc4Qk1MemM1bzBBM056RXpUeTg1UDNjVEl5VGVz?=
 =?utf-8?B?M2N3SHBrZmNZaFJrb05KU1pRM3ZXTkNoQkJmVW41S1pVWmljVVo4VVdsT2F2?=
 =?utf-8?B?RWhSaGtPRGlVSjNoK3JKMFlJQ1JhbHBxZFdwR1htQUJNUFRKcUpnL01Rb3dR?=
 =?utf-8?B?SGo1SUk3ejZRR3Q3aWdzVGM0c3gwaVB3cFJra3BjZDZ6SUFrQmtFUkdhUjVj?=
 =?utf-8?B?N3lWR1VTbGhYdVdsUURtZWd0U2kzTXdTaVBndFJqR09oMHdjajVtRVdQTHk4?=
 =?utf-8?B?MUtsZ0U1bEFBSUR4bGVNNGh5TVNzSzhyU0RqZURMelN1RFd2QUs2Z0Fub0F2?=
 =?utf-8?B?ZFhmU0FYbENRaXBLUWFHR05tYVYveVhKUlZtT1Y5NHFXc1UvZjY0by9mTjgr?=
 =?utf-8?B?YTd6M2xSMCtNNXdwVjI5Y2ZMMld1VG5SaDlKbSs2OWFEQzZkZUxieDM2NnZM?=
 =?utf-8?B?NHJrVGxwU3FOcHZ0MVE4emZOR3pZTm4wV1NzcTEzU3Bya2t2ZTk3RS8yMysz?=
 =?utf-8?B?TmwzUHY4VGVaelhvZnk0M3VIK1pLL3JIMFVYK0J4NXpzTnc3bU9CMVhyZnh1?=
 =?utf-8?B?QWREOHRkMW1mK3k2bTZFMzVVaWFVNEk5RlFpN21vT0JFQXV5MDNyWDhEQUFB?=
 =?utf-8?Q?=3D?=
Return-Path: <nicolas.ferre@atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nicolas.ferre@atmel.com
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

Le 31/01/2017 à 20:18, Russell King a écrit :
> drivers/net/ethernet/cadence/macb.h:862:33: sparse: expected ; at end of declaration
> drivers/net/ethernet/cadence/macb.h:862:33: sparse: Expected } at end of struct-union-enum-specifier
> drivers/net/ethernet/cadence/macb.h:862:33: sparse: got phy_interface
> drivers/net/ethernet/cadence/macb.h:877:1: sparse: Expected ; at the end of type declaration
> drivers/net/ethernet/cadence/macb.h:877:1: sparse: got }
> In file included from drivers/net/ethernet/cadence/macb_pci.c:29:0:
> drivers/net/ethernet/cadence/macb.h:862:2: error: unknown type name 'phy_interface_t'
>      phy_interface_t  phy_interface;
>      ^~~~~~~~~~~~~~~
> 
> Add linux/phy.h to macb.h
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/net/ethernet/cadence/macb.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index d67adad67be1..383da8cf5f6d 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -10,6 +10,8 @@
>  #ifndef _MACB_H
>  #define _MACB_H
>  
> +#include <linux/phy.h>
> +
>  #define MACB_GREGS_NBR 16
>  #define MACB_GREGS_VERSION 2
>  #define MACB_MAX_QUEUES 8
> 


-- 
Nicolas Ferre
