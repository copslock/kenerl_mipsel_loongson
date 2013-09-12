Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Sep 2013 08:25:42 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:17445 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816671Ab3IMGZj63Csy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Sep 2013 08:25:39 +0200
Message-ID: <523206B9.6000201@imgtec.com>
Date:   Thu, 12 Sep 2013 11:23:53 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: GIC: Select R4K counter as fallback.
References: <1378929101-7021-1-git-send-email-Steven.Hill@imgtec.com> <52316D28.5000100@metafoo.de>
In-Reply-To: <52316D28.5000100@metafoo.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
X-SEF-Processed: 7_3_0_01192__2013_09_13_07_24_34
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 09/12/2013 12:28 AM, Lars-Peter Clausen wrote:
> On 09/11/2013 09:51 PM, Steven J. Hill wrote:
>> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>
>> If CONFIG_CSRC_GIC is selected and the GIC is not found during
>> boot, then fallback to the R4K counter gracefully.
> Is there any reason not to always register the r4k clocksource, no matter
> whether the gic clocksource is present or not? The timekeeping core of the
> kernel will make sure to use the best available clocksource based on the
> clocksource's rating.
>
> - Lars
If you do power saving by switching some core OFF then you should do an 
additional clock sync after core revival.
GIC is free from that but R4K is not. It was a primary reason for GIC 
clocksource.

- Leonid.
