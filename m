Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2018 16:51:39 +0200 (CEST)
Received: from smtprelay.synopsys.com ([198.182.47.9]:48889 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992618AbeFLOvcOrz2e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2018 16:51:32 +0200
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 57D9D24E257F;
        Tue, 12 Jun 2018 07:51:23 -0700 (PDT)
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3CC433F09;
        Tue, 12 Jun 2018 07:51:22 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 12 Jun 2018 07:51:22 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 12 Jun 2018 16:51:19 +0200
Received: from [10.0.2.15] (10.107.19.20) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 12 Jun
 2018 16:51:19 +0200
Subject: Re: [PATCH 3/3 RFC] Revert "net: stmmac: fix build failure due to
 missing COMMON_CLK dependency"
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S . Miller" <davem@davemloft.net>
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
 <1528706663-20670-4-git-send-email-geert@linux-m68k.org>
CC:     Arnd Bergmann <arnd@arndb.de>, <linux-m68k@lists.linux-m68k.org>,
        <linux-mips@linux-mips.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Jose Abreu <Jose.Abreu@synopsys.com>
Message-ID: <1a1f3bea-1680-ce1c-09cb-0d5e2b4531d1@synopsys.com>
Date:   Tue, 12 Jun 2018 15:51:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1528706663-20670-4-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.20]
Return-Path: <Jose.Abreu@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jose.Abreu@synopsys.com
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

On 11-06-2018 09:44, Geert Uytterhoeven wrote:
> This reverts commit bde4975310eb1982bd0bbff673989052d92fd481.
>
> All legacy clock implementations now implement clk_set_rate() (Some
> implementations may be dummies, though).
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>

This seems okay by me. You can send a non-rfc patch with my ack
once other 2 patches get accepted:

Acked-by: Jose Abreu <joabreu@synopsys.com>

Thanks and Best Regards,
Jose Miguel Abreu
