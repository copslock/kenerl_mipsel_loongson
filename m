Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 07:27:46 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:47407 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010257AbaJJF1pHvNYn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Oct 2014 07:27:45 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 198B8280298
        for <linux-mips@linux-mips.org>; Fri, 10 Oct 2014 07:26:51 +0200 (CEST)
Received: from dicker-alter.lan (p548C9AAE.dip0.t-ipconnect.de [84.140.154.174])
        by arrakis.dune.hu (Postfix) with ESMTPSA
        for <linux-mips@linux-mips.org>; Fri, 10 Oct 2014 07:26:50 +0200 (CEST)
Message-ID: <54376E45.8020904@openwrt.org>
Date:   Fri, 10 Oct 2014 07:27:33 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] DT: Add documentation for gpio-rt2880
References: <1412885241-12476-1-git-send-email-blogic@openwrt.org> <5436F058.6010406@cogentembedded.com>
In-Reply-To: <5436F058.6010406@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43190
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



On 09/10/2014 22:30, Sergei Shtylyov wrote:
> 
>> +- interrupts : Specify the INTC interrupt number +-
>> ralink,num-gpios : Specify the number of GPIOs +-
>> ralink,register-map : The register layout depends on the GPIO
>> bank and actual +        SoC type. Register offsets need to be in
>> this order. +        [ INT, EDGE, RENA, FENA, DATA, DIR, POL,
>> SET, RESET, TOGGLE ]
> 
> This should be determined by the "compatible" property alone, I
> think.

we specifically put this into dts as almost each of the SoC versions
has a different register layout. i really want to avoid having to
patch the gpio driver whenever ralink/mtk decides to "change the
registers yet again". I can change it if must be. but i really would
prefer to keep it this way as it will safe me lots of time in future

	John
