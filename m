Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Oct 2014 11:06:28 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:39791 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010767AbaJPJG1P0ruM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Oct 2014 11:06:27 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 015D82803BB;
        Thu, 16 Oct 2014 11:05:28 +0200 (CEST)
Received: from dicker-alter.lan (p548C8443.dip0.t-ipconnect.de [84.140.132.67])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Thu, 16 Oct 2014 11:05:27 +0200 (CEST)
Message-ID: <543F8A91.9050602@openwrt.org>
Date:   Thu, 16 Oct 2014 11:06:25 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: ralink: add gic support
References: <1412933645-55061-1-git-send-email-blogic@openwrt.org> <CAL1qeaHPSdLwec5-V8PHLuyicgNUF74vO0gY7Y7U2k-etQ7eBw@mail.gmail.com>
In-Reply-To: <CAL1qeaHPSdLwec5-V8PHLuyicgNUF74vO0gY7Y7U2k-etQ7eBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43297
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

Hi Andrew,

>> +static int __init
>> +of_gic_init(struct device_node *node,
>> +                               struct device_node *parent)
>> +       if (of_address_to_resource(node, 2, &gcmp))
>> +               panic("Failed to get gic memory range");
>> +       if (request_mem_region(gcmp.start, resource_size(&gcmp),
>> +                               gcmp.name) < 0)
>> +               panic("Failed to request gcmp memory");
> Ah, so this SoC has a CM2 as well.  Is it at the address reported by
> C0_CMGCRBase?  If so, then mips_cm_probe() will be able to find it and
> set it up.  Otherwise, device-tree based probing should probably be
> added to the mips-cm driver.

i change my code and made use of mips-cm. unit boots fine now and indeed
C0_CMGCRBase holds the valid address. I will look into updating the gic
code to use the generic driver once i cleaned up the remainig mt7621
patches.

i had to apply a hack to mips-cm.c to disable the "disable CM regions"
code, this deadlocked the mt7621. i will send a separate regarding this
in a sec.

    John
