Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Mar 2017 13:36:51 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56680 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993901AbdCVMgoBUaWj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Mar 2017 13:36:44 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2MCagKM014784;
        Wed, 22 Mar 2017 13:36:42 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2MCaf4n014783;
        Wed, 22 Mar 2017 13:36:41 +0100
Date:   Wed, 22 Mar 2017 13:36:41 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Amit Kama IL <Amit.Kama@satixfy.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH] Add initial SX3000b platform code to MIPS arch
Message-ID: <20170322123641.GN14919@linux-mips.org>
References: <AM4PR0201MB2179B0EE9D0C00461C999697E43C0@AM4PR0201MB2179.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM4PR0201MB2179B0EE9D0C00461C999697E43C0@AM4PR0201MB2179.eurprd02.prod.outlook.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Mar 22, 2017 at 05:38:09AM +0000, Amit Kama IL wrote:

> Add initial support for boards based on Satixfy's SX3000b (Catniss) SoC.
> The SoC includes a MIPS interAptiv dual core 4 VPE processor and boots 
> using device-tree.
> 
> Signed-off-by: Amit Kama <amit.kama@staixfy.com>
> 
> The irqchip file (irq-sx3000b.c) is pertinent to the platform. 
> IRQCHIP maintainers - is it possible to merge this through MIPS tree? 


First thig, run your patch through scripts/checkpatch.pl and fix the
resulting pile of errors and warnings.

sx3000_machine_halt() will consume plenty of power if implemented as a
empty loop:

+static void sx3000_machine_halt(void)
+{
+       while (true);
+}

Something like:

static void sx3000_machine_halt(void)
{
	local_irq_disable();
	while (1) {
		if (cpu_wait)
			cpu_wait();
	}
}

will make the function much "greener".

  Ralf
