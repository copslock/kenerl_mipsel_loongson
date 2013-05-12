Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 May 2013 16:52:57 +0200 (CEST)
Received: from mail-wi0-f180.google.com ([209.85.212.180]:48488 "EHLO
        mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819313Ab3ELOwy2JpgC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 May 2013 16:52:54 +0200
Received: by mail-wi0-f180.google.com with SMTP id h11so2098606wiv.1
        for <linux-mips@linux-mips.org>; Sun, 12 May 2013 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=rsfAjQaIDHVhSVOeFTO1uKKUVcYFjuNE1Hbrl3nqgpg=;
        b=w26iu/gBTXHBtXs9wFFkRgGeYObJwod4OF7Xmht6pUGt5P95Rr0LTJavhT+5VniD06
         NJQY0ZhbyBwlyM03ycRP6aBcWk/GSuQ3/R0j7N+XYqioAjjmqLU0Sa+oZCw3nlyGWRLm
         9JXJdh/DdevTVJRIydTpXPnLwWNL27XyKJuugEB+Vx+xy0EvmRmoiV0hFjkdT59cb9qr
         h1xXypzr4Bohthu72bqHCpk2W67PjAq79SCg45pzT093TMCESdoMKBKSijHmNr+MfUSX
         Wussf9bVMmnSLUU5QH0+aJF7A6w0A1282sDi4hcs1sdW8bukuMTvs3pYT1+CEfIn255c
         kSfQ==
X-Received: by 10.180.74.172 with SMTP id u12mr13845591wiv.0.1368370369009;
        Sun, 12 May 2013 07:52:49 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2f70:4010:a807:d8d1:bb90:9ecf? ([2a01:e35:2f70:4010:a807:d8d1:bb90:9ecf])
        by mx.google.com with ESMTPSA id s1sm9805879wiz.2.2013.05.12.07.52.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 May 2013 07:52:46 -0700 (PDT)
Message-ID: <518FACBF.4040606@openwrt.org>
Date:   Sun, 12 May 2013 16:52:47 +0200
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To:     Jonas Gorski <jogo@openwrt.org>
CC:     dedekind1@gmail.com, linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: BCM63XX: export PSI size from nvram
References: <1364044070-10486-1-git-send-email-jogo@openwrt.org> <1364044070-10486-3-git-send-email-jogo@openwrt.org> <1368189407.26780.159.camel@sauron.fi.intel.com> <CAOiHx=m+ZuBcj=qmTtytWouCbtbj+_OX3dS8x_0=kHEBFZ+TmA@mail.gmail.com>
In-Reply-To: <CAOiHx=m+ZuBcj=qmTtytWouCbtbj+_OX3dS8x_0=kHEBFZ+TmA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Le 12/05/2013 12:48, Jonas Gorski a écrit :
> On Fri, May 10, 2013 at 2:36 PM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
>> On Sat, 2013-03-23 at 14:07 +0100, Jonas Gorski wrote:
>>> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
>>> ---
>>>   arch/mips/bcm63xx/nvram.c                          |   11 +++++++++++
>>>   arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h |    2 ++
>>>   2 files changed, 13 insertions(+)
>>
>> Acks from MIPS folks would be nice to have, but I pushed this patch to
>> the l2-mtd.git tree, thanks!
>
> I had expected Florian's valid comment from preventing this series
> from going in, but if you pushed it already then I will fix the return
> type problem  that Florian pointed out in a separate patch (or rather
> add add some range check for nvram.psi_size). Luckily it is a
> theoretical issue only, as I haven't seen a device yet with an invalid
> value.

Right, but this is no blocker from my perspective. As about the MIPS 
folks, Maxime, Kevin, Jonas and myself have been the "historical" 
contributors to the MIPS BCM63XX port, so I would consider Jonas to be 
authoritave here for these paches. John and Ralf usually do not comment 
unless the see something bad.
--
Florian
