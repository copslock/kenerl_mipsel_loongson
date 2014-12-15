Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 22:01:57 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:35549 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008857AbaLOVB4Lic27 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Dec 2014 22:01:56 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 663E456F5D0;
        Mon, 15 Dec 2014 23:01:55 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id UIJvd-K2Bz3W; Mon, 15 Dec 2014 23:01:48 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id CA8365BC004;
        Mon, 15 Dec 2014 23:01:48 +0200 (EET)
Date:   Mon, 15 Dec 2014 23:01:48 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Aleksey Makarov <feumilieu@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 12/14] MIPS: OCTEON: Update octeon-model.h code for new
 SoCs.
Message-ID: <20141215210148.GB10323@fuloong-minipc.musicnaut.iki.fi>
References: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
 <1418666603-15159-13-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1418666603-15159-13-git-send-email-aleksey.makarov@auriga.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44700
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

On Mon, Dec 15, 2014 at 09:03:18PM +0300, Aleksey Makarov wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Add coverage for OCTEON III models.

[...]

> +#define OCTEON_IS_OCTEON1()	OCTEON_IS_MODEL(OCTEON_CN3XXX)
> +#define OCTEON_IS_OCTEONPLUS()	OCTEON_IS_MODEL(OCTEON_CN5XXX)
> +#define OCTEON_IS_OCTEON2()						\
> +	(OCTEON_IS_MODEL(OCTEON_CN6XXX) || OCTEON_IS_MODEL(OCTEON_CNF71XX))
> +
> +#define OCTEON_IS_OCTEON3()	OCTEON_IS_MODEL(OCTEON_CN7XXX)
> +
> +#define OCTEON_IS_OCTEON1PLUS()	(OCTEON_IS_OCTEON1() || OCTEON_IS_OCTEONPLUS())

There are no users for these.

A.
