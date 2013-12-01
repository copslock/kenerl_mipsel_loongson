Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Dec 2013 21:24:11 +0100 (CET)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:58847 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816383Ab3LAUYJbHLbk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 1 Dec 2013 21:24:09 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 26E4421B85C;
        Sun,  1 Dec 2013 22:24:07 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id j76x1cUs6hUJ; Sun,  1 Dec 2013 22:24:03 +0200 (EET)
Received: from musicnaut.iki.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with SMTP id 12FAB5BC004;
        Sun,  1 Dec 2013 22:24:02 +0200 (EET)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Sun, 01 Dec 2013 22:23:58 +0200
Date:   Sun, 1 Dec 2013 22:23:58 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Greg Ungerer <gerg@snapgear.com>,
        Ashok Kumar <ashoks@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: MIPS: 3.13-rc1 regression: initrd/cramfs broken
Message-ID: <20131201202358.GD30823@blackmetal.musicnaut.iki.fi>
References: <20131124110518.GA24645@blackmetal.musicnaut.iki.fi>
 <20131130215942.GB30823@blackmetal.musicnaut.iki.fi>
 <529B7E02.2040208@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <529B7E02.2040208@hauke-m.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38622
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

Hi,

On Sun, Dec 01, 2013 at 07:20:50PM +0100, Hauke Mehrtens wrote:
> kernel 3.13 uses CFE for early printks and the kernel use CFE's memory.
> I send patches to remove usage of CFE for the boot console some time ago.
> 
> Please thy these patches:
> https://patchwork.linux-mips.org/patch/5888/
> https://patchwork.linux-mips.org/patch/5889/

Thanks, these will remove the need for a custom RAM map, I get 1 MB more
memory, and no hangs.

A.
