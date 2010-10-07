Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Oct 2010 10:12:18 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:57565 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490970Ab0JGIMP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Oct 2010 10:12:15 +0200
Received: by qwe4 with SMTP id 4so296qwe.36
        for <linux-mips@linux-mips.org>; Thu, 07 Oct 2010 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=P6W1oK8vTs/uhz/AwUXJyYdTnf3jwsaQQ+z0+MjM1LA=;
        b=fU0Uj66IqW3NRR5D6ytCslto/ZcO6ahb7Zt4Af0BLArgvTuFoetT3fP2uk0/Dq9r1/
         j/z/3l/emMyvcHTTscWH4MssDb0jqLb+yHh2L0ZD58GPj5cfD9jy+/m6Mw8WbEd61/5X
         l+AnL/4uSdJJRhKgqQR9zmMxCwGL38BlBc61o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=jwJd9ORga9bh72MP+7tt1V9D00/+mGNWINc8sSvTQi7Xmn9WPsFhU+n90G9dtKLpjX
         UC7Ht5DTsG0hN66YW5A089PMrm0izs/d6AB58dNAXhb+DLdIpzjtTx0hAySHtsk3dWxm
         LkH8xM87FeWiF83vhWreMYvCDWg6GCJ907H3U=
MIME-Version: 1.0
Received: by 10.229.215.8 with SMTP id hc8mr472167qcb.23.1286439129513; Thu,
 07 Oct 2010 01:12:09 -0700 (PDT)
Received: by 10.229.221.146 with HTTP; Thu, 7 Oct 2010 01:12:09 -0700 (PDT)
Date:   Thu, 7 Oct 2010 16:12:09 +0800
Message-ID: <AANLkTikjZc029TOmzsaPKg7UqzRktMB7JFN44D1MwrAA@mail.gmail.com>
Subject: ebase changed, leads to invalid access of data
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all!

Recently I ' m trying to initialize my own exception handler on linux
for non-zero

CPUs on mips64 xls416, which has 16 cores.


What I am doing now is to boot CPU 0 with smp linux 2.6.21.7, and wakeup other


CPUs into my_secondary  instead of  start_secondary(arch/mips/kernel/smp.c).

That is ,  CPU 0 will run  linux idle process, and wake other cpus into

my_secondary.



In my_secondary function, each non-zero cpu is asked to setup kuseg tlb

mapping   for later use , then setup its own exception

handler at  physical address cpuid*0x400, after that , ebase is set
according to the

offset.


The code is somewhat like this:


void my_secondary function()
{
   int cpu =  processor_id();

   /*tlb mapping , virt start =0x600000 , phy start =0x1000000+cpuid*0x40000, */

  /*size =0x40000*/

  /* These physical mapping address are reserved when booting CPU 0*/

   setup_kuseg_tlb(0x600000, 0x1000000+cpu*0x40000, 0x40000);

    ebase = (unsigned long)(0x80000000+cpuid*0x400);

   /*exception  handler  install*/
   memcpy((void *)(ebase + 0x180), test_except_vec_genex, 0x80);

   *(unsigned long*)0x620000 = 0x1234; /*access OK*/

   write_ebase(ebase);

   *(unsigned long*)0x620000 = 0x1234; /*access failed*/
}


As mentioned above, if the kuseg access code is put before the change of

ebase,the access of addess 0x62000 would be OK. However after the modify of

ebase, an exception would be generated if access 0x620000.



I don't know why changing ebase leads to an invalid access of kuseg section,

any suggestions? Thank you in advance.
