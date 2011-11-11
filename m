Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 01:29:32 +0100 (CET)
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:50563
        "EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904249Ab1KKA32 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2011 01:29:28 +0100
Received: from mail208-ch1-R.bigfish.com (10.43.68.243) by
 CH1EHSOBE014.bigfish.com (10.43.70.64) with Microsoft SMTP Server id
 14.1.225.22; Fri, 11 Nov 2011 00:28:56 +0000
Received: from mail208-ch1 (localhost.localdomain [127.0.0.1])  by
 mail208-ch1-R.bigfish.com (Postfix) with ESMTP id 47DD919D0296;        Fri, 11 Nov
 2011 00:29:09 +0000 (UTC)
X-SpamScore: -12
X-BigFish: VS-12(zz9371K1432N98dKzz1202hzz8275bhz2dh2a8h668h839h8e2h8e3h)
X-Forefront-Antispam-Report: CIP:70.37.183.190;KIP:(null);UIP:(null);IPVD:NLI;H:mail.freescale.net;RD:none;EFVD:NLI
Received: from mail208-ch1 (localhost.localdomain [127.0.0.1]) by mail208-ch1
 (MessageSwitch) id 1320971348760538_14051; Fri, 11 Nov 2011 00:29:08 +0000
 (UTC)
Received: from CH1EHSMHS014.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.245])        by mail208-ch1.bigfish.com (Postfix) with ESMTP id
 ABE43290051;   Fri, 11 Nov 2011 00:29:08 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by CH1EHSMHS014.bigfish.com
 (10.43.70.14) with Microsoft SMTP Server (TLS) id 14.1.225.22; Fri, 11 Nov
 2011 00:29:21 +0000
Received: from 039-SN1MPN1-005.039d.mgd.msft.net ([169.254.7.249]) by
 039-SN1MMR1-001.039d.mgd.msft.net ([10.84.1.13]) with mapi id 14.01.0339.002;
 Thu, 10 Nov 2011 18:29:20 -0600
From:   Tabi Timur-B04825 <B04825@freescale.com>
To:     David Daney <david.daney@cavium.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] netdev/phy: Use mdiobus_read() so that proper locks are
 taken.
Thread-Topic: [PATCH] netdev/phy: Use mdiobus_read() so that proper locks
 are taken.
Thread-Index: AQHMoAjzmJcV2MLvkk+iGBSrsAFzbQ==
Date:   Fri, 11 Nov 2011 00:29:19 +0000
Message-ID: <CAOZdJXXA6nBv8Gaqu=qcL2DxjNB-ENrxameVQTep9FEbZ1jtGQ@mail.gmail.com>
References: <1317419482-25655-1-git-send-email-david.daney@cavium.com>
In-Reply-To: <1317419482-25655-1-git-send-email-david.daney@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [50.17.22.104]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B6B970768B2E894DB75FB44393C9DF07@freescale.net>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
X-archive-position: 31514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: B04825@freescale.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9860

On Fri, Sep 30, 2011 at 4:51 PM, David Daney <david.daney@cavium.com> wrote:
> Accesses to the mdio busses must be done with the mdio_lock to ensure
> proper operation.  Conveniently we have the helper function
> mdiobus_read() to do that for us.  Lets use it in get_phy_id() instead
> of accessing the bus without the lock held.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---

This patch is causing me problems, but I'm not exactly certain how.
The problems only appear when I add some unrelated code to my platform
file (p1022ds.c), but the trap is definitely in the phy code:

Fixed MDIO Bus: probed
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
Call Trace:
[e685dcc0] [c0008c7c] show_stack+0x44/0x154 (unreliable)
[e685dd00] [c007bf74] __lock_acquire+0x1374/0x1824
[e685ddb0] [c007c870] lock_acquire+0x4c/0x68
[e685ddd0] [c0455fe4] mutex_lock_nested+0x6c/0x394
[e685de30] [c02acc08] mdiobus_read+0x3c/0x78
[e685de50] [c02abc98] get_phy_id+0x24/0x80
[e685de70] [c02b1860] fsl_pq_mdio_probe+0x3ac/0x458
[e685deb0] [c027ba2c] platform_drv_probe+0x20/0x30
[e685dec0] [c027a4b0] driver_probe_device+0xa4/0x1d4
[e685dee0] [c027a6a4] __driver_attach+0xc4/0xc8
[e685df00] [c027939c] bus_for_each_dev+0x60/0x9c
[e685df30] [c027a0e4] driver_attach+0x24/0x34
[e685df40] [c0279d30] bus_add_driver+0x1b0/0x278
[e685df70] [c027aab8] driver_register+0x88/0x154
[e685df90] [c027bd5c] platform_driver_register+0x68/0x78
[e685dfa0] [c05d47c8] fsl_pq_mdio_init+0x18/0x28
[e685dfb0] [c0001eb8] do_one_initcall+0x34/0x1ac
[e685dfe0] [c05b984c] kernel_init+0xa0/0x13c
[e685dff0] [c000e588] kernel_thread+0x4c/0x68
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc0456080
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=8 P1022 DS
Modules linked in:
NIP: c0456080 LR: c0456068 CTR: 00000000
REGS: e685dd20 TRAP: 0300   Not tainted  (3.2.0-10b-00092-g66f2305-dirty)
MSR: 00021000 <ME,CE>  CR: 22042044  XER: 20000000
DEAR: 00000000, ESR: 00800000
TASK = e6860000[1] 'swapper' THREAD: e685c000 CPU: 0
GPR00: ffffffff e685ddd0 e6860000 e6e58028 e685ddd8 e685c000 e685dde4 00000002
GPR08: 00000000 00000000 00000000 00000000 44042022 40401800 00000000 00000000
GPR16: c0000a00 00000014 3fffffff 03ff9000 00000015 7ff3a68c c061e000 00000000
GPR24: e6e5804c e685ddd8 e6e5802c 00029000 e6860000 c0620000 e685c000 e6e58028
NIP [c0456080] mutex_lock_nested+0x108/0x394
LR [c0456068] mutex_lock_nested+0xf0/0x394
Call Trace:
[e685ddd0] [c0456068] mutex_lock_nested+0xf0/0x394 (unreliable)
[e685de30] [c02acc08] mdiobus_read+0x3c/0x78
[e685de50] [c02abc98] get_phy_id+0x24/0x80
[e685de70] [c02b1860] fsl_pq_mdio_probe+0x3ac/0x458
[e685deb0] [c027ba2c] platform_drv_probe+0x20/0x30
[e685dec0] [c027a4b0] driver_probe_device+0xa4/0x1d4
[e685dee0] [c027a6a4] __driver_attach+0xc4/0xc8
[e685df00] [c027939c] bus_for_each_dev+0x60/0x9c
[e685df30] [c027a0e4] driver_attach+0x24/0x34
[e685df40] [c0279d30] bus_add_driver+0x1b0/0x278
[e685df70] [c027aab8] driver_register+0x88/0x154
[e685df90] [c027bd5c] platform_driver_register+0x68/0x78
[e685dfa0] [c05d47c8] fsl_pq_mdio_init+0x18/0x28
[e685dfb0] [c0001eb8] do_one_initcall+0x34/0x1ac
[e685dfe0] [c05b984c] kernel_init+0xa0/0x13c
[e685dff0] [c000e588] kernel_thread+0x4c/0x68
Instruction dump:
7f24cb78 4bc21141 80bc0004 7fe3fb78 7f24cb78 4bc21325 813f0028 3b1f0024
933f0028 3800ffff 93010008 9121000c
 93810010 7c0004ac 7d20f828
---[ end trace 7cc8bbd19b132dac ]---
note: swapper[1] exited with preempt_count 1
Kernel panic - not syncing: Attempted to kill init!
Call Trace:
[e685dc00] [c0008c7c] show_stack+0x44/0x154 (unreliable)
[e685dc40] [c04583a0] panic+0xb4/0x1f0
[e685dc90] [c004724c] do_exit+0x5dc/0x684
[e685dce0] [c000b368] die+0xdc/0x1b4
[e685dd00] [c00137fc] bad_page_fault+0xb4/0xfc
[e685dd10] [c000f998] handle_page_fault+0x7c/0x80
--- Exception: 300 at mutex_lock_nested+0x108/0x394
    LR = mutex_lock_nested+0xf0/0x394
[e685de30] [c02acc08] mdiobus_read+0x3c/0x78
[e685de50] [c02abc98] get_phy_id+0x24/0x80
[e685de70] [c02b1860] fsl_pq_mdio_probe+0x3ac/0x458
[e685deb0] [c027ba2c] platform_drv_probe+0x20/0x30
[e685dec0] [c027a4b0] driver_probe_device+0xa4/0x1d4
[e685dee0] [c027a6a4] __driver_attach+0xc4/0xc8
[e685df00] [c027939c] bus_for_each_dev+0x60/0x9c
[e685df30] [c027a0e4] driver_attach+0x24/0x34
[e685df40] [c0279d30] bus_add_driver+0x1b0/0x278
[e685df70] [c027aab8] driver_register+0x88/0x154
[e685df90] [c027bd5c] platform_driver_register+0x68/0x78
[e685dfa0] [c05d47c8] fsl_pq_mdio_init+0x18/0x28
[e685dfb0] [c0001eb8] do_one_initcall+0x34/0x1ac
[e685dfe0] [c05b984c] kernel_init+0xa0/0x13c
[e685dff0] [c000e588] kernel_thread+0x4c/0x68
Rebooting in 1 seconds..

I'm still trying to narrow down what's causing the problem, but when I
revert this patch, I don't see these traps.

Sometimes, I don't get the trap, but I get a hang on this line:

int mdiobus_read(struct mii_bus *bus, int addr, u32 regnum)
{
	int retval;

	BUG_ON(in_interrupt());

--->	mutex_lock(&bus->mdio_lock);

-- 
Timur Tabi
Linux kernel developer at Freescale
