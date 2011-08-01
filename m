Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2011 15:11:52 +0200 (CEST)
Received: from mail-ey0-f178.google.com ([209.85.215.178]:56082 "EHLO
        mail-ey0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491134Ab1HANLs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Aug 2011 15:11:48 +0200
Received: by eye4 with SMTP id 4so6138430eye.9
        for <linux-mips@linux-mips.org>; Mon, 01 Aug 2011 06:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yoMvcJ4jeenBKzBULY8u5277dOmMgfeEHfzIYrK8xFU=;
        b=RoVpsucXfX3OIEOC8Oh8BQZaYpJW5Z/eAhdbOexjK+rCTrh6udyf+GZ1ghWLUdcIj3
         mfgmudgH7RoSCEquWTM/oJuORQN8NZgFupG9E33KHPsqNIZmOPPfOegGBvdoWwzqZ4lb
         f6EylM9bLSx7kJVPH9Xr3VfPl0geUMxjDPnoo=
Received: by 10.204.57.82 with SMTP id b18mr1212658bkh.95.1312204302852;
        Mon, 01 Aug 2011 06:11:42 -0700 (PDT)
Received: from localhost (ppp85-140-16-100.pppoe.mtu-net.ru [85.140.16.100])
        by mx.google.com with ESMTPS id p24sm1320068bkw.8.2011.08.01.06.11.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 06:11:41 -0700 (PDT)
Date:   Mon, 1 Aug 2011 17:11:37 +0400
From:   Vasiliy Kulikov <segoon@openwall.com>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: shm broken on MIPS in current -git
Message-ID: <20110801131137.GA10508@albatros>
References: <CAOLZvyEQNS3dwQ+6bh2o6kADp7Gd3xOpah8y1_AhqJ2FWSP9VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLZvyEQNS3dwQ+6bh2o6kADp7Gd3xOpah8y1_AhqJ2FWSP9VA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 30782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: segoon@openwall.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 406

Hi Manuel,

On Mon, Aug 01, 2011 at 14:51 +0200, Manuel Lauss wrote:
> Commits 5774ed014f02120db9a6945a1ecebeb97c2acccb
> (shm: handle separate PID namespaces case)
> and 4c677e2eefdba9c5bfc4474e2e91b26ae8458a1d
> (shm: optimize locking and ipc_namespace getting)
> break on my MIPS systems.

Can you please identify what commit breaks the system?

>  The following oops is
> printed on boot, and as a result, more than  300 zombie kworker
> kernel processes are resident.  I don't see this oops on x86 or x64.

Do you have the same configs for x86 and mips?

> ra points to the down_write() in ipc/shm.c::exit_shm()
> 
> CPU 0 Unable to handle kernel paging request at virtual address
> 00000000, epc == 80527c64, ra == 8024afb8
> Oops[#1]:
> Cpu 0
> $ 0   : 00000000 10003c00 00000000 10003c01
> $ 4   : 8060d114 8fc45e60 8060d118 8fc3f520
> $ 8   : 00000000 01312d00 0016e35f 00020000
> $12   : 00000080 00000010 00000010 8fc3001c
> $16   : 8fc3f520 00000000 00000000 00000000
> $20   : 00000000 00000000 8fc45eb4 00000000
> $24   : 00000000 8011f9b0
> $28   : 8fc44000 8fc45e50 00000001 8024afb8
> Hi    : 00000000
> Lo    : 01312d00
> epc   : 80527c64 __down_write_nested+0x68/0xf0
>     Not tainted
> ra    : 8024afb8 exit_shm+0x30/0x64
> Status: 10003c02    KERNEL EXL
> Cause : 0080800c
> BadVA : 00000000
> PrId  : 800c8000 (Au1300)
> Process kworker/u:0 (pid: 9, threadinfo=8fc44000, task=8fc3f520, tls=00000000)
> Stack : 14200972 d3054429 00000000 56b8e493 8060d118 00000000 8fc3f520 00000002
>         8fc2c000 8060d114 00000000 8024afb8 00000000 00000000 00000000 00000000
>         8060d0c0 00000000 8fc3f520 80128ae8 30480023 0b309f84 34ffeedb ef9e65d6
>         38019941 af430015 f6d9ebeb 00000000 00000000 00000000 8fc29ce0 8fc15300
>         00000000 00000000 00000000 00000000 00000000 00000000 00000000 80139578
>         ...
> Call Trace:
> [<80527c64>] __down_write_nested+0x68/0xf0
> [<8024afb8>] exit_shm+0x30/0x64
> [<80128ae8>] do_exit+0x50c/0x664
> [<80139578>] ____call_usermodehelper+0xfc/0x118
> [<801061bc>] kernel_thread_helper+0x10/0x18
> 
> 
> Code: ac850008  afa60010  afa20014 <ac450000> 40016000  30630001
> 3421001f  3821001f  00611825
> Disabling lock debugging due to kernel taint
> Fixing recursive fault but reboot is needed!
> 
> 
> Thanks,
>         Manuel Lauss

-- 
Vasiliy Kulikov
http://www.openwall.com - bringing security into open computing environments
