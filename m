Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 22:16:25 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:37850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011604AbcAZVQYWFylG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jan 2016 22:16:24 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id B872420221;
        Tue, 26 Jan 2016 21:16:22 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ACD92021B;
        Tue, 26 Jan 2016 21:16:21 +0000 (UTC)
Date:   Tue, 26 Jan 2016 15:16:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     linux-mips@linux-mips.org, devicetree@vger.kernel.org
Subject: Re: [RFC v3 10/14] devicetree: add Dragino vendor id
Message-ID: <20160126211619.GA11375@rob-hp-laptop>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
 <1453580251-2341-11-git-send-email-antonynpavlov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453580251-2341-11-git-send-email-antonynpavlov@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51431
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

On Sat, Jan 23, 2016 at 11:17:27PM +0300, Antony Pavlov wrote:
> Please see http://www.dragino.com/about/about.html for details.
> 
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
