Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2010 23:02:49 +0200 (CEST)
Received: from mail1.adax.com ([208.201.231.104]:10026 "EHLO mail1.adax.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491069Ab0FQVCq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Jun 2010 23:02:46 +0200
Received: from static-151-204-189-187.pskn.east.verizon.net (static-151-204-189-187.pskn.east.verizon.net [151.204.189.187])
        by mail1.adax.com (Postfix) with ESMTP id 0E2D41209EC
        for <linux-mips@linux-mips.org>; Thu, 17 Jun 2010 14:02:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by static-151-204-189-187.pskn.east.verizon.net (Postfix) with ESMTP id 46CE7201E7
        for <linux-mips@linux-mips.org>; Thu, 17 Jun 2010 17:02:42 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at
        static-151-204-189-187.pskn.east.verizon.net
Received: from static-151-204-189-187.pskn.east.verizon.net ([127.0.0.1])
        by localhost (static-151-204-189-187.pskn.east.verizon.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3NfQ8HElrv3v for <linux-mips@linux-mips.org>;
        Thu, 17 Jun 2010 17:02:40 -0400 (EDT)
Received: from [192.168.1.76] (jr001327.mtl-nj.adax [192.168.1.76])
        by static-151-204-189-187.pskn.east.verizon.net (Postfix) with ESMTPS id 6D8EF201AA
        for <linux-mips@linux-mips.org>; Thu, 17 Jun 2010 17:02:40 -0400 (EDT)
Message-ID: <4C1A8D86.60005@adax.com>
Date:   Thu, 17 Jun 2010 17:03:02 -0400
From:   Jan Rovins <janr@adax.com>
Organization: Adax Inc.
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Help with decoding a NMI Watchdog interrupt on an Octeon
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 27163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: janr@adax.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12379

Hi, I need some tips on how to go about deciphering the following NMI dump.

This is from a 2.6.21.7 kernel that came with the Cavium Networks 1.8.1 
toolchain.
Is there any way to get some kind of back trace from this, or just find 
out which function it was in?

I have been playing around with objdump -x vmlinux  but I cant zero in 
on anything this way.

Thanks in advance,

 Jan
*** NMI Watchdog interrupt on Core 0x6 ***
        $0      0x0000000000000000      at      0x000000001010cce0
        v0      0x000000000000003d      v1      0x000000000000024a
        a0      0xffffffff807d7b70      a1      0x0000000000000000
        a2      0x000000000000024a      a3      0x0000000000000000
        a4      0xffffffff807d7b60      a5      0x0000000000000080
        a6      0x0000000000000001      a7      0xa800000411c62578
        t0      0x0000000000000001      t1      0xa80000048ef3e880
        t2      0xffffffff82d40000      t3      0xa80000041f48c000
        s0      0xc0000000000d9640      s1      0xc000000000088028
        s2      0x0000000000000000      s3      0x0000000000000180
        s4      0x0000000000000000      s5      0x0000000000000000
        s6      0xb7a89c196f513832      s7      0x0000000000000000
        t8      0xffffffff807d0000      t9      0xffffffff807d0000
        k0      0x0000000000000000      k1      0x00000000104dbcbf
        gp      0xa80000041f48c000      sp      0xa80000041f48fcf0
        s8      0x0000000000000000      ra      0xc0000000023c5004
        epc     0xffffffff802b10b8
        status  0x000000001058cce4      cause   0x0000000040008c08
        sum0    0x0000002100000000      en0     0x0000009300008000
Code around epc
        0xffffffff802b10a8      000000002406ffff
        0xffffffff802b10ac      0000000064a5ffff
        0xffffffff802b10b0      0000000010a60005
        0xffffffff802b10b4      0000000000000000
        0xffffffff802b10b8      0000000080620000
        0xffffffff802b10bc      000000001440fffb
        0xffffffff802b10c0      0000000064630001
        0xffffffff802b10c4      000000006463ffff
        0xffffffff802b10c8      0000000003e00008
