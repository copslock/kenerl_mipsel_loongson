Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Dec 2004 23:14:14 +0000 (GMT)
Received: from [IPv6:::ffff:67.109.220.20] ([IPv6:::ffff:67.109.220.20]:52410
	"EHLO starbase.tos.net") by linux-mips.org with ESMTP
	id <S8225273AbUL0XOJ>; Mon, 27 Dec 2004 23:14:09 +0000
Received: from intrepid (c-67-175-6-30.client.comcast.net [67.175.6.30])
	(authenticated bits=0)
	by starbase.tos.net (8.13.1/8.13.1) with ESMTP id iBRNDgc6013040
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linux-mips@linux-mips.org>; Mon, 27 Dec 2004 17:13:42 -0600
Message-Id: <200412272313.iBRNDgc6013040@starbase.tos.net>
From: "Habeeb J. Dihu" <macgyver@tos.net>
To: <linux-mips@linux-mips.org>
Subject: 2.6.9 Cobalt Tulip lockups.
Date: Mon, 27 Dec 2004 17:12:50 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
thread-index: AcTsaZXvzQx36tlZSW6UHgkY7xP3eg==
X-Virus-Scanned: ClamAV 0.80/618/Sun Dec  5 17:09:24 2004
	clamav-milter version 0.80j
	on starbase.tos.net
X-Virus-Status: Clean
Return-Path: <macgyver@tos.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macgyver@tos.net
Precedence: bulk
X-list: linux-mips

Firstly...hope everyone enjoyed (or is still enjoying) their holidays.

Just joined the mailing list.  Apologies on the longish post, but I wanted
to provide as much information as possible.

I've got a couple of Cobalt boxes (a RaQ2 and a Qube2) that are successfully
running Debian (as well as Gentoo) running the 2.6.9 branch of CVS plus
Peter Horton's patches.  The machines are quite stable and I really haven't
run into any issues until I start stress-testing networking.

Under high network loads when connected at 100TX FDX, I can always get the
Cobalts to lock up.  Under anything slower -- 100TX HDX, 10TX FDX, 10TX HDX
-- everything works fine.  This problem is specific to:

1.  Lots of data transfer to/from the Cobalt.
2.  Running at 100TX FDX.

The test scenario is:

Cobalt running 2.6.9CVS + PH's patches.  Cobalt is running an NFS server.
From another machine on the network (also running at 100TX FDX), mount the
NFS export and copy something huge (in my case a directory that has about
2GB worth of files in it).

It'll usually get anywhere from 300MB to 800MB of data before the Cobalt
just locks up -- no kernel panic, just a hard lockup that necessitates
cycling power manually.

At first I thought it might be NFS, so I tried something way less kernel
dependent like FTP and still had the same problems.  I also recompiled the
kernel with:

CONFIG_TULIP_MWI=n
CONFIG_TULIP_MMIO=n
CONFIG_TULIP_NAPI=n
CONFIG_TULIP_NAPI_HW_MITIGATION=n

as well as set to yes to no avail.

As a last resort I turned on lots of debugging output (I set tulip_debug to
99) and finally I got something usable from the kernel:

eth0: MII status 782d, Link partner report 45e1.
eth0: 21143 negotiation status 000000c6, MII.
Badness in local_bh_enable at kernel/softirq.c:141
Call Trace: [<800b32c8>]  [<80084e28>]  [<80397ee8>]  [<80397f08>]
[<80398af4>]  [<8029a374>]  [<800b87ac>]  [<800ad20c>]  [<8029ccbc>]
[<802bc8b0>]  [<802bc918>]  [<802bcba8>]  [<802575bc>]  [<8027b370>]
[<800abe34>]  [<800abe34>]  [<800b3168>]  [<800abebc>]  [<800abf80>]
[<800ac6b8>]  [<8022e900>]  [<800ac34c>]  [<8022e900>]  [<800ac278>]
[<800ac174>]  [<80279dec>]  [<80279980>]  [<800b8954>]  [<802b9458>]
[<800b3168>]  [<80084808>]  [<800b3208>]  [<80084e18>]  [<80082908>]
[<802dc1bc>]  [<80083180>]  [<802d89d8>]  [<8030ffdc>]  [<80303260>]
[<802da298>]  [<80084e28>]  [<8029afb0>]  [<8029b330>]  [<80138718>]
[<802dad80>]  [<80134538>]  [<800a4198>]  [<802d07c0>]  [<803031ec>]
[<8030ffdc>]  [<80214364>]  [<80295864>]  [<800a7440>]  [<8030ffdc>]
[<80214364>]  [<80295894>]  [<80295864>]  [<8029b7b4>]  [<80303ab8>]
[<80303aa0>]  [<8020e0d4>]  [<800a7440>]  [<802120f4>]  [<800a40c8>]
[<80310070>]  [<80398698>]  [<80398840>]  [<8029ca50>]  [<801d6f8c>]
[<8029cd50>]  [<8039918c>]  [<801cab18>]  [<8039b554>]  [<8039c8a4>]
[<801d8068>]  [<80397740>]  [<800bdbe8>]  [<801c7398>]  [<801c7274>]
[<801c70cc>]  [<80086070>]  [<80086060>] 

I'd already deduced that it was probably a problem related to interrupts
(seems we have a lot of those issues on our lovely blue boxes).  Looking at
the relevant line in kernel/softirq.c yields:

void local_bh_enable(void)
{
        __local_bh_enable();
        WARN_ON(irqs_disabled());
        if (unlikely(!in_interrupt() &&
                     local_softirq_pending()))
                invoke_softirq();
        preempt_check_resched();
}
EXPORT_SYMBOL(local_bh_enable);

So it's clear that something's calling local_bh_enable while interrupts are
disabled, which they shouldn't be.  I can recreate this problem at will --
so it's definitely replicable.  I've really taken this as far as I can in
terms of debugging the problem on my own.  I'd appreciate any/all
assistance/direction in how to track down the culprit here and fix the
problem.

Thanks,

Habeeb.
