Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 11:02:01 +0200 (CEST)
Received: from atomos.longlandclan.id.au ([IPv6:2001:44b8:21ac:7000::1]:58005
        "EHLO atomos.longlandclan.id.au" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991512AbdFEJBxC3Dgc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2017 11:01:53 +0200
Received: from [IPv6:2001:44b8:21ac:7053:65::fe] (unknown [IPv6:2001:44b8:21ac:7053:65::fe])
        by atomos.longlandclan.id.au (Postfix) with ESMTPSA id 62CAE240FF72
        for <linux-mips@linux-mips.org>; Mon,  5 Jun 2017 19:01:37 +1000 (EST)
Subject: Re: QEMU Malta emulation using I6400: runaway loop modprobe
 binfmt-464c
To:     linux-mips@linux-mips.org
References: <996c275d-d969-508e-6b4e-bef22d8e7385@longlandclan.id.au>
 <alpine.DEB.2.00.1706031310470.2590@tp.orcam.me.uk>
 <81bca3a5-88dc-d6af-9c6a-3e17d9a8bda5@longlandclan.id.au>
 <alpine.DEB.2.00.1706041556050.10864@tp.orcam.me.uk>
From:   Stuart Longland <stuartl@longlandclan.id.au>
Openpgp: id=BCA11879F4F93BE3DB0DEE72F954BBBB7948D546;
 url=https://stuartl.longlandclan.id.au/key.asc
Message-ID: <174b9af5-5c53-af6a-8734-9ed9fe333b93@longlandclan.id.au>
Date:   Mon, 5 Jun 2017 19:01:27 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1706041556050.10864@tp.orcam.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <stuartl@longlandclan.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuartl@longlandclan.id.au
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

On 05/06/17 01:12, Maciej W. Rozycki wrote:
>>  What's the effect on pre-2008 CPUs?
>  The same as with running legacy-NaN software on a 2008-NaN processor -- 
> by default the kernel will refuse execution of such a binary, or you can 
> use the kernel options I quoted to change that, and likewise with the 
> `ieee754=relaxed' option you risk incorrect results, including a possible 
> crash.  There is symmetry here.

Ahh no worries… well, every *real* CPU I have, is pre-2008, the Yeeloong
being the newest of the lot (the machine was bought brand-new in 2009).

Looks like the `nofpu` route will be the best option in my case, even if
it means slower floating-point performance, the point of the exercise is
for package builds for my existing hardware which is MIPS-IV ISA level
at best.

(…And this is not something that is likely to change either, sadly ARM
has won the consumer development board market with devices like the
Raspberry Pi and Beagle Bone.  Imagination Tech are doing good things,
and 10 years ago I might've bought a board, but it's too late for me now.)

Many thanks for the pointers there.  I have some ideas now what I can
try next.
Regards,
-- 
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
