Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 18:51:47 +0100 (CET)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45138 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493107Ab0ACRvn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jan 2010 18:51:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arm.linux.org.uk; s=caramon; h=Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:In-Reply-To:
        Sender; bh=CoWDwFVVkSra7nxerytlLCdGIVbkTrbpbACEiNiwq6w=; b=AT+8W
        +1jEis3yVJ6mMmbjrPSqt8VXj38S28zjRJmVtWhmhYrnNGFJuxTZgnKZyNBAgylp
        gaTuPRhloY3jZ0vbRDnrYhTQ5Nlmf2YRFde9FVibYMKVKCP1OjaNW+2EsgUySgMP
        DAkMB3qITjkC8reE6JzEBHrVyB+HG1u5LnNBK0=
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.69)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1NRUYF-00074e-US; Sun, 03 Jan 2010 17:47:40 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.69)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1NRUYD-00064H-Ht; Sun, 03 Jan 2010 17:47:37 +0000
Date:   Sun, 3 Jan 2010 17:47:37 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Hui Zhu <teawater@gmail.com>
Cc:     Arjan van de Ven <arjan@infradead.org>,
        saeed bishara <saeed.bishara@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        Chris Dearman <chris@mips.com>,
        Paul Gortmaker <Paul.Gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Brian Gerst <brgerst@gmail.com>, Tejun Heo <tj@kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Coly Li <coly.li@suse.de>
Subject: Re: [PATCH] stack2core: show stack message and convert it to core
        file when kernel die
Message-ID: <20100103174737.GD21156@n2100.arm.linux.org.uk>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com> <20100103160313.GA21156@n2100.arm.linux.org.uk> <daef60381001030830u176c0cfavbb31358a2b42ed60@mail.gmail.com> <20100103164414.GB21156@n2100.arm.linux.org.uk> <daef60381001030855o3a39c3fdr879e2634fb85c491@mail.gmail.com> <20100103092608.0a04c664@infradead.org> <daef60381001030939r60315c1dy56025a041a8ee758@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daef60381001030939r60315c1dy56025a041a8ee758@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1967

On Mon, Jan 04, 2010 at 01:39:44AM +0800, Hui Zhu wrote:
> scripts/markup_oops.pl just support x86?
> s2c support x86, x8664, arm, mips, mips64.

I'm sure there's patches around to make it work on ARM, or if not,
there soon will be.  There's certainly patches around at the moment
to make scripts/decodecode work on ARM.
