Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 00:45:23 +0100 (CET)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:38737 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008027AbbLAXpWMAF9y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2015 00:45:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=gW+btQ6MZseEHLxtOVd+CXO1epPCaUW4rXUnrXLTEQg=;
        b=m/rAsyvX6Omc0/Ivg5nxjNZk25kPKM8T4LuyRC4sra5jnkO6/AlCBi1L5jLMR4K1JWEeH116Iy/mooKrvYgVHKH8r8rfWCIo2qQJPDiHdTi4v6DcD2ZH5vp26y0O0zIXafE0bM55BqNgW2W4f8ac+j4MpapMMTkBvnA1w4bg+1w=;
Received: from n2100.arm.linux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:49423)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1a3ubC-00080R-QO; Tue, 01 Dec 2015 23:44:42 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1a3ub9-0000JO-27; Tue, 01 Dec 2015 23:44:39 +0000
Date:   Tue, 1 Dec 2015 23:44:37 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Petr Mladek <pmladek@suse.cz>
Subject: Re: [PATCH v2 3/5] printk/nmi: Try hard to print Oops message in NMI
 context
Message-ID: <20151201234437.GA8644@n2100.arm.linux.org.uk>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-4-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448622572-16900-4-git-send-email-pmladek@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50266
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

On Fri, Nov 27, 2015 at 12:09:30PM +0100, Petr Mladek wrote:
> What we can do, though, is to zap all printk locks. We already do this
> when a printk recursion is detected. This should be safe because
> the system is crashing and there shouldn't be any printk caller
> that would cause the deadlock.

What about serial consoles which may call out to subsystems like the
clk subsystem to enable a clock, which would want to take their own
spinlocks in addition to the serial console driver?

I don't see bust_spinlocks() dealing with any of these locks, so IMHO
trying to make this work in NMI context strikes me as making the
existing solution more unreliable on ARM systems.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
