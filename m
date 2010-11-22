Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2010 12:42:12 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:48751 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491958Ab0KVLmJ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Nov 2010 12:42:09 +0100
Received: by wyf22 with SMTP id 22so7063520wyf.36
        for <linux-mips@linux-mips.org>; Mon, 22 Nov 2010 03:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BfOXwt7hHTThjkDxr8aOOQ/lIpYGmZbqDsQInOHIYL8=;
        b=dx0mRfc3/ckQLOUrERBh0sYfkjT0SX6PdhLEcxCQ3yRGSv+VC+sGkgtFbNSIhndoPk
         oFTXvx/kEmhB5Jj/vWXu/AjxqNt6x0OSo1nieEGRtamCXYLEgm3tTroSH6yn6x22yD/R
         zAnbTZUZ9u0B7Rk+bWgGrjrb/a2z8ul+pW5+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=i9uGoP+D4WmteRP8BdkAO+QQbZHrOHwV1u5XS2VJSvdcDXqDS2Yx7rhOVgTC0+j6I0
         7IROGSvpYjMEjITp+11LSBsvgcvGHlil+KISRh2KDDrSgltiFQF+j/PP8M8IYukeyT1b
         ugZ96keJL9ewYx4GzD8GAnbA6LKz1mKcQhyoM=
MIME-Version: 1.0
Received: by 10.216.142.131 with SMTP id i3mr3956048wej.5.1290426122883; Mon,
 22 Nov 2010 03:42:02 -0800 (PST)
Received: by 10.216.131.88 with HTTP; Mon, 22 Nov 2010 03:42:02 -0800 (PST)
In-Reply-To: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>
References: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>
Date:   Mon, 22 Nov 2010 19:42:02 +0800
Message-ID: <AANLkTim-+1csKoCc7kqXERmLZRSt9LAAB=JPK+0gaYPo@mail.gmail.com>
Subject: Re: Build failure triggered by recordmcount
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Arnaud Lacombe <lacombar@gmail.com>
Cc:     John Reiser <jreiseer@bitwagon.com>,
        Steven Rostedt <srosteedt@redhat.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Arnaud

This only happen at 32bit + big endian, so, perhaps, the symbol
reltype of bitendian 32bit differs from little endian 32bit, I will
check it later, thanks!

Regards,
Wu Zhangjin

On Mon, Nov 22, 2010 at 11:04 AM, Arnaud Lacombe <lacombar@gmail.com> wrote:
> Hi,
>
> The build of an `allyesconfig' configuration from v2.6.37-rc3 is
> failing relatively soon on the following:
>
> [...]
>  LD      init/mounts.o
> /OpenWrt-SDK-ar71xx-for-Linux-i686/staging_dir/toolchain-mips_gcc4.1.2/bin/mips-linux-ld:
> init/do_mounts.o: bad reloc symbol index (0x20200 >= 0x84) for offset
> 0x0 in section `__mcount_loc'
>
> /OpenWrt-SDK-ar71xx-for-Linux-i686/staging_dir/toolchain-mips_gcc4.1.2/bin/mips-linux-ld
> -v
> GNU ld version 2.17
>
> The toolchain originated from OpenWRT Kamikaze and is available on their FTP[0].
>
> I've not been able to locate the exact point of failure.
>
>  - Arnaud
>
> [0]: http://downloads.openwrt.org/kamikaze/8.09.2/ar71xx/
>
>
