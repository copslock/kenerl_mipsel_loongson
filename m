Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Feb 2016 15:53:49 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:56143 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011457AbcBLOxld2TOm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Feb 2016 15:53:41 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id BCB37203AC;
        Fri, 12 Feb 2016 14:53:39 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03C732025B;
        Fri, 12 Feb 2016 14:53:37 +0000 (UTC)
Date:   Fri, 12 Feb 2016 08:53:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     linux-mips@linux-mips.org, Marek Vasut <marex@denx.de>,
        Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>, Daan Pape <daan@dptechnics.com>,
        devicetree@vger.kernel.org
Subject: Re: [RFC v5 13/15] devicetree: add DPTechnics vendor id
Message-ID: <20160212145336.GA14644@rob-hp-laptop>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
 <1455005641-7079-14-git-send-email-antonynpavlov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455005641-7079-14-git-send-email-antonynpavlov@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52024
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

On Tue, Feb 09, 2016 at 11:13:59AM +0300, Antony Pavlov wrote:
> Please see https://www.dptechnics.com/contact for details.
> 
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Daan Pape <daan@dptechnics.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
