Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2018 15:32:10 +0200 (CEST)
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:26611
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992618AbeFLNb4qupFI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2018 15:31:56 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AOAQDmyR9b/zSOqnwNTxoBAQEBAQIBA?=
 =?us-ascii?q?QEBCAEBAQGFTIN3lTEBAQEBAQEGgQUpllOEdwKCUjgUAQIBAQEBAQEChj4BAQE?=
 =?us-ascii?q?DIxVBEAsNCwICJgICVwYNBgIBAYMegXSpdW2CHBqEQINsgWiBC4hJgQeBDySCa?=
 =?us-ascii?q?IdzglUCmQYIAY5ziBqFHpMQgXMzGggoCIJ+kGFdkCoBAQ?=
X-IPAS-Result: =?us-ascii?q?A2AOAQDmyR9b/zSOqnwNTxoBAQEBAQIBAQEBCAEBAQGFTIN?=
 =?us-ascii?q?3lTEBAQEBAQEGgQUpllOEdwKCUjgUAQIBAQEBAQEChj4BAQEDIxVBEAsNCwICJ?=
 =?us-ascii?q?gICVwYNBgIBAYMegXSpdW2CHBqEQINsgWiBC4hJgQeBDySCaIdzglUCmQYIAY5?=
 =?us-ascii?q?ziBqFHpMQgXMzGggoCIJ+kGFdkCoBAQ?=
X-IronPort-AV: E=Sophos;i="5.51,214,1526313600"; 
   d="scan'208";a="80706464"
Received: from unknown (HELO [192.168.0.106]) ([124.170.142.52])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 12 Jun 2018 21:31:17 +0800
Subject: Re: [PATCH 1/3] m68k: coldfire: Normalize clk API
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
 <1528706663-20670-2-git-send-email-geert@linux-m68k.org>
 <944b08ba-a882-e6cd-42fa-9251bce1d7b1@linux-m68k.org>
 <CAMuHMdUyD8d2yoe6v8TEinEH3hhS7Znv99pPxDCkr_uEFS0Fzg@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <e6a2da2c-60e5-b57a-f6c1-3652b8be161c@linux-m68k.org>
Date:   Tue, 12 Jun 2018 23:31:12 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUyD8d2yoe6v8TEinEH3hhS7Znv99pPxDCkr_uEFS0Fzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <gerg@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gerg@linux-m68k.org
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

Hi Geert,

On 12/06/18 17:31, Geert Uytterhoeven wrote:
> On Tue, Jun 12, 2018 at 9:27 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> On 11/06/18 18:44, Geert Uytterhoeven wrote:
>>> Coldfire still provides its own variant of the clk API rather than using
>>> the generic COMMON_CLK API.  This generally works, but it causes some
>>> link errors with drivers using the clk_round_rate(), clk_set_rate(),
>>> clk_set_parent(), or clk_get_parent() functions when a platform lacks
>>> those interfaces.
>>>
>>> This adds empty stub implementations for each of them, and I don't even
>>> try to do something useful here but instead just print a WARN() message
>>> to make it obvious what is going on if they ever end up being called.
>>>
>>> The drivers that call these won't be used on these platforms (otherwise
>>> we'd get a link error today), so the added code is harmless bloat and
>>> will warn about accidental use.
>>>
>>> Based on commit bd7fefe1f06ca6cc ("ARM: w90x900: normalize clk API").
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>> I am fine with this for ColdFire, so
>>
>> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
> 
> Thanks!
> 
>> Are you going to take this/these via your m68k git tree?
> 
> I''m fine delagating this to you.

No problem. I'll add it to the m68knommu git tree (for-next branch)
when the merge window closes.

Thanks
Greg
