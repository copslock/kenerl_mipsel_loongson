Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2011 15:40:07 +0200 (CEST)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:58321 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491134Ab1HANkD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Aug 2011 15:40:03 +0200
Received: by ewy3 with SMTP id 3so3559645ewy.36
        for <linux-mips@linux-mips.org>; Mon, 01 Aug 2011 06:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6+2G++kYev0YJbutP+XLI2yVH+tF4ObL6XIyg/wBlSg=;
        b=AkzvwkzU55RNkSHw04Sr3/bcLHJBUQVURNN5F0uaeuUY6Z+BiJoY2/avOP/0Vy+oZs
         dRzzIgDdG/Zcm80Hwi99gb9qrdh+NM4XFJSf+sAQ1AAA4DHyxmTFtDl8XBGISfNVpuK0
         sty2Oy0rFc7BcJ5P/K+Fg/SadvyTFqOe3vmeU=
Received: by 10.204.134.205 with SMTP id k13mr1354608bkt.252.1312205998207;
        Mon, 01 Aug 2011 06:39:58 -0700 (PDT)
Received: from localhost (ppp85-140-16-100.pppoe.mtu-net.ru [85.140.16.100])
        by mx.google.com with ESMTPS id l1sm1150693bks.61.2011.08.01.06.39.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 06:39:57 -0700 (PDT)
Date:   Mon, 1 Aug 2011 17:39:54 +0400
From:   Vasiliy Kulikov <segoon@openwall.com>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: shm broken on MIPS in current -git
Message-ID: <20110801133954.GA11452@albatros>
References: <CAOLZvyEQNS3dwQ+6bh2o6kADp7Gd3xOpah8y1_AhqJ2FWSP9VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLZvyEQNS3dwQ+6bh2o6kADp7Gd3xOpah8y1_AhqJ2FWSP9VA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 30785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: segoon@openwall.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 433

Manuel,

On Mon, Aug 01, 2011 at 14:51 +0200, Manuel Lauss wrote:
> CPU 0 Unable to handle kernel paging request at virtual address
> 00000000, epc == 80527c64, ra == 8024afb8
> Oops[#1]:
[...]
> epc   : 80527c64 __down_write_nested+0x68/0xf0

Could you post the asm code of __down_write_nested() of your image?
What pointer is NULL?  Looks like MIPS handles namespaces in usermode
helpers other way.

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

Thanks,

-- 
Vasiliy Kulikov
http://www.openwall.com - bringing security into open computing environments
