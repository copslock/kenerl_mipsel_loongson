Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 02:46:04 +0200 (CEST)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:48306 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006944AbaH1AqDAIAbw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Aug 2014 02:46:03 +0200
Received: by mail-lb0-f172.google.com with SMTP id 10so69456lbg.3
        for <linux-mips@linux-mips.org>; Wed, 27 Aug 2014 17:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=NiYxtNvj8XtUbJgK/3eERTZwfEAu+aBrL/2kD9ifkLM=;
        b=K2Pq2kQ+5VmZFgMRgw8DYytOiSMl7wemsUEMECkja4qItsJaxvavCGOz5VdEqSADgN
         dqe5ReCRjIPHDl88JlffiYi7TjM5ONQJB3gdoqDdHDOcnjfA4OQm87mISXFkhtrTFpFc
         oTZfm6yf7/X+u78WWFZQ3BpzHC8PwqldIRh61Pp0IhJaw/lZKlWZ99XvQVYh1Vei+YDC
         +QAgA9za8vOQ4lZrPvQe1SpO8UaJdowit6mO6LTFkJKIb0/cgwDSj8QhSEJhJw91Tv4a
         UfngG5uV6K6X9xW9xO2VRv9xpYf/jwu8qlLVPbIhIgxp/LagVHO+yT6uCAggs+TADNpE
         eYCA==
MIME-Version: 1.0
X-Received: by 10.112.149.72 with SMTP id ty8mr472420lbb.15.1409186757340;
 Wed, 27 Aug 2014 17:45:57 -0700 (PDT)
Received: by 10.152.3.167 with HTTP; Wed, 27 Aug 2014 17:45:57 -0700 (PDT)
Date:   Wed, 27 Aug 2014 17:45:57 -0700
Message-ID: <CAF1ivSYeUL_UgS3Pn8Uif10wf4ibCh4aeS9NHMKo=S3wQtfduQ@mail.gmail.com>
Subject: epc register reported zero
From:   Lin Ming <minggr@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <minggr@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minggr@gmail.com
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

Hi list,

Board: Broadcom 963268
CPU model: Broadcom BMIPS4350 V8.0
Kernel: 2.6.30
Toolchain: uclibc-crosstools-gcc-4.4.2-1

I encountered an userspace application crash with epc reported zero.
I don't understand how epc register could be zero.

Any help is appreciated.

wps_monitor/1699: potentially unexpected fatal signal 11.

Cpu 1
$ 0   : 00000000 10008d00 00000004 0000000a
$ 4   : 0000000a 7f88a55c 00000000 00000001
$ 8   : 00000000 00000000 00000001 00000000
$12   : 00000001 00000000 00000008 12182430
$16   : 00438968 00000001 00409620 00000000
$20   : 00000000 00000000 00000000 00406404
$24   : 00000002 2aaecc00
$28   : 2ab39a70 7f88a4c0 7f88a4f0 0041a838
Hi    : 00000000
Lo    : 00000000
epc   : 00000000 (null)
    Tainted: P
ra    : 0041a838 0x41a838
Status: 00008d13    USER EXL IE
Cause : 00000008
BadVA : 00000000
PrId  : 0002a080 (Broadcom4350)

mips-linux-addr2line -e wps_monitor 0041a838
This shows "ra" address mapped to below line 328.

322         if (max_fd == -1) {
323                 TUTRACE((TUTRACE_ERR, "wpsm_readData: no fd set!\n"));
324                 return NULL;
325         }
326
327         /* Do select */
328         n = select(max_fd + 1, &fdvar, NULL, NULL, &timeout);
329         if (n <= 0) {
330                 /*
331                  * to avoid the select operation interferenced by
led lighting timer.
332                  * this will be removed after led lighting timer
is replaced by wireless driver
333                  */
334                 if (n < 0 && errno != EINTR) {
335                         TUTRACE((TUTRACE_ERR, "wpsm_readData:
select recv failed\n"));
336                 }
337                 goto out;
338         }


0000eac0 <__libc_select>:
    eac0:       3c1c0006        lui     gp,0x6
    eac4:       279c1aa0        addiu   gp,gp,6816
    eac8:       0399e021        addu    gp,gp,t9
    eacc:       27bdffd8        addiu   sp,sp,-40
    ead0:       afbe0020        sw      s8,32(sp)
    ead4:       03a0f021        move    s8,sp
    ead8:       afbf0024        sw      ra,36(sp)
    eadc:       afb0001c        sw      s0,28(sp)
    eae0:       afbc0010        sw      gp,16(sp)
    eae4:       27bdfff0        addiu   sp,sp,-16
    eae8:       8fc20038        lw      v0,56(s8)
    eaec:       27bdffe0        addiu   sp,sp,-32
    eaf0:       afa20010        sw      v0,16(sp)
    eaf4:       2402102e        li      v0,4142
    eaf8:       0000000c        syscall
    eafc:       27bd0020        addiu   sp,sp,32
    eb00:       10e00006        beqz    a3,eb1c <__libc_select+0x5c>
    eb04:       00408021        move    s0,v0
    eb08:       8f9988d0        lw      t9,-30512(gp)
    eb0c:       0320f809        jalr    t9
    eb10:       00000000        nop
    eb14:       ac500000        sw      s0,0(v0)
    eb18:       2402ffff        li      v0,-1
    eb1c:       03c0e821        move    sp,s8
    eb20:       8fbf0024        lw      ra,36(sp)
    eb24:       8fbe0020        lw      s8,32(sp)
    eb28:       8fb0001c        lw      s0,28(sp)
    eb2c:       03e00008        jr      ra
    eb30:       27bd0028        addiu   sp,sp,40

Regards,
Ming
