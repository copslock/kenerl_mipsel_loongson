Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2013 21:56:54 +0200 (CEST)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:35542 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823120Ab3I3T4wgELdg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Sep 2013 21:56:52 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 393AC56F86E;
        Mon, 30 Sep 2013 22:56:51 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id 8X9UIijwgSE5; Mon, 30 Sep 2013 22:56:46 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp6.welho.com (Postfix) with SMTP id 412935BC006;
        Mon, 30 Sep 2013 22:56:45 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Mon, 30 Sep 2013 22:56:42 +0300
Date:   Mon, 30 Sep 2013 22:56:42 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>, richard@nod.at,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] staging: octeon-ethernet: don't assume that CPU 0 is
 special
Message-ID: <20130930195642.GF4572@blackmetal.musicnaut.iki.fi>
References: <1380397834-14286-1-git-send-email-aaro.koskinen@iki.fi>
 <5249B37E.4050000@caviumnetworks.com>
 <20130930193502.GE4572@blackmetal.musicnaut.iki.fi>
 <5249D407.2090904@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5249D407.2090904@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Mon, Sep 30, 2013 at 12:41:59PM -0700, David Daney wrote:
> On 09/30/2013 12:35 PM, Aaro Koskinen wrote:
> >No, the original logic was already broken. The code assumed that the
> >NAPI scheduled by the driver init gets executed always on CPU 0. The
> >IRQ got enabled just because we are lucky.
> 
> No.  The default affinity for all irqs is CPU0 for just this reason.
> So there was no luck involved.

According the Kconfig, this driver can be compiled as a module:

> config OCTEON_ETHERNET
>	tristate "Cavium Networks Octeon Ethernet support"
[...]
>	To compile this driver as a module, choose M here.  The module
>	will be called octeon-ethernet.

What guarantees that CPU0 is around (or the smp_affinity is at its
default value) by the time user executes modprobe?

A.
