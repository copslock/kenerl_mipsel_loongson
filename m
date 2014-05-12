Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2014 21:24:19 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:40844 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822276AbaELTYNbNy1o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 May 2014 21:24:13 +0200
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id EEB835437B0;
        Mon, 12 May 2014 21:24:05 +0200 (CEST)
Message-ID: <53711FDD.6090905@openwrt.org>
Date:   Mon, 12 May 2014 21:24:13 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Waldemar Brodkorb <wbx@openadk.org>, linux-mips@linux-mips.org
CC:     florian@openwrt.org, nbd@openwrt.org, phil@nwl.cc
Subject: Re: pci problem with rb532
References: <20140510213508.GC618@waldemar-brodkorb.de>
In-Reply-To: <20140510213508.GC618@waldemar-brodkorb.de>
X-Enigmail-Version: 1.6
Content-Type: multipart/mixed;
 boundary="------------090309060908060203070607"
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

This is a multi-part message in MIME format.
--------------090309060908060203070607
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Waldemar,

> I recently had a need for a small DHCP/NFS server and resurvived my
> old Mikrotik RB532 board. Sadly the PCI registration is broken and
> the VIA Rhine network ports didn't work.
> See this thread for some details:
> https://www.mail-archive.com/openwrt-devel@lists.openwrt.org/msg23073.html
> 
> I did know that it was working fine in the past, so I started to git
> bisect between 2.6.39 and 3.15-rc5.
> Following commit is the problem:
> commit 222831787704c9ad9215f6b56f975b233968607c
> Author: Gabor Juhos <juhosg@openwrt.org>
> Date:   Sat Feb 2 13:18:54 2013 +0000
> 
>     MIPS: avoid possible resource conflict in register_pci_controller
>     
>     The IO and memory resources of a PCI controller
>     might already have a parent resource set when
>     they are passed to 'register_pci_controller'.
>     
>     If the parent resource is set, the request_resource
>     call will fail due to resource conflict and the
>     current code will not be able to register the
>     PCI controller.
>     
>     Use the parent resource if it is available in the
>     request_resource call to avoid the isssue.
>     
>     Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
>     Patchwork: http://patchwork.linux-mips.org/patch/4910/
>     Signed-off-by: John Crispin <blogic@openwrt.org>
> 
> After reverting the change, the VIA Rhine driver works fine again.
> 
> So how we can unbreak the rb532 support?

Please try the attached patch without reverting the aforementioned change.

Thanks,
Gabor

--------------090309060908060203070607
Content-Type: text/x-patch;
 name="0001-MIPS-RC32434-fix-broken-PCI-resource-initialization.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-MIPS-RC32434-fix-broken-PCI-resource-initialization.pat";
 filename*1="ch"
