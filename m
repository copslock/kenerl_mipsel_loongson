Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Nov 2013 17:13:22 +0100 (CET)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35403 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827346Ab3KAQNQXUiO2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Nov 2013 17:13:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Bl81PLwMk4wuSND12wBj2JPjTOJohLjKnBl+AL+gsMU=;
        b=ceefJS42i9u9U/cJps4vVpF2aO6+o2EHTK9h58+wTUfr4/5slP2wpAIqqHLA/5YbD/KV/yyJ5TZbFpim8BSVc90hxKCOl+OFnD8aqqpuQNDXIR3JWMUA63hHF8c/ecd4EY3WPuxD4hKJoqmsy9Rsie30+zk8BtvsLALMPETQjFg=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:56354)
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.76)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1VcHL7-0006g4-Kr; Fri, 01 Nov 2013 16:12:50 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1VcHL5-0005fi-Ja; Fri, 01 Nov 2013 16:12:47 +0000
Date:   Fri, 1 Nov 2013 16:12:47 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     Domenico Andreoli <domenico.andreoli@linux.com>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/11] RFC: Common machine reset handling
Message-ID: <20131101161246.GM16735@n2100.arm.linux.org.uk>
References: <20131031062708.520968323@linux.com> <5272D05E.1070207@wwwdotorg.org> <20131101051610.GA28233@glitch> <5273CFB9.1080603@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5273CFB9.1080603@wwwdotorg.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
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

On Fri, Nov 01, 2013 at 09:58:49AM -0600, Stephen Warren wrote:
> For PMICs that provide power off, we've been adding a property to DT to
> indicate whether the PMIC is *the* system power off controller or not.
> If the property is present, the PMIC registers itself in the poweroff
> hook. If not, it doesn't. So, there really isn't an algorithm for
> selecting the power off mechanism, but rather we designate one mechanism
> ahead of time, and that's the only one that's relevant. We could
> probably do the same for reset mechanisms.
> 
> I guess the vexpress situation is actually the same; there's a single
> concept of a custom vexpress reset, it's just that sysfs is used to
> select exactly what that does?

I'm not aware of that.  Vexpress has the following mechanisms:

- reset - this causes the system to be restarted without powering off.
- restart - this causes the system to be powered off and back on.
- poweroff - this causes the system to power off.

Obviously, poweroff is what needs to happen when someone issues the
poweroff command (or, when we get hibernate support, the power off
hook will also be called to power the system off after saving all
system state.)  So, a power off callback really better power the
system off and not reboot it.

reset vs restart is a choice, and one of those should happen as a result
of the reboot command, or other similar event which ends up requesting
a system restart.  That may be configurable.

Ultimately though, this should have no bearing on the hooking of poweroff
and restart callbacks; the only difference there is on Vexpress is the
function code passed to the system controller.
