Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 19:34:30 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:37148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007846AbbK3SeZeFJBE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Nov 2015 19:34:25 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id D91AD20531;
        Mon, 30 Nov 2015 18:34:21 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55CBF204DE;
        Mon, 30 Nov 2015 18:34:19 +0000 (UTC)
Date:   Mon, 30 Nov 2015 12:34:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Tejun Heo <tj@kernel.org>,
        Joe Perches <joe@perches.com>, Jiri Slaby <jslaby@suse.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        devicetree@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 27/28] dt-bindings: mips: img,boston: Document img,boston
 binding
Message-ID: <20151130183417.GA16490@rob-hp-laptop>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
 <1448900513-20856-28-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448900513-20856-28-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Mon, Nov 30, 2015 at 04:21:52PM +0000, Paul Burton wrote:
> Add documentation for the simple img,boston devicetree binding & the
> boot protocol used to pass the devicetree to the kernel.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
> 
>  Documentation/devicetree/bindings/mips/img/boston.txt | 15 +++++++++++++++
>  MAINTAINERS                                           |  5 +++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/img/boston.txt
> 
> diff --git a/Documentation/devicetree/bindings/mips/img/boston.txt b/Documentation/devicetree/bindings/mips/img/boston.txt
> new file mode 100644
> index 0000000..27b2806
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/img/boston.txt
> @@ -0,0 +1,15 @@
> +Imagination Technologies Boston Development Board
> +=================================================
> +
> +Required properties:
> +--------------------
> + - compatible: Must be "img,boston".

No SOC compatible in addition?

> +
> +Boot protocol:
> +--------------
> +In accordance with the MIPS UHI specification[1], the bootloader must pass the
> +following arguments to the kernel:
> + - $a0: -2.
> + - $a1: KSEG0 address of the flattened device-tree blob.

If this is standard, I don't know that we need to repeat it for every 
board.

Rob

> +
> +[1] http://prplfoundation.org/wiki/MIPS_documentation
