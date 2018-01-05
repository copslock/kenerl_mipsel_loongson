Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 23:07:54 +0100 (CET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:56446 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992615AbeAEWHlUoiIg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 23:07:41 +0100
Received: from darkstar.musicnaut.iki.fi (85-76-72-218-nat.elisa-mobile.fi [85.76.72.218])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 29D9A1A2613;
        Sat,  6 Jan 2018 00:07:39 +0200 (EET)
Date:   Sat, 6 Jan 2018 00:07:38 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        David Daney <david.daney@cavium.com>,
        John Crispin <john@phrozen.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matt Redfearn <matt.redfearn@mips.com>
Subject: Re: [PATCH] MAINTAINERS: Add James as MIPS co-maintainer
Message-ID: <20180105220738.djuitbrlucfttohy@darkstar.musicnaut.iki.fi>
References: <20180105213647.28850-1-jhogan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180105213647.28850-1-jhogan@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61941
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

On Fri, Jan 05, 2018 at 09:36:47PM +0000, James Hogan wrote:
> I've been taking on some co-maintainer duties already, so lets make it
> official in the MAINTAINERS file.
> 
> Link: https://lkml.kernel.org/r/33db77a2-32e4-6b2c-d463-9d116ba55623@imgtec.com
> Link: https://lkml.kernel.org/r/20171207110549.GM27409@jhogan-linux.mipstec.com
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: David Daney <david.daney@cavium.com>
> Cc: John Crispin <john@phrozen.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Matt Redfearn <matt.redfearn@mips.com>
> Cc: linux-mips@linux-mips.org

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2d3d750b19c0..61bccbd3715f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8983,6 +8983,7 @@ F:	drivers/usb/image/microtek.*
>  
>  MIPS
>  M:	Ralf Baechle <ralf@linux-mips.org>
> +M:	James Hogan <jhogan@kernel.org>
>  L:	linux-mips@linux-mips.org
>  W:	http://www.linux-mips.org/
>  T:	git git://git.linux-mips.org/pub/scm/ralf/linux.git
> -- 
> 2.13.6
> 
> 
