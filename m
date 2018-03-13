Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2018 23:41:21 +0100 (CET)
Received: from mx1.mailbox.org ([80.241.60.212]:50070 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990498AbeCMWlGwKAsw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Mar 2018 23:41:06 +0100
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 58A7D42D6F;
        Tue, 13 Mar 2018 23:41:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id ngNM_5Z53nYu; Tue, 13 Mar 2018 23:41:00 +0100 (CET)
Subject: Re: [PATCH 3/3] MIPS: lantiq: ase: Enable MFD_SYSCON
To:     James Hogan <jhogan@kernel.org>
Cc:     ralf@linux-mips.org, john@phrozen.org, dev@kresin.me,
        linux-mips@linux-mips.org, martin.blumenstingl@googlemail.com
References: <20180311174123.2578-1-hauke@hauke-m.de>
 <20180311174123.2578-3-hauke@hauke-m.de> <20180312213938.GC21642@saruman>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <70673d93-03c5-6bf6-54a4-bee9f9271304@hauke-m.de>
Date:   Tue, 13 Mar 2018 23:40:59 +0100
MIME-Version: 1.0
In-Reply-To: <20180312213938.GC21642@saruman>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 03/12/2018 10:39 PM, James Hogan wrote:
> On Sun, Mar 11, 2018 at 06:41:23PM +0100, Hauke Mehrtens wrote:
>> From: Mathias Kresin <dev@kresin.me>
>>
>> Enable syscon to use it for the RCU MFD on Amazon SE as well.
>>
>> Fixes: 2b6639d4c794 ("MIPS: lantiq: Enable MFD_SYSCON to be able to use it for the RCU MFD")
>> Signed-off-by: Mathias Kresin <dev@kresin.me>
> 
> I'm just trying to dig around to find some context. Just a bit more
> information to say what DT / driver / device this helps with would make
> all the difference :)
> 
> Does this directly benefit mainline (maybe for DTs other than those
> in arch/mips/boot/dts/), or is it mainly for the sake of out-of-tree
> code?
> 
> Do you want it tagged for stable backports, and if so how far back?
> 
> Cheers
> James
> 

We changed the RCU controller drivers for kernel 4.14 and this was
missing for the Amazon SE SoC. The xrx200/VR9 SoC is the successor of
the Amazon SE and Danube SoC, but the older SoCs still share the
architecture and many IP cores with the more recent ones.

This is also relevant for upstream kernel, should I extend the
descriptions of the commit messages and send a V2 of the 3 patches?

Hauke
