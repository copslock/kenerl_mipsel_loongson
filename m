Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jun 2015 13:54:22 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:55254 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008980AbbFRLyUlC069 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jun 2015 13:54:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=6zYGZVbEE3qPmjrYW1AoBlXyEYenSDBLmKHlr+bUOik=;
        b=KJz1dMLkhESHOeLFx4DneNIoabhRUQRYzGIWayqDznbIohzD95mbr4fNbodX+vE4mX34vwLTsOofdCsKwz7yiSbMVLvf//fEkV7cM59xxLFR0jLGiKhVq0ixEYbB1YsQSDSQiXgjycj2eyRVzjI8tAzAvKBD/y3fJLdjwwNNWx4=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:34229 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1Z5YOT-000jxy-Ir; Thu, 18 Jun 2015 11:54:06 +0000
Message-ID: <5582B15B.4010205@roeck-us.net>
Date:   Thu, 18 Jun 2015 04:54:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Frans Klaver <fransklaver@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
        linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>, linux-sh@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, devel@driverdev.osuosl.org,
        linux-s390@vger.kernel.org, lguest@lists.ozlabs.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        Alexander Graf <agraf@suse.de>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        xen-devel@lists.xenproject.org, Len Brown <len.brown@intel.com>,
        user-mode-linux-devel@lists.sourceforge.net,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
        linux-tegra@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-cris-kernel@axis.com, linux-parisc@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-alpha@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Romain Perier <romain.perier@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/44] kernel: Add support for poweroff handler call chain
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>      <1412659726-29957-2-git-send-email-linux@roeck-us.net>  <55821936.4040704@codeaurora.org> <CAH6sp9P7rq2y_hiQPHKUP85CwnEmp87yC7Psh4=29h-pYnb_yw@mail.gmail.com>
In-Reply-To: <CAH6sp9P7rq2y_hiQPHKUP85CwnEmp87yC7Psh4=29h-pYnb_yw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 06/17/2015 11:53 PM, Frans Klaver wrote:
> On Thu, Jun 18, 2015 at 3:04 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> On 10/06/2014 10:28 PM, Guenter Roeck wrote:
>>> Various drivers implement architecture and/or device specific means to
>>> remove power from the system.  For the most part, those drivers set the
>>> global variable pm_power_off to point to a function within the driver.
>>>
>>> This mechanism has a number of drawbacks.  Typically only one scheme
>>> to remove power is supported (at least if pm_power_off is used).
>>> At least in theory there can be multiple means remove power, some of
>>> which may be less desirable. For example, some mechanisms may only
>>> power off the CPU or the CPU card, while another may power off the
>>> entire system.  Others may really just execute a restart sequence
>>> or drop into the ROM monitor. Using pm_power_off can also be racy
>>> if the function pointer is set from a driver built as module, as the
>>> driver may be in the process of being unloaded when pm_power_off is
>>> called. If there are multiple poweroff handlers in the system, removing
>>> a module with such a handler may inadvertently reset the pointer to
>>> pm_power_off to NULL, leaving the system with no means to remove power.
>>>
>>> Introduce a system poweroff handler call chain to solve the described
>>> problems.  This call chain is expected to be executed from the
>>> architecture specific machine_power_off() function.  Drivers providing
>>> system poweroff functionality are expected to register with this call chain.
>>> By using the priority field in the notifier block, callers can control
>>> poweroff handler execution sequence and thus ensure that the poweroff
>>> handler with the optimal capabilities to remove power for a given system
>>> is called first.
>>
>> What happened to this series? I want to add shutdown support to my
>> platform and I need to write a register on the PMIC in one driver to
>> configure it for shutdown instead of restart and then write an MMIO
>> register to tell the PMIC to actually do the shutdown in another driver.
>> It seems that the notifier solves this case for me, albeit with the
>> slight complication that I need to order the two with some priority.
>
> I was wondering the same thing. I did find out that things kind of
> stalled after Linus cast doubt on the chosen path [1]. I'm not sure
> there's any consensus on what would be best to do instead.
>

Linus cast doubt on it, then the maintainers started picking it apart.
At the end, trying not to use notifier callbacks made the code so
complicated that even I didn't understand it anymore. With no consensus
in sight, I abandoned it.

Problem is really that the notifier call chain would be perfect to solve
the problem, yet Linus didn't like priorities (which are essential),
and the power maintainers didn't like that a call chain is supposed
to execute _all_ callbacks, which would not be the case here. If I were
to start again, I would insist to use notifiers. However, I don't see
a chance to get that accepted, so I won't. Feel free to pick it up and
give it a try yourself.

Thanks,
Guenter
