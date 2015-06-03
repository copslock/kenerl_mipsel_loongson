Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2015 10:24:16 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37470 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026919AbbFCIYNilu3v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Jun 2015 10:24:13 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t538OBvS012876;
        Wed, 3 Jun 2015 10:24:11 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t538OA6X012874;
        Wed, 3 Jun 2015 10:24:10 +0200
Date:   Wed, 3 Jun 2015 10:24:10 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>,
        linux-kernel@vger.kernel.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] MIPS: prepare for user enabling of CONFIG_OF
Message-ID: <20150603082410.GI9839@linux-mips.org>
References: <1433285204-4307-1-git-send-email-robh@kernel.org>
 <1433285204-4307-2-git-send-email-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1433285204-4307-2-git-send-email-robh@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Jun 02, 2015 at 05:46:42PM -0500, Rob Herring wrote:

> In preparation to allow users to enable DeviceTree without arch or
> machine selecting it, we need to fix build errors on MIPS. When
> CONFIG_OF is enabled, device_tree_init cannot be resolved. This is
> trivially fixed by using CONFIG_USE_OF instead of CONFIG_OF for prom.h.

Want to take this through your tree?  If so,

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
