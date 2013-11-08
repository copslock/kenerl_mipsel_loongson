Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Nov 2013 00:27:24 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:59697 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6815753Ab3KHX1WMWolE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Nov 2013 00:27:22 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id C6D255A72DD;
        Sat,  9 Nov 2013 01:27:20 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id Cx62ydRQmicL; Sat,  9 Nov 2013 01:27:15 +0200 (EET)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp6.welho.com (Postfix) with SMTP id 871725BC003;
        Sat,  9 Nov 2013 01:27:15 +0200 (EET)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Sat, 09 Nov 2013 01:27:13 +0200
Date:   Sat, 9 Nov 2013 01:27:13 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Aaro Koskinen <aaro.koskinen@nsn.com>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 1/2] MIPS: cavium-octeon: fix out-of-bounds array
 access
Message-ID: <20131108232713.GA2623@blackmetal.musicnaut.iki.fi>
References: <1383318364-30312-1-git-send-email-aaro.koskinen@nsn.com>
 <527D5B61.7090105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527D5B61.7090105@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38494
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

On Fri, Nov 08, 2013 at 01:45:05PM -0800, David Daney wrote:
> On 11/01/2013 08:06 AM, Aaro Koskinen wrote:
> >When booting with in-kernel DTBs, the pruning code will enumerate
> >interfaces 0-4. However, there is memory reserved only for 4 so some
> >other data will get overwritten by cvmx_helper_interface_enumerate().
> >
> >Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>
> 
> Thanks for finding this,  tested and ...
> 
> Acked-by: David Daney <david.daney@cavium.com>
> 
> 
> Ralf:  Please apply.
> 
> Aaro: Suggest stable branches that this is a candidate for.

These are relevant for >= 3.10 stable kernels.

A.
