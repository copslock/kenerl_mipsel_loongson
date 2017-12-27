Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 09:31:15 +0100 (CET)
Received: from helium.openadk.org ([IPv6:2a00:1828:2000:679::23]:55059 "EHLO
        helium.openadk.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990394AbdL0IbI4uPnM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Dec 2017 09:31:08 +0100
Received: by helium.openadk.org (Postfix, from userid 1000)
        id 9F2D41072C; Wed, 27 Dec 2017 09:31:07 +0100 (CET)
Date:   Wed, 27 Dec 2017 09:31:07 +0100
From:   Waldemar Brodkorb <wbx@openadk.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "Maciej W . Rozycki" <macro@mips.com>,
        Matthew Fortune <matthew.fortune@mips.com>,
        Florian Fainelli <florian@openwrt.org>,
        Waldemar Brodkorb <wbx@openadk.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Implement __multi3 for GCC7 MIPS64r6 builds
Message-ID: <20171227083107.GI27558@waldemar-brodkorb.de>
References: <20171206085034.3869dc9d@windsurf.lan>
 <20171207072046.31125-1-jhogan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171207072046.31125-1-jhogan@kernel.org>
X-Operating-System: Linux 3.16.0-4-amd64 x86_64
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <wbx@openadk.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wbx@openadk.org
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

Hi James,
James Hogan wrote,

> GCC7 is a bit too eager to generate suboptimal __multi3 calls (128bit
> multiply with 128bit result) for MIPS64r6 builds, even in code which
> doesn't explicitly use 128bit types, such as the following:
> 
> unsigned long func(unsigned long a, unsigned long b)
> {
> 	return a > (~0UL) / b;
> }
> 
> Which GCC rearanges to:
> 
> return (unsigned __int128)a * (unsigned __int128)b > 0xffffffff;
> 
> Therefore implement __multi3, but only for MIPS64r6 with GCC7 as under
> normal circumstances we wouldn't expect any calls to __multi3 to be
> generated from kernel code.

I tested the patch and it works fine for me. I can build a mips64r6
kernel and run the uClibc-ng testsuite inside qemu system emulation.

It works for me with 4.9.x and 4.14.x kernels.

Thanks
 Waldemar
