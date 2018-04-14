Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Apr 2018 20:38:27 +0200 (CEST)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:58342 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992966AbeDNSiV36diq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 14 Apr 2018 20:38:21 +0200
Received: from darkstar.musicnaut.iki.fi (85-76-81-128-nat.elisa-mobile.fi [85.76.81.128])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 66BEE20017;
        Sat, 14 Apr 2018 21:38:20 +0300 (EEST)
Date:   Sat, 14 Apr 2018 21:38:20 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 4/4] MIPS: Octeon: Whitespace and formatting clean-ups.
Message-ID: <20180414183819.czznxznuutfsw66j@darkstar.musicnaut.iki.fi>
References: <1523650820-18134-1-git-send-email-steven.hill@cavium.com>
 <1523650820-18134-5-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523650820-18134-5-git-send-email-steven.hill@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63533
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

On Fri, Apr 13, 2018 at 03:20:20PM -0500, Steven J. Hill wrote:
> All of these files will be touched by the forthcoming CPU hotplug
> and PCIe patchsets. Ran checkpatch and updated copyright dates.

[...]

> -	smp_wmb();
> +	smp_wmb();	/* */

> -	mb();
> +	mb();	/* */

> -	mb();
> +	mb();	/* */

> -	mb();
> +	mb();	/* */

> -	mb();
> -
> +	mb();	/* */

> -	mb();
> +	mb();	/* */

I don't think we should add empty comments just to silence checkpatch...

A.
