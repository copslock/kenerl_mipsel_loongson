Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2014 21:44:07 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:39926 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827305AbaBGUoEb8RC3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Feb 2014 21:44:04 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id AAFC25A73C5;
        Fri,  7 Feb 2014 22:44:01 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id p7pp0IshlkGw; Fri,  7 Feb 2014 22:43:56 +0200 (EET)
Received: from drone (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 8A8825BC01B;
        Fri,  7 Feb 2014 22:43:58 +0200 (EET)
Date:   Fri, 7 Feb 2014 22:43:08 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH 1/2] MIPS: fix CONFIG_* error in fpu code
Message-ID: <20140207204308.GA573@drone.musicnaut.iki.fi>
References: <1391783493-6806-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1391783493-6806-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39233
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

On Fri, Feb 07, 2014 at 10:31:32PM +0800, Huacai Chen wrote:
> Commit 597ce1723e0f (MIPS: Support for 64-bit FP with O32 binaries)
> brings some CONFIG_MIPS64, but CONFIG_MIPS64 doesn't exist in any
> Kconfig file. I guess the correct thing is CONFIG_64BIT, so fix it.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
