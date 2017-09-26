Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2017 17:13:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9075 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992078AbdIZPNQFIB4V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2017 17:13:16 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9EF86CE7B5FDC;
        Tue, 26 Sep 2017 16:13:04 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 26 Sep
 2017 16:13:07 +0100
To:     David Daney <david.daney@cavium.com>
CC:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Subject: =?UTF-8?Q?error:_=e2=80=98target=e2=80=99_may_be_used_uninitialized?=
 =?UTF-8?Q?_in_arch/mips/net/ebpf=5fjit.c?=
Message-ID: <31051d4e-95a1-ec81-7e9e-5cf0f3d752df@imgtec.com>
Date:   Tue, 26 Sep 2017 16:13:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi David,

I see the following compiler error when I turn on CONFIG_MIPS_EBPF_JIT 
with v4.13 and v4.14-rc1 (cavium_octeon_defconfig based)

This is with gcc:

gcc version 4.9.2 (Codescape GNU Tools 2016.05-03 for MIPS MTI Linux)


arch/mips/net/ebpf_jit.c: In function ‘build_one_insn’:
arch/mips/net/ebpf_jit.c:1119:80: error: ‘target’ may be used 
uninitialized in this function [-Werror=maybe-uninitialized]
     emit_instr(ctx, j, target);
^
cc1: all warnings being treated as errors


This appears to have been the case since the ebpf_jit was merged in 
b6bd53f9c4e825fca82fe1392157c78443c814ab.

Thanks,

Matt
