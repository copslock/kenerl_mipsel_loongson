Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2011 11:54:22 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:58687 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491076Ab1C3JyT convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Mar 2011 11:54:19 +0200
Received: by qyk32 with SMTP id 32so2718199qyk.15
        for <linux-mips@linux-mips.org>; Wed, 30 Mar 2011 02:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yIUuMCk12RQm5BaLWka8lHV4qbsDCtJPFnowpQ9mKoc=;
        b=t6eJT+Dw75aby2u0G8w3o+3e2gFZy6e8d9FqrKq91Hjc4JHQUWko2It8GuS7CKr3Us
         EcmrslMBD1cHEAVCDkZIl+uFq+I8H0TrCe2fjYLambTZvel8QtFcMdctFUwV3SvqAQDa
         UryqqMoNZcn+31RD0lWG0pbFa2D+4CR0pAdl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DT1bQwFf6jIo0cBqoCA+k0ShfhtzV/hM+fAGFZ/t8N7QbqHfeGkY9k6EIUXXaait60
         01JXdQLw9kwX6guGAPua/D4luHK+4cTgq1AU7wsQQ5PBnd8U2ftDIQKxhCO9dal9mS7b
         LNeWIXPnbDda4Vr8KdwAmE+fyay3ySOYwE5bY=
MIME-Version: 1.0
Received: by 10.224.28.133 with SMTP id m5mr761412qac.281.1301478851383; Wed,
 30 Mar 2011 02:54:11 -0700 (PDT)
Received: by 10.224.2.146 with HTTP; Wed, 30 Mar 2011 02:54:11 -0700 (PDT)
In-Reply-To: <1301476505.29074.47.camel@e102109-lin.cambridge.arm.com>
References: <9bde694e1003020554p7c8ff3c2o4ae7cb5d501d1ab9@mail.gmail.com>
        <AANLkTinnqtXf5DE+qxkTyZ9p9Mb8dXai6UxWP2HaHY3D@mail.gmail.com>
        <1300960540.32158.13.camel@e102109-lin.cambridge.arm.com>
        <AANLkTim139fpJsMJFLiyUYvFgGMz-Ljgd_yDrks-tqhE@mail.gmail.com>
        <1301395206.583.53.camel@e102109-lin.cambridge.arm.com>
        <AANLkTim-4v5Cbp6+wHoXjgKXoS0axk1cgQ5AHF_zot80@mail.gmail.com>
        <1301399454.583.66.camel@e102109-lin.cambridge.arm.com>
        <AANLkTin0_gT0E3=oGyfMwk+1quqonYBExeN9a3=v=Lob@mail.gmail.com>
        <AANLkTi=gMP6jQuQFovfsOX=7p-SSnwXoVLO_DVEpV63h@mail.gmail.com>
        <1301476505.29074.47.camel@e102109-lin.cambridge.arm.com>
Date:   Wed, 30 Mar 2011 12:54:11 +0300
Message-ID: <AANLkTi=YB+nBG7BYuuU+rB9TC-BbWcJ6mVfkxq0iUype@mail.gmail.com>
Subject: Re: kmemleak for MIPS
From:   Daniel Baluta <daniel.baluta@gmail.com>
To:     Maxin John <maxin.john@gmail.com>
Cc:     naveen yadav <yad.naveen@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <daniel.baluta@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.baluta@gmail.com
Precedence: bulk
X-list: linux-mips

>> unreferenced object 0x8f90d000 (size 4096):
>>   comm "swapper", pid 1, jiffies 4294937330 (age 815.000s)
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<80529644>] alloc_large_system_hash+0x2f8/0x410
>>     [<805383b4>] udp_table_init+0x4c/0x158
>>     [<805384dc>] udp_init+0x1c/0x94
>>     [<8053889c>] inet_init+0x184/0x2a0
>>     [<80100584>] do_one_initcall+0x174/0x1e0
>>     [<8051f348>] kernel_init+0xe4/0x174
>>     [<80103d4c>] kernel_thread_helper+0x10/0x18
>
> If you for the kmemleak scan (via echo) a few times, do you get more
> leaks? The udp_table_init() function looks like it could leak some
> memory but I haven't seen it before. I'm not sure whether this is a
> false positive or a real leak.

Looking again at udp_init_table it seem that a memory leak is possible.
Could you post your .config and the full output of dmesg after booting.

A situation where CONFIG_BASE_SMALL is 0, and
table->mask < UDP_HTABLE_SIZE_MIN - 1 would lead
to a memory leak.

Furthermore, you can add some printks inside udp_init_table
and check what is really happening there. ([1])

thanks,
Daniel.

[1] http://lxr.linux.no/linux+v2.6.38/net/ipv4/udp.c#L2125

thanks,
Daniel.
