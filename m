Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2016 22:46:42 +0100 (CET)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:38156 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011231AbcA2VqlXyeqc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2016 22:46:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=K22SRb9VGoagAljw/y6oR7wP6ycaYkF0ytJ2rj1mvV4=;
        b=FvXAj7xqVp6SB3hET8HvCP56GzZGhlmIkl1Ldx+rg8Cyg0UO5XAGYDDp9snfMXLEWxHuUPXHc0bLEfa+cV/JccjhsoBYWDUk4vjFuPvHAgQsE7f4QfXCq/v0xxXCc6lRk3C0aCS75C3rd6ORCmhZxFZPfr89lyrTI++4VB80KDo=;
Received: from n2100.arm.linux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:45607)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1aPGs7-0006Ao-Gy; Fri, 29 Jan 2016 21:46:27 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1aPGs3-0003hv-8e; Fri, 29 Jan 2016 21:46:23 +0000
Date:   Fri, 29 Jan 2016 21:46:22 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Fengguang Wu <fengguang.wu@intel.com>, linux-arch@vger.kernel.org,
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
Message-ID: <20160129214622.GS10826@n2100.arm.linux.org.uk>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
 <20160128031435.GA25625@wfg-t540p.sh.intel.com>
 <20160128174241.GN10826@n2100.arm.linux.org.uk>
 <7619136.niuXthzi6R@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7619136.niuXthzi6R@wuerfel>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51532
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

On Fri, Jan 29, 2016 at 12:07:21AM +0100, Arnd Bergmann wrote:
> This doesn't sound too hard. I've picked the defaults out of the
> git history in the patch below. The only tricky part was davinci,
> which has two different addresses and requires a little rework
> to avoid circular dependencies.

I think there's a much better way to solve this.

How about we have an architecture-defined way to provide all*config
with a set of settings to be used with Kconfig to define these
integer settings, rather than papering over the problem making up
random addresses (like you're doing for the debug stuff.)  Eg,
a default architecture-provided setting for KCONFIG_ALLCONFIG
that defines things such as the physical offset and the debug
addresses to be used for all*config targets?

Surely that's better than hacking around with the Kconfig files
trying to frig something into working, which can potentially confuse
people.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
