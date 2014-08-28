Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 03:33:26 +0200 (CEST)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:56626 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006944AbaH1BdYMol8t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Aug 2014 03:33:24 +0200
Received: by mail-lb0-f171.google.com with SMTP id n15so101730lbi.30
        for <linux-mips@linux-mips.org>; Wed, 27 Aug 2014 18:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UM24ZTiZ9NhylxRmKODzqp/Brt2n//o3i7wio44H0rg=;
        b=mAVww/moxSBhkSI3P5J2LHSMHwnEzCPUL42l8l/nVjZpJFZXzyyLCCFOpOLFHjx2qQ
         Pc/QHqHtOMwZfLKWbdjiO/F//aQ1lVo7JrWy+qxisW2jCPM3L6Cdpo7D/9v1Y7O9vk5H
         BrcRe6bm/MNWZZnYHnZyUkkk9GhwTpEC1cmuufMYHY4FHYXt4fhyqgTXMRlI9VPPQw9w
         IHc3ypDXR/PSYcFLvdwHUq6AkO8w1PbOGPO2aS8yeKJG0SL6CSqdYFSo+fe3zCdE1x+t
         qhFSChpO/AzvwJ9KQzJ/F6y4FNoqF1Qr00CvkQonFoSVSpRv5YxNYbHNFJBFBlFnRGmf
         dCdQ==
MIME-Version: 1.0
X-Received: by 10.112.105.168 with SMTP id gn8mr557855lbb.77.1409189598600;
 Wed, 27 Aug 2014 18:33:18 -0700 (PDT)
Received: by 10.152.3.167 with HTTP; Wed, 27 Aug 2014 18:33:18 -0700 (PDT)
In-Reply-To: <53FE82CE.1090707@gmail.com>
References: <CAF1ivSYeUL_UgS3Pn8Uif10wf4ibCh4aeS9NHMKo=S3wQtfduQ@mail.gmail.com>
        <53FE82CE.1090707@gmail.com>
Date:   Wed, 27 Aug 2014 18:33:18 -0700
Message-ID: <CAF1ivSa0oH+4vhjX-6mYP7UCAFkh=xXcnVZCW0iBBg8gRGfNTg@mail.gmail.com>
Subject: Re: epc register reported zero
From:   Lin Ming <minggr@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <minggr@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42291
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

On Wed, Aug 27, 2014 at 6:15 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 08/27/2014 05:45 PM, Lin Ming wrote:
>>
>> Hi list,
>>
>> Board: Broadcom 963268
>> CPU model: Broadcom BMIPS4350 V8.0
>> Kernel: 2.6.30
>> Toolchain: uclibc-crosstools-gcc-4.4.2-1
>>
>> I encountered an userspace application crash with epc reported zero.
>> I don't understand how epc register could be zero.
>>
>> Any help is appreciated.
>>
>> wps_monitor/1699: potentially unexpected fatal signal 11.
>>
>> Cpu 1
>> $ 0   : 00000000 10008d00 00000004 0000000a
>> $ 4   : 0000000a 7f88a55c 00000000 00000001
>> $ 8   : 00000000 00000000 00000001 00000000
>> $12   : 00000001 00000000 00000008 12182430
>> $16   : 00438968 00000001 00409620 00000000
>> $20   : 00000000 00000000 00000000 00406404
>> $24   : 00000002 2aaecc00
>> $28   : 2ab39a70 7f88a4c0 7f88a4f0 0041a838
>
>
> Disassemble the surrounding the address in $31
>
> I am guessing that at 0x41a830, you have an indirect jump (JR instruction)
> and that 'rs' contains a value of zero.  So the EPC when you get the SIGSEGV
> will be ... zero.
>
> This is called a call through a NULL function pointer.

Here it is.
There is only a "jalr t9", which I think it's call of __libc_select().

        /* Do select */
        n = select(max_fd + 1, &fdvar, NULL, NULL, &timeout);
  41a804:       8fc20034        lw      v0,52(s8)
  41a808:       24430001        addiu   v1,v0,1
  41a80c:       27c20044        addiu   v0,s8,68
  41a810:       27c400c4        addiu   a0,s8,196
  41a814:       afa40010        sw      a0,16(sp)
  41a818:       00602021        move    a0,v1
  41a81c:       00402821        move    a1,v0
  41a820:       00003021        move    a2,zero
  41a824:       00003821        move    a3,zero
  41a828:       8f82843c        lw      v0,-31684(gp)
  41a82c:       0040c821        move    t9,v0
  41a830:       0320f809        jalr    t9
  41a834:       00000000        nop
  41a838:       8fdc0018        lw      gp,24(s8)
  41a83c:       afc20038        sw      v0,56(s8)
        if (n <= 0) {
  41a840:       8fc20038        lw      v0,56(s8)
  41a844:       1c40000b        bgtz    v0,41a874
<wps_osl_wait_for_all_packets+0x21c>
  41a848:       00000000        nop

Here is my crazy thought:

One possibility is:
1. select() syscall entered kernel mode. Then epc register was saved
on kernel mode stack.
2. After select() syscall finished, kernel code read epc value from
stack and restore it to epc register.
3. CPU jump to the instruction pointed by epc register.

Maybe there's some bug in kernel that destroyed kernel mode stack. So
epc register value became zero.

I added below crazy code to simulate it.

diff --git a/bcmcpe2/kernel/linux-3.4rt/fs/select.c
b/bcmcpe2/kernel/linux-3.4rt/fs/select.c
index 0baa0a3..cd41c4d 100644
--- a/bcmcpe2/kernel/linux-3.4rt/fs/select.c
+++ b/bcmcpe2/kernel/linux-3.4rt/fs/select.c
@@ -597,6 +597,11 @@ SYSCALL_DEFINE5(select, int, n, fd_set __user *,
inp, fd_set __user *, outp,
        struct timeval tv;
        int ret;

+       if (!strcmp(current->comm, "wps_monitor")) {
+               printk("LINMING: hack wps_monitor epc\n");
+               task_pt_regs(current)->cp0_epc = 0;
+       }
+

And got below:

wps_monitor/1315: potentially unexpected fatal signal 11.

Cpu 1
$ 0   : 00000000 10008d00 00000000 0000f9d8
$ 4   : 00000008 7f7fe624 00000000 00000000
$ 8   : 00000000 7f7fe5f8 00000000 87c78000
$12   : 00504303 00000043 0000000e 0000dd18
$16   : 00000000 0043db30 0043bff8 0043bffc
$20   : 7f7fe624 7f7fe5f0 00000007 00000000
$24   : 00000000 77c59960
$28   : 77cc94d0 7f7fe578 7f7fe5a8 004090a8
Hi    : 00000000
Lo    : 00000000
epc   : 00000000   (null)
    Tainted: P
ra    : 004090a8 0x4090a8
Status: 00008d13    USER EXL IE
Cause : 00000008
BadVA : 00000000
PrId  : 0002a080 (Broadcom BMIPS4350)
