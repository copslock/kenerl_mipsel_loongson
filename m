Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Feb 2014 20:45:59 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:32837 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825747AbaBITp5MC6VX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Feb 2014 20:45:57 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 703D956FA72;
        Sun,  9 Feb 2014 21:45:56 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id NjXINPy92eLt; Sun,  9 Feb 2014 21:45:52 +0200 (EET)
Received: from drone (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 614985BC002;
        Sun,  9 Feb 2014 21:45:52 +0200 (EET)
Date:   Sun, 9 Feb 2014 21:45:01 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Paul Bolle <pebolle@tiscali.nl>,
        Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Replace CONFIG_MIPS64 and CONFIG_MIPS32_R2
Message-ID: <20140209194501.GD573@drone.musicnaut.iki.fi>
References: <1391952745.25424.6.camel@x220>
 <CAOiHx=mi3sW7C0ZGwAhobRryikMs=Hj0UL19ENuUMECqk0EW5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=mi3sW7C0ZGwAhobRryikMs=Hj0UL19ENuUMECqk0EW5g@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39257
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

On Sun, Feb 09, 2014 at 05:26:59PM +0100, Jonas Gorski wrote:
> On Sun, Feb 9, 2014 at 2:32 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> > Commit 597ce1723e0f ("MIPS: Support for 64-bit FP with O32 binaries")
> > introduced references to two undefined Kconfig macros. CONFIG_MIPS32_R2
> > should clearly be replaced with CONFIG_CPU_MIPS32_R2. And CONFIG_MIPS64
> > should apparently be replaced with CONFIG_64BIT.
> 
> While I agree about the CONFIG_MIPS64 => CONFIG_64BIT replacement, I
> wonder if CONFIG_MIPS32_R2 shouldn't rather be CONFIG_CPU_MIPSR2
> (maybe even the existing CONFIG_CPU_MIPS32_R2 are wrong here).

FYI, the 64BIT part is already fixed by
<http://patchwork.linux-mips.org/patch/6506/>. I guess these two changes
could be separate patches.

A.
