Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Jun 2010 16:37:51 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:35310 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492056Ab0FZOhr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Jun 2010 16:37:47 +0200
Received: by pwj6 with SMTP id 6so22312pwj.36
        for <linux-mips@linux-mips.org>; Sat, 26 Jun 2010 07:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=J/iXc2+efifvAhw/XechasIpym3GoEmt8CHbVg1hmMU=;
        b=vQ0KXH7DX/PBp6y+zQrkhHirChE35b6/72VBizvbiiA8D2GbdtlH0uJgfyzEv9HIpu
         isNILZBHFE6g1q1QZM40i/Kjt4JHMMqJrhn1EzMCdbFTFK1IvhctcxdeurofMY9s32Uy
         lvnYkkxQ660UPBjkdQZTiv1SLlBCvA96fhhug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=c4INrXoUEqg9xD9UsGhOnSz2ZTcv5dfosM7bxAlqhQHfjgJ1ufuWaqdkZaxx45GKmk
         wqWsinm6WQlPLuwSIksZAILMudfeAVsmjxRxWsBHr8wLeSbUb3lvJ1rgL3j2geYpr6ym
         T2nlMD+2rvxvjqQhmnkQq8uBKhCLKB/0PCiIQ=
Received: by 10.114.33.32 with SMTP id g32mr2553268wag.173.1277563060261;
        Sat, 26 Jun 2010 07:37:40 -0700 (PDT)
Received: from [180.110.217.69] ([180.110.217.69])
        by mx.google.com with ESMTPS id s29sm10030118wak.14.2010.06.26.07.37.38
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 07:37:39 -0700 (PDT)
Message-ID: <4C2610AF.7080404@gmail.com>
Date:   Sat, 26 Jun 2010 22:37:35 +0800
From:   Zhuang Yuyao <mlistz@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: [BUG] cavium octeon kernel bug detected under stress test
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 27254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlistz@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17891

Hi,

I am not sure if this mail list is the proper place to report this bug, 
but it is happened on my cavium octeon platform.

While doing stress test (more than 1500 new connections per second) on a 
ssl proxy program (etunnel, which is written by me),  I always got the 
following kernel complain after 1-2 hours:

Kernel bug detected[#1]:
Cpu 10
$ 0   : 0000000000000000 0000000000000001 0000000000000001 ffffffffc0a80a29
$ 4   : a8000000d02a2aa0 a8000000ca99f9d0 0000000000000001 0000000000000000
$ 8   : 0000000000000000 6574683000000000 0000000000000000 ffffffff816412a0
$12   : 00000000000016a0 ffffffffffffffff 0000000000000000 0000000000000001
$16   : a8000000d02a2aa0 a8000000ca99f9d0 0000000000000003 0000000000000001
$20   : 0000000000000000 0000000000000001 ffffffff813ec790 0000000000000000
$24   : 0000000000000000 ffffffffc0045130
$28   : a8000000ca99c000 a8000000ca99f8f0 0000000000000001 ffffffffc0045170
Hi    : 0000000000000001
Lo    : 0000000055555556
epc   : ffffffffc003ba74 nf_nat_setup_info+0x84/0x8c0 [nf_nat]
     Not tainted
ra    : ffffffffc0045170 alloc_null_binding+0x40/0xb0 [iptable_nat]
Status: 10108ce3    KX SX UX KERNEL EXL IE
Cause : 00800034
PrId  : 000d0409 (Cavium Octeon)
Modules linked in: ebtable_broute ebtables nf_nat_ftp nf_conntrack_ftp 
ipt_REJECT ipt_LOG xt_state iptable_filter iptable_mangle iptable_nat 
nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack ip_tables x_tables
Process etunnel (pid: 1160, threadinfo=a8000000ca99c000, 
task=a8000000ca808238, tls=00000055573e4910)
Stack : 0000000000000014 0000000302000000 a8000000ca99f8a0 ffffffff8114ae28
         a8000000cd45bd80 0000000000000003 c000000000f50000 a8000000d0285000
         a8000000cd45bd8c a8000000cf6a78a9 ffffffffc000f5a8 00000003020173c4
         a8000000ca99f8f0 ffffffff8164beb0 a8000000d1331880 0000000000000003
         c000000000f8d000 0000000000000070 a8000000d02a2aa0 a8000000caa29378
         0000000000000003 0000000000000002 0000000000000000 0000000000000001
         ffffffff813ec790 ffffffff80000000 0000000000000001 ffffffffc0045170
         00000001c0a80a29 c0a80a2900000000 a8000000caa29378 ffffffffc004552c
         0000000000000000 a8000000d0285000 ffffffff813ec790 a8000000caa29378
         ffffffff8164cfc0 a8000000caa29378 0000000000000003 0000000000000000
         ...
Call Trace:
[<ffffffffc003ba74>] nf_nat_setup_info+0x84/0x8c0 [nf_nat]
[<ffffffffc0045170>] alloc_null_binding+0x40/0xb0 [iptable_nat]
[<ffffffffc004552c>] cleanup_module+0x174/0x530 [iptable_nat]


Code: de020090  7042f9fa  30420001 <00028036> 3c16c001  03a0202d  
66d678b0  02c0f809  66050068
Disabling lock debugging due to kernel taint

The hardware platform is cavium octeon cn56xx pass2, kernel version 
2.6.32.15, 64bit, big endian.

Any help will be appreciated, Thanks very much.

Best regards,

Zhuang Yuyao
