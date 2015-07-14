Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 20:05:05 +0200 (CEST)
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34274 "EHLO
        mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009181AbbGNSFEVQ8ic (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 20:05:04 +0200
Received: by igvi1 with SMTP id i1so60081109igv.1
        for <linux-mips@linux-mips.org>; Tue, 14 Jul 2015 11:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=cSJxr6kotqhio+SasK9ZODMMlv7gf3u4MM0OF1Y2tDM=;
        b=SiZhTaSkeztbatHWdQ7hHewVd+X+RZOmkAqOaH+3yPnO+e/A3natcxQW/V4xslBEiI
         wiiI5Tey0s5vqf47+b2sPvXJvdfKEBS41/1XlH0QfHaM9esDfSC8/N8eQpOUVoxMbrqs
         iLlPA4lMejocD909hbR9hqQlw/r3NikRWkmpL3OLix5143PGS5LPNxZrQcTxXB3GhWoL
         aKTWtaGQZJxEgb72ucnzwR2ySn6aIMNTz37dSoOXSS0glaIvDtP0VFp6tgZimelzxdSd
         XAkQ/M3XFHS0i5gvCj+ehjLf7GcCLwe7k5+pxbYTr35qRtMfrrxWUnef9lDnC24//8n2
         oFwg==
MIME-Version: 1.0
X-Received: by 10.107.152.146 with SMTP id a140mr53361643ioe.72.1436897098835;
 Tue, 14 Jul 2015 11:04:58 -0700 (PDT)
Received: by 10.36.110.138 with HTTP; Tue, 14 Jul 2015 11:04:58 -0700 (PDT)
Date:   Tue, 14 Jul 2015 12:04:58 -0600
Message-ID: <CAAA5faEN3MmWACoT2g2+9aOj1C=vj7UcNxd3Lez_K4_sCS8jBQ@mail.gmail.com>
Subject: compile failure linux 3.10 with gcc 4.9.3 for mips
From:   Reinoud Koornstra <reinoudkoornstra@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <reinoudkoornstra@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: reinoudkoornstra@gmail.com
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

Hi Everyone,

Did anybody enounter the following compiler problem with linux 3.10.81?
gcc version is 4.9.3 for mips and binutils 2.25

arch/mips/kernel/r4k_fpu.S: Assembler messages:
arch/mips/kernel/r4k_fpu.S:59: Error: opcode not supported on this
processor: mips3 (mips3) `sdc1 $f0,272+0($4)'
arch/mips/kernel/r4k_fpu.S:60: Error: opcode not supported on this
processor: mips3 (mips3) `sdc1 $f2,272+16($4)'
arch/mips/kernel/r4k_fpu.S:61: Error: opcode not supported on this
processor: mips3 (mips3) `sdc1 $f4,272+32($4)'
arch/mips/kernel/r4k_fpu.S:62: Error: opcode not supported on this
processor: mips3 (mips3) `sdc1 $f6,272+48($4)'
arch/mips/kernel/r4k_fpu.S:63: Error: opcode not supported on this
processor: mips3 (mips3) `sdc1 $f8,272+64($4)'
arch/mips/kernel/r4k_fpu.S:64: Error: opcode not supported on this
processor: mips3 (mips3) `sdc1 $f10,272+80($4)'
arch/mips/kernel/r4k_fpu.S:65: Error: opcode not supported on this
processor: mips3 (mips3) `sdc1 $f12,272+96($4)'
arch/mips/kernel/r4k_fpu.S:66: Error: opcode not supported on this
processor: mips3 (mips3) `sdc1 $f14,272+112($4)'
arch/mips/kernel/r4k_fpu.S:67: Error: opcode not supported on this
processor: mips3 (mips3) `sdc1 $f16,272+128($4)'
arch/mips/kernel/r4k_fpu.S:68: Error: opcode not supported on this
processor: mips3 (mips3) `sdc1 $f18,272+144($4)'
arch/mips/kernel/r4k_fpu.S:69: Error: opcode not supported on this
processor: mips3 (mips3) `sdc1 $f20,272+160($4)'
arch/mips/kernel/r4k_fpu.S:70: Error: opcode not supported on this
processor: mips3 (mips3) `sdc1 $f22,272+176($4)'
arch/mips/kernel/r4k_fpu.S:71: Error: opcode not supported on this
processor: mips3 (mips3) `sdc1 $f24,272+192($4)'
arch/mips/kernel/r4k_fpu.S:72: Error: opcode not supported on this
processor: mips3 (mips3) `sdc1 $f26,272+208($4)'
arch/mips/kernel/r4k_fpu.S:73: Error: opcode not supported on this
processor: mips3 (mips3) `sdc1 $f28,272+224($4)'
arch/mips/kernel/r4k_fpu.S:74: Error: opcode not supported on this
processor: mips3 (mips3) `sdc1 $f30,272+240($4)'
arch/mips/kernel/r4k_fpu.S:135: Error: opcode not supported on this
processor: mips3 (mips3) `ldc1 $f0,272+0($4)'
arch/mips/kernel/r4k_fpu.S:136: Error: opcode not supported on this
processor: mips3 (mips3) `ldc1 $f2,272+16($4)'
arch/mips/kernel/r4k_fpu.S:137: Error: opcode not supported on this
processor: mips3 (mips3) `ldc1 $f4,272+32($4)'
arch/mips/kernel/r4k_fpu.S:138: Error: opcode not supported on this
processor: mips3 (mips3) `ldc1 $f6,272+48($4)'
arch/mips/kernel/r4k_fpu.S:139: Error: opcode not supported on this
processor: mips3 (mips3) `ldc1 $f8,272+64($4)'
arch/mips/kernel/r4k_fpu.S:140: Error: opcode not supported on this
processor: mips3 (mips3) `ldc1 $f10,272+80($4)'
arch/mips/kernel/r4k_fpu.S:141: Error: opcode not supported on this
processor: mips3 (mips3) `ldc1 $f12,272+96($4)'
arch/mips/kernel/r4k_fpu.S:142: Error: opcode not supported on this
processor: mips3 (mips3) `ldc1 $f14,272+112($4)'
arch/mips/kernel/r4k_fpu.S:143: Error: opcode not supported on this
processor: mips3 (mips3) `ldc1 $f16,272+128($4)'
arch/mips/kernel/r4k_fpu.S:144: Error: opcode not supported on this
processor: mips3 (mips3) `ldc1 $f18,272+144($4)'
arch/mips/kernel/r4k_fpu.S:145: Error: opcode not supported on this
processor: mips3 (mips3) `ldc1 $f20,272+160($4)'
arch/mips/kernel/r4k_fpu.S:146: Error: opcode not supported on this
processor: mips3 (mips3) `ldc1 $f22,272+176($4)'
arch/mips/kernel/r4k_fpu.S:147: Error: opcode not supported on this
processor: mips3 (mips3) `ldc1 $f24,272+192($4)'
arch/mips/kernel/r4k_fpu.S:148: Error: opcode not supported on this
processor: mips3 (mips3) `ldc1 $f26,272+208($4)'
arch/mips/kernel/r4k_fpu.S:149: Error: opcode not supported on this
processor: mips3 (mips3) `ldc1 $f28,272+224($4)'
arch/mips/kernel/r4k_fpu.S:150: Error: opcode not supported on this
processor: mips3 (mips3) `ldc1 $f30,272+240($4)'

Thanks,

Reinoud.
