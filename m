Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 05:18:01 +0100 (CET)
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54032 "EHLO
        mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006516AbaKGER7oHH5l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 05:17:59 +0100
Received: from pool-96-249-243-124.nrflva.fios.verizon.net ([96.249.243.124] helo=titan)
        by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <jason@lakedaemon.net>)
        id 1Xmaza-0004Qz-PZ; Fri, 07 Nov 2014 04:17:46 +0000
Received: from titan.lakedaemon.net (localhost [127.0.0.1])
        by titan (Postfix) with ESMTP id CE174613F6F;
        Thu,  6 Nov 2014 23:17:42 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 96.249.243.124
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19AEvorYSdVIl0OqVdjlI33+CiaQJpYWO4=
X-DKIM: OpenDKIM Filter v2.0.1 titan CE174613F6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1415333862;
        bh=p0PCwfeHExreB0G6M/UNlH4tve0hXOanG1nRttFOr2o=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=AoWipwu+okReArdoyCwoDyzC7XPFxMMeJe0Fu0BC2kqHoli9Ti16jPBqP8eIozUAP
         +oZSJmepmg4BpweXGwFZmum9PSFFgnxpGXFgduC+FE8aj5QfNXlcNB9BqRJYlHmyxh
         Zs3F3fhSegLRJSGK79nIBA0sLPVGc9T8hHbvd25eN+/NIs/PmOtFtHG4t2Mkzl+OaB
         7d6bK0oT/Mfj/PL1stVOJitmNl0ODskqm31a+hIH8w0x7UsplKnqMaRiw18z0PdR2w
         KtfUERtWZyrNt3lDqpXq6xCyv1FI4Yl3rjIb34ekgoNCM+8QqItGbYCCu7m0aQxUm4
         3L5+H4f5Jlggw==
Date:   Thu, 6 Nov 2014 23:17:42 -0500
From:   Jason Cooper <jason@lakedaemon.net>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 3/4] irqchip: mips-gic: Add device-tree support
Message-ID: <20141107041742.GH3698@titan.lakedaemon.net>
References: <1414624790-15690-1-git-send-email-abrestic@chromium.org>
 <1414624790-15690-4-git-send-email-abrestic@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1414624790-15690-4-git-send-email-abrestic@chromium.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

Andrew,

On Wed, Oct 29, 2014 at 04:19:49PM -0700, Andrew Bresticker wrote:
> Add device-tree support for the MIPS GIC.  Update the GIC irqdomain's
> xlate() callback to handle the three-cell specifier described in the
> MIPS GIC binding document.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Changes from v3:
>  - use reserved-cpu-vectors property
>  - read GIC base from CM if no reg property present
> Changes from v2:
>  - rebased on GIC irqchip cleanups
>  - updated for change in bindings
>  - only parse first CPU vector
>  - allow platforms to use EIC mode
> Changes from v1:
>  - updated for change in bindings
>  - set base address and enable bit in GCR_GIC_BASE
> ---
>  drivers/irqchip/irq-mips-gic.c | 92 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 87 insertions(+), 5 deletions(-)

I assume this is going though the mips tree...

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
