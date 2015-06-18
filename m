Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jun 2015 03:05:01 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:55164 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008768AbbFRBFACjPb5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jun 2015 03:05:00 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E4BDB1400CD;
        Thu, 18 Jun 2015 01:04:57 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id C7C511400D8; Thu, 18 Jun 2015 01:04:57 +0000 (UTC)
Received: from [10.134.64.202] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E0BF1400CD;
        Thu, 18 Jun 2015 01:04:55 +0000 (UTC)
Message-ID: <55821936.4040704@codeaurora.org>
Date:   Wed, 17 Jun 2015 18:04:54 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
CC:     linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
        linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
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
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net> <1412659726-29957-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1412659726-29957-2-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47962
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

On 10/06/2014 10:28 PM, Guenter Roeck wrote:
> Various drivers implement architecture and/or device specific means to
> remove power from the system.  For the most part, those drivers set the
> global variable pm_power_off to point to a function within the driver.
>
> This mechanism has a number of drawbacks.  Typically only one scheme
> to remove power is supported (at least if pm_power_off is used).
> At least in theory there can be multiple means remove power, some of
> which may be less desirable. For example, some mechanisms may only
> power off the CPU or the CPU card, while another may power off the
> entire system.  Others may really just execute a restart sequence
> or drop into the ROM monitor. Using pm_power_off can also be racy
> if the function pointer is set from a driver built as module, as the
> driver may be in the process of being unloaded when pm_power_off is
> called. If there are multiple poweroff handlers in the system, removing
> a module with such a handler may inadvertently reset the pointer to
> pm_power_off to NULL, leaving the system with no means to remove power.
>
> Introduce a system poweroff handler call chain to solve the described
> problems.  This call chain is expected to be executed from the
> architecture specific machine_power_off() function.  Drivers providing
> system poweroff functionality are expected to register with this call chain.
> By using the priority field in the notifier block, callers can control
> poweroff handler execution sequence and thus ensure that the poweroff
> handler with the optimal capabilities to remove power for a given system
> is called first.

What happened to this series? I want to add shutdown support to my
platform and I need to write a register on the PMIC in one driver to
configure it for shutdown instead of restart and then write an MMIO
register to tell the PMIC to actually do the shutdown in another driver.
It seems that the notifier solves this case for me, albeit with the
slight complication that I need to order the two with some priority.

I'm also considering putting the PMIC configuration part into the reboot
notifier chain, because it only does things to change the configuration
and not actually any shutdown/restart itself. That removes any
requirement to get the priority of notifiers right. This series will
still be useful for the MMIO register that needs to be toggled though.
Right now I have to assign pm_power_off or hook the reboot notifier with
a different priority to make this work.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
