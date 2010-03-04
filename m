Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Mar 2010 12:58:45 +0100 (CET)
Received: from mail-yx0-f179.google.com ([209.85.210.179]:33539 "EHLO
        mail-yx0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491851Ab0CDL6m convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Mar 2010 12:58:42 +0100
Received: by yxe9 with SMTP id 9so1225765yxe.22
        for <multiple recipients>; Thu, 04 Mar 2010 03:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1tRr09/lk/etBJnnzP87tj6O0jjThngLIZg2F+TntPs=;
        b=rbQiAUTRSdC7763c7f1eZbx0KqeIWtiYpPSn3QZ23oSrsxwcTSH8t/3DrXyBtFEca0
         EYoVscgQbdZFEMX8PHJH5Yc6hRGPmhwikoUUg+JWeftLqMSBV3ZuYqPRuVtOx6y2juQL
         eA3yUEuqrVl8gmnb3+ZfbEzPpE+wh8bXbz0BE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E6idz5oS3qf1TlsbSlkUE0HGoDr5gX/YwLnMm3w4HweVWX7a1g5vAYbCy1L2T3Y3cl
         /4BeNxMOI2SHL7N8Ythj/7vpzu5hVNdB7sKarjvlGnNdvY06dCN+9SSply2JQwNzx0yR
         bcScu6cRlwFHaAMOSA6DKbuIEKzVCRyICaMiw=
MIME-Version: 1.0
Received: by 10.150.166.15 with SMTP id o15mr2357347ybe.306.1267703914872; 
        Thu, 04 Mar 2010 03:58:34 -0800 (PST)
In-Reply-To: <e997b7421003030834r7bec3295s7917bb91a3fa2d27@mail.gmail.com>
References: <20100303110527.11233.20400.stgit@muvarov>
         <e997b7421003030834r7bec3295s7917bb91a3fa2d27@mail.gmail.com>
Date:   Thu, 4 Mar 2010 14:58:34 +0300
Message-ID: <572af9171003040358n25bc2462yc8c16a9acdac70db@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS kexec,kdump support
From:   Maxim Uvarov <muvarov@gmail.com>
To:     "wilbur.chan" <wilbur512@gmail.com>
Cc:     linux-mips@linux-mips.org, kexec@lists.infradead.org,
        horms@verge.net.au, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <muvarov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: muvarov@gmail.com
Precedence: bulk
X-list: linux-mips

2010/3/3 wilbur.chan <wilbur512@gmail.com>:
> 2010/3/3 Maxim Uvarov <muvarov@gmail.com>:
>> Hello folks,
>>
>> Please find here MIPS crash and kdump patches.
>> This is patch set of 3 patches:
>> 1. generic MIPS changes (kernel);
>> 2. MIPS Cavium Octeon board kexec/kdump code (kernel);
>> 3. Kexec user space MIPS changes.
>>
>> Patches were tested on the latest linux-mips@ git kernel and the latest
>> kexec-tools git on Cavium Octeon 50xx board.
>>
>> I also made the same code working on RMI XLR/XLS boards for both
>> mips32 and mips64 kernels.
>>
>> Best regards,
>> Maxim Uvarov.
>>
>
>> Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
>>
>>
>>
>
> Hi, Maxim
>
> In XLR series ,
>
> 1)How to protect  boardinfo and pass it to second kernel ?
>
It is very simple. I just looked at physical addresses  where
boardinfo is and protect this
region.  For xls simple add additional exclude region to setup.c
static struct boot_mem_map_exclude_region static_exclude_regions[] = {
+	[1] = {0xc000000, 0xd000000 }, /*Bootloader stuctures*/

To pass it to second kernel copy pointer to original psb_info to
static variable in beginning of prom_init() and provide this pointer
as kexec_args[3].

kexec_args[0]  is argc on XLS
kexec_args[1] is argv on XLS

> 2)If all cpus jumped to same entry point , did you change head.s, if so , how ?
>
Please take a look how other platforms do this. You need write .macro
kernel_entry_setup which should be located in somewhere is
include/asm-mips/mach-rmi. Then you write this macro it will be
executed before kernel_entry. So after kexec all cpus jump to this
entry point and after they you can do all things what you want:
- make cpu0 boot new kernel and other cpus go to boot slaves procedure;
- take first cpu and make it boot, and all others go to boot slaves procedure;
- boot only cpu0 and infinite loop others  cpus (you might want to do
this for kdump)
>
>
> Thank you!
>

-- 
Best regards,
Maxim Uvarov
