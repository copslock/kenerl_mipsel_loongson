Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Feb 2016 02:47:53 +0100 (CET)
Received: from erouter8.ore.mailhop.org ([54.187.218.212]:21438 "EHLO
        erouter8.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012738AbcBRBrvjqIqI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Feb 2016 02:47:51 +0100
X-MHO-User: 34073164-d5e1-11e5-a023-11ad6df26ed1
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 74.98.178.100
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [74.98.178.100])
        by outbound3.ore.mailhop.org (Halon Mail Gateway) with ESMTPSA;
        Thu, 18 Feb 2016 01:44:51 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id 46E168006E;
        Thu, 18 Feb 2016 01:47:41 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io 46E168006E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1455760061;
        bh=BNWcS7BRtYy4D4PmvJYP9+tM5QaTcTq/RDNpt57E3jU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GGJffdzZ7QmCGx04N/UAVV6DPXgIbyrpdTdnw+z55N8oiE4Zx0NQoxsJ47wyHYlKN
         qbmSd9FhCuULvZYj90Yk3JRxD2nxpTR8+Qn3Vj3g/jn9DQxTJiTl3Gkm50EsFMrFGS
         tBD4zGPdETWduYyO0TvamoQHaVatQrKxNfrfFQ/7dG4uq2YeSyP/a/vQ4BdRDWyLbx
         1A/asv5Bv84gFI5bLrVuE6kTWEiKWnu3DUqElGKSEBgAz785E19Gf2CUa79Q7UkBLL
         VVekzxrXPL08VReZV5iHcLxhUuLWuH3IF1qEH+BKGfkwPxlfs74W8i2tbB5M/0dG0w
         RRSiPupKCZ7aQ==
Date:   Thu, 18 Feb 2016 01:47:40 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/15] irqchip: mips-gic: Use HW IDs for VPE_OTHER_ADDR
Message-ID: <20160218014740.GP5183@io.lakedaemon.net>
References: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
 <1454469335-14778-8-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454469335-14778-8-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52110
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

On Wed, Feb 03, 2016 at 03:15:27AM +0000, Paul Burton wrote:
> The Linux CPU number doesn't necessarily match up with the ID used for a
> VP by hardware. Convert the CPU number to the HW ID using mips_cm_vp_id
> when writing to the VP(E)_OTHER_ADDR register in order to ensure that we
> correctly access registers for the VPs of secondary cores. This most
> notably affects systems using CM3, such as those based around I6400.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
> 
>  drivers/irqchip/irq-mips-gic.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Note: standard subject line for irqchip is 'irqchip/mips-gic: [A-Z]...'
with that small change,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
