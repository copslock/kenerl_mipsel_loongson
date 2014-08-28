Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 03:16:06 +0200 (CEST)
Received: from mail-ig0-f174.google.com ([209.85.213.174]:62989 "EHLO
        mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006944AbaH1BQFnNPj5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Aug 2014 03:16:05 +0200
Received: by mail-ig0-f174.google.com with SMTP id c1so7263089igq.1
        for <linux-mips@linux-mips.org>; Wed, 27 Aug 2014 18:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Qcbs1YDZrzpJylcm9mfX3b4eLbDIhK4m35H6lcftUqg=;
        b=ewVzDQqhSLS5a+CejPH2G1a3FCm0nMSbBfSs347xmoJXvhom912xNzZUQt23ak2K0j
         qwazQ1RrMt+U2C5CBhupx4ju1KEGSQfBBKd3DSSObyT7KosCPDEPuufvXFYuUPsWvBTy
         /JiC1C1mbZJTKbODNNJk6KFwtvSL0BYhxAP9OwY7UbOJrMqhSiISnSqhAvb6Wn5BlYPs
         jH2PouHyugS04NhBFFFz+43vyxxrIXej9iERJWFJcVZfbPZTn3j85cYZ+vmfRH3DVGG/
         9G77CrWwwaACWdTa31BhkJAMUh90YIJvTkuEIESa49whsEOufQjlC0J9ycuFR3Mt/TPS
         W14A==
X-Received: by 10.43.154.145 with SMTP id le17mr1635069icc.20.1409188559723;
        Wed, 27 Aug 2014 18:15:59 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ky8sm9785377igb.16.2014.08.27.18.15.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 27 Aug 2014 18:15:59 -0700 (PDT)
Message-ID: <53FE82CE.1090707@gmail.com>
Date:   Wed, 27 Aug 2014 18:15:58 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Lin Ming <minggr@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: epc register reported zero
References: <CAF1ivSYeUL_UgS3Pn8Uif10wf4ibCh4aeS9NHMKo=S3wQtfduQ@mail.gmail.com>
In-Reply-To: <CAF1ivSYeUL_UgS3Pn8Uif10wf4ibCh4aeS9NHMKo=S3wQtfduQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 08/27/2014 05:45 PM, Lin Ming wrote:
> Hi list,
>
> Board: Broadcom 963268
> CPU model: Broadcom BMIPS4350 V8.0
> Kernel: 2.6.30
> Toolchain: uclibc-crosstools-gcc-4.4.2-1
>
> I encountered an userspace application crash with epc reported zero.
> I don't understand how epc register could be zero.
>
> Any help is appreciated.
>
> wps_monitor/1699: potentially unexpected fatal signal 11.
>
> Cpu 1
> $ 0   : 00000000 10008d00 00000004 0000000a
> $ 4   : 0000000a 7f88a55c 00000000 00000001
> $ 8   : 00000000 00000000 00000001 00000000
> $12   : 00000001 00000000 00000008 12182430
> $16   : 00438968 00000001 00409620 00000000
> $20   : 00000000 00000000 00000000 00406404
> $24   : 00000002 2aaecc00
> $28   : 2ab39a70 7f88a4c0 7f88a4f0 0041a838

Disassemble the surrounding the address in $31

I am guessing that at 0x41a830, you have an indirect jump (JR 
instruction) and that 'rs' contains a value of zero.  So the EPC when 
you get the SIGSEGV will be ... zero.

This is called a call through a NULL function pointer.


> Hi    : 00000000
> Lo    : 00000000
> epc   : 00000000 (null)
>      Tainted: P
> ra    : 0041a838 0x41a838
> Status: 00008d13    USER EXL IE
> Cause : 00000008
> BadVA : 00000000
> PrId  : 0002a080 (Broadcom4350)
>
> mips-linux-addr2line -e wps_monitor 0041a838
> This shows "ra" address mapped to below line 328.
>
> 322         if (max_fd == -1) {
> 323                 TUTRACE((TUTRACE_ERR, "wpsm_readData: no fd set!\n"));
> 324                 return NULL;
> 325         }
> 326
> 327         /* Do select */
> 328         n = select(max_fd + 1, &fdvar, NULL, NULL, &timeout);
> 329         if (n <= 0) {
> 330                 /*
> 331                  * to avoid the select operation interferenced by
> led lighting timer.
> 332                  * this will be removed after led lighting timer
> is replaced by wireless driver
> 333                  */
> 334                 if (n < 0 && errno != EINTR) {
> 335                         TUTRACE((TUTRACE_ERR, "wpsm_readData:
> select recv failed\n"));
> 336                 }
> 337                 goto out;
> 338         }
>
>
> 0000eac0 <__libc_select>:
>      eac0:       3c1c0006        lui     gp,0x6
>      eac4:       279c1aa0        addiu   gp,gp,6816
>      eac8:       0399e021        addu    gp,gp,t9
>      eacc:       27bdffd8        addiu   sp,sp,-40
>      ead0:       afbe0020        sw      s8,32(sp)
>      ead4:       03a0f021        move    s8,sp
>      ead8:       afbf0024        sw      ra,36(sp)
>      eadc:       afb0001c        sw      s0,28(sp)
>      eae0:       afbc0010        sw      gp,16(sp)
>      eae4:       27bdfff0        addiu   sp,sp,-16
>      eae8:       8fc20038        lw      v0,56(s8)
>      eaec:       27bdffe0        addiu   sp,sp,-32
>      eaf0:       afa20010        sw      v0,16(sp)
>      eaf4:       2402102e        li      v0,4142
>      eaf8:       0000000c        syscall
>      eafc:       27bd0020        addiu   sp,sp,32
>      eb00:       10e00006        beqz    a3,eb1c <__libc_select+0x5c>
>      eb04:       00408021        move    s0,v0
>      eb08:       8f9988d0        lw      t9,-30512(gp)
>      eb0c:       0320f809        jalr    t9
>      eb10:       00000000        nop
>      eb14:       ac500000        sw      s0,0(v0)
>      eb18:       2402ffff        li      v0,-1
>      eb1c:       03c0e821        move    sp,s8
>      eb20:       8fbf0024        lw      ra,36(sp)
>      eb24:       8fbe0020        lw      s8,32(sp)
>      eb28:       8fb0001c        lw      s0,28(sp)
>      eb2c:       03e00008        jr      ra
>      eb30:       27bd0028        addiu   sp,sp,40
>
> Regards,
> Ming
>
>
>
