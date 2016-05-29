Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 May 2016 21:30:20 +0200 (CEST)
Received: from caladan.dune.hu ([78.24.191.180]:32838 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27030121AbcE2TaSoHx8g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 May 2016 21:30:18 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 3C6FAB92140;
        Sun, 29 May 2016 21:30:18 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.0.2] (dslb-088-073-007-040.088.073.pools.vodafone-ip.de [88.73.7.40])
        by arrakis.dune.hu (Postfix) with ESMTPSA id CE49FB9210F;
        Sun, 29 May 2016 21:30:08 +0200 (CEST)
Subject: Re: [PATCH v2] Re: Adding support for device tree and command line
To:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
References: <20160524194818.9e8399a56669134de4baee1e@gmail.com>
 <1464383198-6316-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
 <c481d3b1-bee1-89c9-bbb8-ef17d91570bf@openwrt.org>
 <1464547128.5020.32.camel@chimera>
 <16b32a30-b0b4-d69e-b53d-827b9640c0cb@openwrt.org>
 <1464548936.5020.37.camel@chimera>
 <9757c228-5835-422f-2b8c-bbced1d15df4@openwrt.org>
 <1464550007.5020.39.camel@chimera>
Cc:     linux-mips@linux-mips.org, hauke@hauke-m.de, openwrt@kresin.me,
        antonynpavlov@gmail.com
From:   Jonas Gorski <jogo@openwrt.org>
Message-ID: <579ebd0d-d08f-8507-8170-b25268843cf4@openwrt.org>
Date:   Sun, 29 May 2016 21:30:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1464550007.5020.39.camel@chimera>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On 29.05.2016 21:26, Daniel Gimpelevich wrote:
> On Sun, 2016-05-29 at 21:22 +0200, Jonas Gorski wrote:
>> That still leaves the question which one should be preferred in case
>> both
>> are present.
> 
> In the already merged code, the appended one is preferred, so I would
> favor that.
> 

Makes sense. mach code can still check for a0 == -2 and then a1 != fw_passed_dtb
to know if the appended one was used or the passed one, in case it
needs to know/wants to switch.


Jonas
