Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2014 11:04:08 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:37132 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011183AbaJ0KEGzwmEA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Oct 2014 11:04:06 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id CD38728063C
        for <linux-mips@linux-mips.org>; Mon, 27 Oct 2014 11:02:54 +0100 (CET)
Received: from dicker-alter.lan (p548CA1E7.dip0.t-ipconnect.de [84.140.161.231])
        by arrakis.dune.hu (Postfix) with ESMTPSA
        for <linux-mips@linux-mips.org>; Mon, 27 Oct 2014 11:02:54 +0100 (CET)
Message-ID: <544E188B.9000707@openwrt.org>
Date:   Mon, 27 Oct 2014 11:03:55 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: MIPS: ralink: CONFIG_RALINK_ILL_ACC?
References: <1414403681.28499.4.camel@x220>
In-Reply-To: <1414403681.28499.4.camel@x220>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43575
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



On 27/10/2014 10:54, Paul Bolle wrote:
> John,
> 
> Your commit 78865eacb4aa ("MIPS: ralink: add illegal access
> driver") landed in today's linux-next (ie, next-20141027). That
> commit dates back to May 16, 2013! It adds a driver that is built
> if CONFIG_RALINK_ILL_ACC is set. But there's no Kconfig symbol
> RALINK_ILL_ACC.
> 
> I assume that patch that adds this symbol is queued somewhere. Is
> that correct?
> 
> 
> Paul Bolle
> 
> 
> 

Hi Paul,

i'll look into it. the commit that move all dts files to a central
folder broke some of my patches so i had to rebase them. apparently
the bit that adds the symbol got lost.

out of interest, how did you spot this ?

John
