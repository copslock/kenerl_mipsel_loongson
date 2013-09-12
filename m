Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Sep 2013 09:34:00 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:47816 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867625Ab3ILHd5k24tl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Sep 2013 09:33:57 +0200
Message-ID: <52316E5D.4020100@phrozen.org>
Date:   Thu, 12 Sep 2013 09:33:49 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        ralf@linux-mips.org
Subject: Re: [PATCH v2] MIPS: GIC: Select R4K counter as fallback.
References: <1378929101-7021-1-git-send-email-Steven.Hill@imgtec.com> <52316D28.5000100@metafoo.de>
In-Reply-To: <52316D28.5000100@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 12/09/13 09:28, Lars-Peter Clausen wrote:
> On 09/11/2013 09:51 PM, Steven J. Hill wrote:
>> From: Leonid Yegoshin<Leonid.Yegoshin@imgtec.com>
>>
>> If CONFIG_CSRC_GIC is selected and the GIC is not found during
>> boot, then fallback to the R4K counter gracefully.
>
> Is there any reason not to always register the r4k clocksource, no matter
> whether the gic clocksource is present or not? The timekeeping core of the
> kernel will make sure to use the best available clocksource based on the
> clocksource's rating.
>
> - Lars

Hi,

in theory yes, but the r4k csrc is coded in a way that it always assumes 
to always be present and always be running.

	John
