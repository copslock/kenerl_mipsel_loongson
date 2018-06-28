Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2018 08:28:43 +0200 (CEST)
Received: from cannabis.dataforce.net ([195.42.160.49]:33846 "EHLO
        cannabis.dataforce.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992508AbeF1G2eF5mSv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jun 2018 08:28:34 +0200
Received: by cannabis.dataforce.net (Postfix, from userid 12794)
        id 54A2D4A0004; Thu, 28 Jun 2018 09:28:33 +0300 (MSK)
Date:   Thu, 28 Jun 2018 09:28:31 +0300
From:   Georgi Guninski <guninski@guninski.com>
To:     James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: Potential BUG_ON() in do_group_exit() on 4.17.2
Message-ID: <20180628062831.rromui5qmyrnslml@sivokote.iziade.m$>
References: <20180627121302.56nivw2adgov3fvn@sivokote.iziade.m$>
 <20180627211403.GA11655@jamesdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627211403.GA11655@jamesdev>
header: best read with a sniffer
Return-Path: <guninski@guninski.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guninski@guninski.com
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

On Wed, Jun 27, 2018 at 10:14:04PM +0100, James Hogan wrote:
> I've hit this by accident before, while tweaking GDB on MIPS. See here:
> 
> [RFC] kernel/signal.c: avoid BUG_ON with SIG128 (MIPS):
> https://patchwork.linux-mips.org/patch/5343/
>

Thanks. Does kernel execution on mips continue after BUG_ON() or is it
like panic()?
 
