Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jun 2015 23:40:27 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:54334 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008070AbbFRVkYSymJp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jun 2015 23:40:24 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0D7111408DE;
        Thu, 18 Jun 2015 21:40:22 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id E0F321408E3; Thu, 18 Jun 2015 21:40:21 +0000 (UTC)
Received: from [10.134.64.202] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3EA901408DE;
        Thu, 18 Jun 2015 21:40:20 +0000 (UTC)
Message-ID: <55833AC2.5080700@codeaurora.org>
Date:   Thu, 18 Jun 2015 14:40:18 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Guenter Roeck <linux@roeck-us.net>
CC:     linux-kernel@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org,
        linux-mips@linux-mips.org, linux-efi@vger.kernel.org,
        linux-ia64@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Len Brown <len.brown@intel.com>, linux-xtensa@linux-xtensa.org,
        Pavel Machek <pavel@ucw.cz>, devel@driverdev.osuosl.org,
        linux-s390@vger.kernel.org, lguest@lists.ozlabs.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-sh@vger.kernel.org, Alexander Graf <agraf@suse.de>,
        linux-acpi@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        xen-devel@lists.xenproject.org, devicetree@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-pm@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
        linux-tegra@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-alpha@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Romain Perier <romain.perier@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/44] kernel: Add support for poweroff handler call chain
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net> <1412659726-29957-2-git-send-email-linux@roeck-us.net> <55821936.4040704@codeaurora.org> <20150618153003.GA19224@roeck-us.net>
In-Reply-To: <20150618153003.GA19224@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@codeaurora.org
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

On 06/18/2015 08:30 AM, Guenter Roeck wrote:
> On Wed, Jun 17, 2015 at 06:04:54PM -0700, Stephen Boyd wrote:
> [ ... ]
>> What happened to this series? I want to add shutdown support to my
>> platform and I need to write a register on the PMIC in one driver to
>> configure it for shutdown instead of restart and then write an MMIO
>> register to tell the PMIC to actually do the shutdown in another driver.
>> It seems that the notifier solves this case for me, albeit with the
>> slight complication that I need to order the two with some priority.
>>
> Can you use the .shutdown driver callback instead ?
>
> I see other drivers use that, and check for system_state == SYSTEM_POWER_OFF
> to power off the hardware.
>

Yes I think that will work. I'll still have to hook pm_power_off() for
the mmio register, but I guess that's ok and I don't need to worry about
this series then.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
