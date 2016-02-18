Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Feb 2016 02:48:40 +0100 (CET)
Received: from outbound1a.ore.mailhop.org ([54.213.22.21]:29084 "EHLO
        outbound1a.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012738AbcBRBsiQiCKI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Feb 2016 02:48:38 +0100
X-MHO-User: c51d3bec-d5e1-11e5-8dfb-c75234cc769e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 74.98.178.100
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [74.98.178.100])
        by outbound1.ore.mailhop.org (Halon Mail Gateway) with ESMTPSA;
        Thu, 18 Feb 2016 01:48:55 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id 8A3F08006E;
        Thu, 18 Feb 2016 01:48:28 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io 8A3F08006E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1455760108;
        bh=IEe8K3nGxljG6voHQIAsCvdiKeffIv8rJwnRXfeJ0lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=lmCjDyR1lNxe9qXxwv3vbP2DRgqgk/pMJqrPi4pkN5OcWiE2Z8xWeiFiXEulawOiQ
         zGyTZBBuyqoqPGX8DrKXwkdnChQr5roYNRMJY/nBN0HoZx71d9ku/cYkly2trfsbgK
         0o7pfGn1KjcrQSOrfJr3KxQaAZX8+kopHkd+MylSQdJ7fnNr/ici34DH4okVpmpGoq
         hEijgorMl75ygpngIJrXD+Pq/+2ar8noOTn5QVG7UmGsS1yyqG/HlxtIKUipQG1nsh
         jQdT42k0jNpETgOFUlYJUbKpvFRzLzxlz14VFvuz2oEPCtZmrcm/puWidvaaFw8b6v
         47E3q3LIpEx2w==
Date:   Thu, 18 Feb 2016 01:48:28 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Alex Smith <alex.smith@imgtec.com>
Subject: Re: [PATCH 08/15] irqchip: mips-gic: Provide VP ID accessor
Message-ID: <20160218014828.GQ5183@io.lakedaemon.net>
References: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
 <1454469335-14778-9-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454469335-14778-9-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52111
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

On Wed, Feb 03, 2016 at 03:15:28AM +0000, Paul Burton wrote:
> Provide a gic_read_local_vp_id() function to read the VCNUM field of the
> GICs local VP_IDENT register. This will be used by a further patch to
> check that the value reported by the GIC matches up with the kernels
> calculation.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
> 
>  drivers/irqchip/irq-mips-gic.c   |  8 ++++++++
>  include/linux/irqchip/mips-gic.h | 17 +++++++++++++++++
>  2 files changed, 25 insertions(+)

Same subject line nit here, otherwise,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
