Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 12:53:11 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:43617 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012108AbaJVKxKOpbLQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Oct 2014 12:53:10 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id DCEAD28028D
        for <linux-mips@linux-mips.org>; Wed, 22 Oct 2014 12:52:05 +0200 (CEST)
Received: from dicker-alter.lan (p548C87DD.dip0.t-ipconnect.de [84.140.135.221])
        by arrakis.dune.hu (Postfix) with ESMTPSA
        for <linux-mips@linux-mips.org>; Wed, 22 Oct 2014 12:52:05 +0200 (CEST)
Message-ID: <54478C94.4060208@openwrt.org>
Date:   Wed, 22 Oct 2014 12:53:08 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: Single MIPS kernel
References: <20141022083437.GB18581@linux-mips.org>
In-Reply-To: <20141022083437.GB18581@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Hi Ralf,

On 22/10/2014 10:34, Ralf Baechle wrote:
> This question comes up every once in a while and I've also been
> approached during ELCE in Düsseldorf why there is no single MIPS
> kernel for all platforms, so I thought I should post a writeup on
> the topic.
> 

for the SoCs supported by OpenWrt this is a no-go. we are already
having a hard time fighting bloat. to get the images to fit we need to
already build device specific images that only hold the DT, drivers,
... that a specific board needs. having a kernel that can boot on X
devices wont even fit into flash and if it does there is not space
left for the userland.

I think this feature is only interesting for the older platforms and
the upcoming mobile SoC based in MIPS. i.e. the users are debian and
android type device.

	John
