Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2014 19:15:26 +0100 (CET)
Received: from charlotte.tuxdriver.com ([70.61.120.58]:53014 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011024AbaJ0SPYuhJN3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2014 19:15:24 +0100
Received: from uucp by smtp.tuxdriver.com with local-rmail (Exim 4.63)
        (envelope-from <linville@tuxdriver.com>)
        id 1Xioov-0001JQ-HQ; Mon, 27 Oct 2014 14:15:09 -0400
Received: from linville-x1.hq.tuxdriver.com (localhost.localdomain [127.0.0.1])
        by linville-x1.hq.tuxdriver.com (8.14.8/8.14.6) with ESMTP id s9RI5Bef012531;
        Mon, 27 Oct 2014 14:05:11 -0400
Received: (from linville@localhost)
        by linville-x1.hq.tuxdriver.com (8.14.8/8.14.8/Submit) id s9RI5A4B012530;
        Mon, 27 Oct 2014 14:05:10 -0400
Date:   Mon, 27 Oct 2014 14:05:10 -0400
From:   "John W. Linville" <linville@tuxdriver.com>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        linux-wireless@vger.kernel.org, ath5k-devel@venema.h4ckr.net
Subject: Re: [PATCH v2 12/13] ath5k: update dependencies
Message-ID: <20141027180510.GF28300@tuxdriver.com>
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
 <1413932631-12866-13-git-send-email-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413932631-12866-13-git-send-email-ryazanov.s.a@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linville@tuxdriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linville@tuxdriver.com
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

On Wed, Oct 22, 2014 at 03:03:50AM +0400, Sergey Ryazanov wrote:
> - Use config symbol defined in the driver instead of arch specific one for
>   conditional compilation.
> - Rename the ATHEROS_AR231X config symbol to ATH25.
> - Fix include (ar231x_platform.h -> ath25_platform.h).
> - Some of AR231x SoCs (e.g. AR2315) have PCI bus support, so remove !PCI
>   dependency, which block AHB support build.
> 
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Cc: Jiri Slaby <jirislaby@gmail.com>
> Cc: Nick Kossifidis <mickflemm@gmail.com>
> Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: ath5k-devel@lists.ath5k.org

Acked-by: John W. Linville <linville@tuxdriver.com>

-- 
John W. Linville		Someday the world will need a hero, and you
linville@tuxdriver.com			might be all we have.  Be ready.
