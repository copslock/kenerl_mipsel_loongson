Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jan 2013 11:42:33 +0100 (CET)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47071 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817419Ab3AEKmcNhF-v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Jan 2013 11:42:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=jbSseclF9gdDoy8T9I67kyHqUdPYmyudsA98UVl52Tc=;
        b=cy2cx5ne6AL1+JSmLXYwQxU8ety66/XHcxRZQVaIMS/wMeYSHFyItZmgPwNQBo3xzXF8ZPsgrZsPSk10Hpqnjz9NwJVANtAAbELYAvfA2/glvajaDy5bYkZW2ECvpg11KI/TjgWnzaVvDiwG6+peihdJ9MFzL31XTT1Gn2Us00g=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:36638)
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.76)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1TrR77-0005SY-D3; Sat, 05 Jan 2013 10:36:29 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1TrR76-0000Qo-0m; Sat, 05 Jan 2013 10:36:28 +0000
Date:   Sat, 5 Jan 2013 10:36:27 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        Mike Frysinger <vapier@gentoo.org>,
        uclinux-dist-devel@blackfin.uclinux.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, mhocko@suse.cz,
        srivatsa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] cpuhotplug/nohz: Remove offline cpus from
        nohz-idle state
Message-ID: <20130105103627.GU2631@n2100.arm.linux.org.uk>
References: <1357268318-7993-1-git-send-email-vatsa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1357268318-7993-1-git-send-email-vatsa@codeaurora.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-archive-position: 35378
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Jan 03, 2013 at 06:58:38PM -0800, Srivatsa Vaddagiri wrote:
> I also think that the
> wait_for_completion() based wait in ARM's __cpu_die() can be replaced with a
> busy-loop based one, as the wait there in general should be terminated within
> few cycles.

Why open-code this stuff when we have infrastructure already in the kernel
for waiting for stuff to happen?  I chose to use the standard infrastructure
because its better tested, and avoids having to think about whether we need
CPU barriers and such like to ensure that updates are seen in a timely
manner.

My stance on a lot of this idle/cpu dying code is that much of it can
probably be cleaned up and merged into a single common implementation -
in which case the use of standard infrastructure for things like waiting
for other CPUs do stuff is even more justified.
