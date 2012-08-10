Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Aug 2012 20:04:29 +0200 (CEST)
Received: from charlotte.tuxdriver.com ([70.61.120.58]:48026 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903749Ab2HJSEV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Aug 2012 20:04:21 +0200
Received: from uucp by smtp.tuxdriver.com with local-rmail (Exim 4.63)
        (envelope-from <linville@tuxdriver.com>)
        id 1SztZG-0007T4-Hh; Fri, 10 Aug 2012 14:04:14 -0400
Received: from linville-8530p.local (linville-8530p.local [127.0.0.1])
        by linville-8530p.local (8.14.5/8.14.4) with ESMTP id q7AHlqlC009448;
        Fri, 10 Aug 2012 13:47:52 -0400
Received: (from linville@localhost)
        by linville-8530p.local (8.14.5/8.14.5/Submit) id q7AHln33009447;
        Fri, 10 Aug 2012 13:47:49 -0400
Date:   Fri, 10 Aug 2012 13:47:49 -0400
From:   "John W. Linville" <linville@tuxdriver.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH 2/3] bcma: add GPIO driver for SoCs
Message-ID: <20120810174748.GA1950@tuxdriver.com>
References: <1344165123-4640-1-git-send-email-hauke@hauke-m.de>
 <1344165123-4640-3-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1344165123-4640-3-git-send-email-hauke@hauke-m.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34091
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Aug 05, 2012 at 01:12:02PM +0200, Hauke Mehrtens wrote:
> The GPIOs are access through some registers in the chip common core.
> We need locking around these GPIO accesses, all GPIOs are accessed
> through the same registers and parallel writes will cause problems.
> 
> CC: Rafał Miłecki <zajec5@gmail.com>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

ACK to the bcma bits going through Ralf's tree...

-- 
John W. Linville		Someday the world will need a hero, and you
linville@tuxdriver.com			might be all we have.  Be ready.
