Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jul 2013 21:55:58 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:49626 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827823Ab3GPTzwYxkmD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jul 2013 21:55:52 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 525FF5A6EAC;
        Tue, 16 Jul 2013 22:55:49 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id hkkxChkMnbAd; Tue, 16 Jul 2013 22:55:44 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp6.welho.com (Postfix) with SMTP id 4BEF45BC003;
        Tue, 16 Jul 2013 22:55:43 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Tue, 16 Jul 2013 22:55:43 +0300
Date:   Tue, 16 Jul 2013 22:55:43 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Complete kernel source trees for ERLite-3.
Message-ID: <20130716195543.GD14385@blackmetal.musicnaut.iki.fi>
References: <51E59BFF.3030808@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51E59BFF.3030808@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37303
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

On Tue, Jul 16, 2013 at 02:16:15PM -0500, Steven J. Hill wrote:
> If anyone is interested I have created the complete original kernel
> source trees for the v1.0.2, v1.1.0 and v1.2.0 firmware releases on
> the ERLite-3. They were made from the following components:

You should be also able to run mainline kernels starting from v3.11-rc1,
but most likely only with your own userspace. The stuff you posted is of
course a valuable reference when improving the mainline kernel support
for this board.

A.
