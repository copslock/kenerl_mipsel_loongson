Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Feb 2013 19:30:31 +0100 (CET)
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56408 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827479Ab3BDSa2X3blS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Feb 2013 19:30:28 +0100
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DFCF68EE0E2;
        Mon,  4 Feb 2013 10:30:19 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CncHN6wDpoxw; Mon,  4 Feb 2013 10:30:19 -0800 (PST)
Received: from [172.25.2.120] (66-59-47-3.static-ip.telepacific.net [66.59.47.3])
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4F0CE8EE0E0;
        Mon,  4 Feb 2013 10:30:18 -0800 (PST)
Message-ID: <1360002617.2465.33.camel@dabdike>
Subject: Re: [PATCH RESEND 1/1] arch Kconfig: remove references to
 IRQ_PER_CPU
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Mike Frysinger <vapier@gentoo.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Mundt <lethal@linux-sh.org>
Date:   Mon, 04 Feb 2013 10:30:17 -0800
In-Reply-To: <1359972583-17134-1-git-send-email-james.hogan@imgtec.com>
References: <1359972583-17134-1-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.6.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-archive-position: 35703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@HansenPartnership.com
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

On Mon, 2013-02-04 at 10:09 +0000, James Hogan wrote:
> The IRQ_PER_CPU Kconfig symbol was removed in the following commit:
> 
> Commit 6a58fb3bad099076f36f0f30f44507bc3275cdb6 ("genirq: Remove
> CONFIG_IRQ_PER_CPU") merged in v2.6.39-rc1.
> 
> But IRQ_PER_CPU wasn't removed from any of the architecture Kconfig
> files where it was defined or selected. It's completely unused so remove
> the remaining references.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Acked-by: Tony Luck <tony.luck@intel.com>
> Acked-by: Richard Kuo <rkuo@codeaurora.org>

For what it's worth ACK, but I don't really think you need it since the
patch is trivial and obviously correct.

> 
> Does anybody want to pick this patch up?

I see Thomas already has.  Thanks, by the way, for not doing this as one
patch per architecture ...

James
