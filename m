Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Nov 2013 16:58:57 +0100 (CET)
Received: from avon.wwwdotorg.org ([70.85.31.133]:42458 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823079Ab3KAP6zOo91x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Nov 2013 16:58:55 +0100
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id 379FB6414;
        Fri,  1 Nov 2013 09:58:53 -0600 (MDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id 0CD98E462D;
        Fri,  1 Nov 2013 09:58:50 -0600 (MDT)
Message-ID: <5273CFB9.1080603@wwwdotorg.org>
Date:   Fri, 01 Nov 2013 09:58:49 -0600
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To:     Domenico Andreoli <domenico.andreoli@linux.com>,
        linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/11] RFC: Common machine reset handling
References: <20131031062708.520968323@linux.com> <5272D05E.1070207@wwwdotorg.org> <20131101051610.GA28233@glitch>
In-Reply-To: <20131101051610.GA28233@glitch>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.97.8 at avon.wwwdotorg.org
X-Virus-Status: Clean
Return-Path: <swarren@wwwdotorg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: swarren@wwwdotorg.org
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

On 10/31/2013 11:16 PM, Domenico Andreoli wrote:
> On Thu, Oct 31, 2013 at 03:49:18PM -0600, Stephen Warren wrote:
>> On 10/31/2013 12:27 AM, Domenico Andreoli wrote:
>>> Hi,
>>>
>>>   I've been looking for a solution to my bcm4760 watchdog based restart
>>> hook when I noticed that the kernel reboot/shutdown mechanism is having
>>> a few unaddressed issues.
>>>
>>> Those I identified are:
>>>
>>>  1) context pointer often needed by the reset hook
>>>     (currently local static data is used for this pourpose)
>>>  2) unclear ownership/policy in case of multiple reset hooks
>>>     (currently almost nobody seems to care much)
>>
>> I'm not sure how this patchset solves (2); even with the new API, it's
>> still the case that whichever code calls set_machine_reset() last wins,
>> just like before where whichever code wrote to pm_power_off won. I'm not
>> sure what this series attempts to solve.
> 
> That's right, the last wins. But the previous has a chance to know.
> 
> I only supposed there is somebody in charge of selecting the best handler
> for the machine. Don't know how fancy this decision is but at least for
> the vexpress there is also a sysfs way to configure different reset methods
> from user-space.

For PMICs that provide power off, we've been adding a property to DT to
indicate whether the PMIC is *the* system power off controller or not.
If the property is present, the PMIC registers itself in the poweroff
hook. If not, it doesn't. So, there really isn't an algorithm for
selecting the power off mechanism, but rather we designate one mechanism
ahead of time, and that's the only one that's relevant. We could
probably do the same for reset mechanisms.

I guess the vexpress situation is actually the same; there's a single
concept of a custom vexpress reset, it's just that sysfs is used to
select exactly what that does?

> So cleaning up things after the handler is replaced seemed a sensible
> thing to do.

Can't we avoid replacing handlers, but only registering a single handler?

> Another "problem" this patch would solve is the registration of the
> reset handler in a architecture independent way. Now an otherwise platform
> generic gpio HW reset driver would need to do different things on different
> architectures.

OK, if there are architecture differences in how the hooks are
registered, that seems like a good thing to fix.
