Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2014 01:03:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50428 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832653AbaDIXDOepRSm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Apr 2014 01:03:14 +0200
Date:   Thu, 10 Apr 2014 00:03:14 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Jonas Gorski <jogo@openwrt.org>
cc:     Paul Bolle <pebolle@tiscali.nl>,
        Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Replace CONFIG_MIPS64 and CONFIG_MIPS32_R2
In-Reply-To: <CAOiHx=mi3sW7C0ZGwAhobRryikMs=Hj0UL19ENuUMECqk0EW5g@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1404092356500.29561@eddie.linux-mips.org>
References: <1391952745.25424.6.camel@x220> <CAOiHx=mi3sW7C0ZGwAhobRryikMs=Hj0UL19ENuUMECqk0EW5g@mail.gmail.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Sun, 9 Feb 2014, Jonas Gorski wrote:

> While I agree about the CONFIG_MIPS64 => CONFIG_64BIT replacement, I
> wonder if CONFIG_MIPS32_R2 shouldn't rather be CONFIG_CPU_MIPSR2
> (maybe even the existing CONFIG_CPU_MIPS32_R2 are wrong here).

 Absolutely.  You should be able to build a 32-bit kernel (32BIT) for a 
MIPS64r2 processor (CPU_MIPS64_R2) and use the FP64 feature.

  Maciej
