Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 23:41:12 +0100 (CET)
Received: from smtp6-g21.free.fr ([212.27.42.6]:16026 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011475AbcAYWlJkOD0U (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 23:41:09 +0100
Received: from tock (unknown [80.171.100.146])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 30EA382271;
        Mon, 25 Jan 2016 23:39:39 +0100 (CET)
Date:   Mon, 25 Jan 2016 23:41:04 +0100
From:   Alban <albeu@free.fr>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org
Subject: Re: [RFC v3 07/14] MIPS: dts: qca: simplify Makefile
Message-ID: <20160125234104.05857306@tock>
In-Reply-To: <1453580251-2341-8-git-send-email-antonynpavlov@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
        <1453580251-2341-8-git-send-email-antonynpavlov@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Sat, 23 Jan 2016 23:17:24 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

> Do as arch/mips/boot/dts/ralink/Makefile does.
> Without this patch adding a dtb-file leads
> to adding __two__ lines to the Makefile.

I have some patches in my queue to allow using appended DTB and remove
the builtin DTB support. That would also fix the problem as the second
Makefile line wouldn't be needed anymore. I try to post them soon.

Alban

> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Alban Bedel <albeu@free.fr>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/boot/dts/qca/Makefile | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
> index 2d61455d..244329e 100644
> --- a/arch/mips/boot/dts/qca/Makefile
> +++ b/arch/mips/boot/dts/qca/Makefile
> @@ -1,8 +1,7 @@
>  # All DTBs
> -dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
> +dtb-$(CONFIG_DTB_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb
>  
> -# Select a DTB to build in the kernel
> -obj-$(CONFIG_DTB_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb.o
> +obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
>  
>  # Force kbuild to make empty built-in.o if necessary
>  obj-				+= dummy.o
