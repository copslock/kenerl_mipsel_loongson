Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2016 19:57:48 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:56560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026235AbcDGR51KqeaQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Apr 2016 19:57:27 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id BD9FB2026F;
        Thu,  7 Apr 2016 17:57:25 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 980DB20263;
        Thu,  7 Apr 2016 17:57:24 +0000 (UTC)
Date:   Thu, 7 Apr 2016 12:57:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        simon@fire.lp0.eu
Subject: Re: [PATCH v2] bmips: add support for BCM63268
Message-ID: <20160407175722.GF32257@rob-hp-laptop>
References: <1459684846-11308-1-git-send-email-noltari@gmail.com>
 <1459757517-14897-1-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1459757517-14897-1-git-send-email-noltari@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52927
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

On Mon, Apr 04, 2016 at 10:11:57AM +0200, Álvaro Fernández Rojas wrote:
> This SoC is very similar to BCM63168 and Broadcom usually refers to them as
> BCM63268.
> Use alphabetical order for bmips quirks.
> Add BCM63268 and missing BCM63168 to device tree documentation.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  v2: keep support for BCM63168
> 
>  Documentation/devicetree/bindings/mips/brcm/soc.txt | 3 ++-
>  arch/mips/bmips/setup.c                             | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
