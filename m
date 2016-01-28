Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2016 18:42:55 +0100 (CET)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:35108 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011283AbcA1RmyVSUUq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jan 2016 18:42:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=mnoN6THzjRojzkiX4S9CeMPjqb392NyRUM4r7fDFK/8=;
        b=lkcimeY6o+WQPWn+xsTiOzxQO7SZSQq//ezvdNrZgJUVK4rcFmutdJN1GwDdQwMVtL38vz42qAKwOvaEtTKOpxdOgzQLuO+cWIt4fEpTCdLOl8QwO0NDazpanFoT6nFQf+zKevSj3j8ut5Tse9cjHSsRd5Ja1MyuiCRxZsIcZ9U=;
Received: from n2100.arm.linux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:43204)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1aOqaj-0004G5-8I; Thu, 28 Jan 2016 17:42:45 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1aOqaf-0004tc-PF; Thu, 28 Jan 2016 17:42:41 +0000
Date:   Thu, 28 Jan 2016 17:42:41 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-kbuild@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Marek <mmarek@suse.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re:
 [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Message-ID: <20160128174241.GN10826@n2100.arm.linux.org.uk>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
 <1947556.38OyJnvGS5@wuerfel>
 <20160127093018.GA21190@wfg-t540p.sh.intel.com>
 <3596300.IYfzmako0c@wuerfel>
 <20160128031435.GA25625@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160128031435.GA25625@wfg-t540p.sh.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51510
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

On Thu, Jan 28, 2016 at 11:14:35AM +0800, Fengguang Wu wrote:
> On Wed, Jan 27, 2016 at 10:44:01AM +0100, Arnd Bergmann wrote:
> > - CONFIG_PHYS_OFFSET needs to be entered manually to be a number
> >   in 'make config'
> 
> That's a problem for auto tests.

I'm really against the idea of providing some kind of "default" to it.
Not providing a default means that people _have_ to do some research
for their particular system in order to provide a value, and they're
more likely to get the right value.  Providing a default will lead to
the assumption that the value is okay, and then we'll end up with
people complaining that their kernel doesn't boot, and is totally
silent.

The only default I'd accept is one based on the rest of the config -
in other words, re-introducing all the physical address of RAM that
we used to have in the mach/memory.h files...

There's other ways around these kinds of things, the Kconfig system
does allow a Kconfig fragment which can be used to pre-set some
configuration options to particular values - and so which can be used
to set CONFIG_PHYS_OFFSET prior to an allrandconfig or similar.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
