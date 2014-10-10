Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 19:36:39 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:52141 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011109AbaJJRghmbcIw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Oct 2014 19:36:37 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id C55BA2802FD;
        Fri, 10 Oct 2014 19:35:42 +0200 (CEST)
Received: from Dicker-Alter.local (p5B324634.dip0.t-ipconnect.de [91.50.70.52])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Fri, 10 Oct 2014 19:35:42 +0200 (CEST)
Message-ID: <5438191C.5030402@openwrt.org>
Date:   Fri, 10 Oct 2014 19:36:28 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org,
        Jeffrey Deans <Jeffrey.Deans@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH 1/2] MIPS: ralink: add gic support
References: <1412933645-55061-1-git-send-email-blogic@openwrt.org> <CAL1qeaHPSdLwec5-V8PHLuyicgNUF74vO0gY7Y7U2k-etQ7eBw@mail.gmail.com>
In-Reply-To: <CAL1qeaHPSdLwec5-V8PHLuyicgNUF74vO0gY7Y7U2k-etQ7eBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43216
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



On 10/10/2014 19:01, Andrew Bresticker wrote:
> Hi John,
> 
> On Fri, Oct 10, 2014 at 2:34 AM, John Crispin <blogic@openwrt.org>
> wrote:
>> The mt7621 has a GIC. rather than handle both irq coree in one
>> file we add a secondary irq-gic.c.
> 
> Why not use the current GIC driver that I've been fixing up?  I 
> believe Ralf will be applying the first set of clean-ups soon and
> I'm planning on doing additional clean-up and adding device-tree
> support. I have a work-in-progress branch here if you're
> interested: https://github.com/abrestic/linux/tree/mips-gic-dt-wip

Hi,

yep, already stumbled across those patches. i will send an updated
version start of the week. thanks for the link. I will ping you if i
have questions.

	John

> 
>> diff --git a/arch/mips/ralink/irq-gic.c
>> b/arch/mips/ralink/irq-gic.c new file mode 100644 index
>> 0000000..0ae7ea0 --- /dev/null +++ b/arch/mips/ralink/irq-gic.c
> 
>> +static int __init +of_gic_init(struct device_node *node, +
>> struct device_node *parent)
> 
>> +       if (of_address_to_resource(node, 2, &gcmp)) +
>> panic("Failed to get gic memory range"); +       if
>> (request_mem_region(gcmp.start, resource_size(&gcmp), +
>> gcmp.name) < 0) +               panic("Failed to request gcmp
>> memory");
> 
> Ah, so this SoC has a CM2 as well.  Is it at the address reported
> by C0_CMGCRBase?  If so, then mips_cm_probe() will be able to find
> it and set it up.  Otherwise, device-tree based probing should
> probably be added to the mips-cm driver.
> 
> 
