Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Sep 2013 09:51:14 +0200 (CEST)
Received: from smtp-out-099.synserver.de ([212.40.185.99]:1034 "EHLO
        smtp-out-089.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6824790Ab3IMHvLBkBEF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Sep 2013 09:51:11 +0200
Received: (qmail 14120 invoked by uid 0); 13 Sep 2013 07:51:00 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 14021
Received: from ppp-188-174-159-27.dynamic.mnet-online.de (HELO ?192.168.178.23?) [188.174.159.27]
  by 217.119.54.77 with AES256-SHA encrypted SMTP; 13 Sep 2013 07:50:59 -0000
Message-ID: <5232C43D.7050503@metafoo.de>
Date:   Fri, 13 Sep 2013 09:52:29 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130827 Icedove/17.0.8
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v2] MIPS: GIC: Select R4K counter as fallback.
References: <1378929101-7021-1-git-send-email-Steven.Hill@imgtec.com> <52316D28.5000100@metafoo.de> <523206B9.6000201@imgtec.com>
In-Reply-To: <523206B9.6000201@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 09/12/2013 08:23 PM, Leonid Yegoshin wrote:
> On 09/12/2013 12:28 AM, Lars-Peter Clausen wrote:
>> On 09/11/2013 09:51 PM, Steven J. Hill wrote:
>>> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>>
>>> If CONFIG_CSRC_GIC is selected and the GIC is not found during
>>> boot, then fallback to the R4K counter gracefully.
>> Is there any reason not to always register the r4k clocksource, no matter
>> whether the gic clocksource is present or not? The timekeeping core of the
>> kernel will make sure to use the best available clocksource based on the
>> clocksource's rating.
>>
>> - Lars
> If you do power saving by switching some core OFF then you should do an
> additional clock sync after core revival.
> GIC is free from that but R4K is not. It was a primary reason for GIC
> clocksource.

Ok, but what I was saying is that there is no need to not register the r4k
clocksource if the gic clocksource is present since the kernel can deal with
multiple registered clocksources just fine. This is not a problem that needs
to be solved in MIPS specific code, if the rating for the clocksources is
set properly the kernel will switch to the gic clocksource as soon as it is
registered and ignore the r4k clocksource. No need to do any reference to
the gic in the r4k clocksource code.

- Lars
