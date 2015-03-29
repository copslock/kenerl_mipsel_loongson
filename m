Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2015 22:39:33 +0200 (CEST)
Received: from nov-007-i627.relay.mailchannels.net ([46.232.183.181]:20555
        "HELO relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with SMTP id S27009986AbbC2UjbnBgyk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Mar 2015 22:39:31 +0200
X-Sender-Id: duocircle|x-authuser|jac299792458
Received: from smtp7.ore.mailhop.org (ip-10-237-13-110.us-west-2.compute.internal [10.237.13.110])
        by relay.mailchannels.net (Postfix) with ESMTPA id E74421D0281;
        Sun, 29 Mar 2015 20:39:26 +0000 (UTC)
X-Sender-Id: duocircle|x-authuser|jac299792458
Received: from smtp7.ore.mailhop.org (smtp7.ore.mailhop.org [10.21.145.197])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA)
        by 0.0.0.0:2500 (trex/5.4.8);
        Sun, 29 Mar 2015 20:39:27 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: duocircle|x-authuser|jac299792458
X-MailChannels-Auth-Id: duocircle
X-MC-Loop-Signature: 1427661567019:692541782
X-MC-Ingress-Time: 1427661567019
Received: from pool-72-84-113-125.nrflva.fios.verizon.net ([72.84.113.125] helo=io)
        by smtp7.ore.mailhop.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.82)
        (envelope-from <jason@lakedaemon.net>)
        id 1YcJzT-0000i9-DR; Sun, 29 Mar 2015 20:39:27 +0000
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id D0899805AF;
        Sun, 29 Mar 2015 20:39:23 +0000 (UTC)
X-Mail-Handler: DuoCircle Outbound SMTP
X-Originating-IP: 72.84.113.125
X-Report-Abuse-To: abuse@duocircle.com (see https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information for abuse reporting information)
X-MHO-User: U2FsdGVkX18U6A7dw97Q80n+vVN00/Wr9NHu7LoHgs4=
X-DKIM: OpenDKIM Filter v2.6.8 io D0899805AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1427661563;
        bh=xcLmVX2BXAlgK7TUkoJQjo3gwfX+Ns1UwDh6/QLSloY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bxnlXl/ehAzNYJQPTNPLLSMgzqAxfA2m3K72kerDUrHRmIGBDx1snvsKjPONHWUqU
         IZvkaCPueuV508VtSHjOfrP9lmpPyKu2w2hQ3xK4e+a1kmvBIvyDpsBKS9doSb2wwJ
         fwfPksDL0HfON7/46l6rRbr8FCa9J9PoERERDaDobiCe+avWhdbxg1EC4GfJLYYWgU
         hEIs59WWAGU/jgmyldnuTPZvTrT6be8wlYabujxpQfEamykvhsoBDgO//dVyYjZy4X
         SZq4YS4raWDEedtwkb+sOvIAW75C7tRsJb3lnkcoqBp6fnWzgR3cPZ871ddwJK1b6r
         HqK2rDnMNQF0A==
Date:   Sun, 29 Mar 2015 20:39:23 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] irqchip: irq-mips-gic: Add new functions to
 start/stop the GIC counter
Message-ID: <20150329203923.GF25778@io.lakedaemon.net>
References: <1427113923-9840-1-git-send-email-markos.chandras@imgtec.com>
 <1427113923-9840-2-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1427113923-9840-2-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-AuthUser: jac299792458
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46591
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

On Mon, Mar 23, 2015 at 12:32:01PM +0000, Markos Chandras wrote:
> We add new functions to start and stop the GIC counter since there are no
> guarantees the counter will be running after a CPU reset. The GIC counter
> is stopped by setting the 29th bit on the GIC Config register and it is
> started by clearing that bit.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Bresticker <abrestic@chromium.org>
> Cc: Qais Yousef <qais.yousef@imgtec.com>
> Cc: <linux-kernel@vger.kernel.org>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  drivers/irqchip/irq-mips-gic.c   | 21 +++++++++++++++++++++
>  include/linux/irqchip/mips-gic.h |  2 ++
>  2 files changed, 23 insertions(+)

Applied to irqchip/core

thx,

Jason.
