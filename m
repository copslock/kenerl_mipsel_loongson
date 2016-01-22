Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 23:32:34 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:46719 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009541AbcAVWcc224tw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jan 2016 23:32:32 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id CF920205BC;
        Fri, 22 Jan 2016 22:32:29 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA7C1205B8;
        Fri, 22 Jan 2016 22:32:28 +0000 (UTC)
Date:   Fri, 22 Jan 2016 16:32:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     linux-mips@linux-mips.org, devicetree@vger.kernel.org
Subject: Re: [RFC v2 5/7] devicetree: add Dragino vendor id
Message-ID: <20160122223226.GA23105@rob-hp-laptop>
References: <1453415664-20307-1-git-send-email-antonynpavlov@gmail.com>
 <1453415664-20307-6-git-send-email-antonynpavlov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453415664-20307-6-git-send-email-antonynpavlov@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51313
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

On Fri, Jan 22, 2016 at 01:34:22AM +0300, Antony Pavlov wrote:
> Please see http://www.dragino.com/about/about.html for details.
> 
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
