Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 12:24:52 +0100 (CET)
Received: from mail-px0-f188.google.com ([209.85.216.188]:57711 "EHLO
        mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491890AbZLAFOF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 06:14:05 +0100
Received: by pxi26 with SMTP id 26so3482064pxi.21
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2009 21:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=biDWTKaGpxE7E8xz9W9tSmQ9Kx04Qa2WjIz6vqWIDXU=;
        b=aUf+/D+VT+cwAmrF16opwrsNBeTxT7YRzo1P/88Yg4zC9PuCxl3wb8bAyFci0QkeQr
         5HFpyb+sgoWfTYd4vSpNEmBfM/qLS8pMUTAL/lx3j4X80oWHWsmfLN0/Hol+1HVmNADM
         8oRDMEaO+HMKpU0zjHqlGQzShTIpfu5z1SAz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=qvgG2I5hbXvVrHNpamnm4ZlSt1OhmG5C4gpxJ2mqViUoeoUJjBxeJ/pnqgqWWn1Ggn
         0lG1ehw05/mzQu4N/QVWxHwtwkUYW6sGEtLRRNsFuOA4rzc/EofobfJ3rJrzWoViNRDU
         2ynlB+PP2ShO1LTePvbaWT9wd44TeZN15tVKc=
Received: by 10.115.134.40 with SMTP id l40mr9838187wan.41.1259644437268;
        Mon, 30 Nov 2009 21:13:57 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm306126pxi.12.2009.11.30.21.13.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Nov 2009 21:13:56 -0800 (PST)
Subject: Re: hello! can you help me for compiling the linux kernel?
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     jack_lu <jacklu@allplus-cn.com>
Cc:     linux-mips@linux-mips.org
In-Reply-To: <74D96A2497124516897C6F4D06D8B5AB@DELLPC>
References: <74D96A2497124516897C6F4D06D8B5AB@DELLPC>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 01 Dec 2009 13:13:36 +0800
Message-ID: <1259644416.5139.11.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25233
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2009-12-01 at 11:52 +0800, jack_lu wrote:
> Dear Sir,
> 　　hello! can you help me for compiling the linux kernel?
> 　　Linux version is linux-2.6.21.5.
> 　　CPU:mips
> 　　Cross-compilation tools is eldk and openwrt file packages.

Hello,

Which board are you using? and did you try the corresponding defconfig
file under arch/mips/configs/.

Regards,
	Wu zhangjin

> 　　Errors are the followings.
> 　　init/built-in.o: In function `init':
> 　　init/main.c:833: undefined reference to `opipmux_gel_init'
> 　　init/main.c:833: relocation truncated to fit: R_MIPS_26 against `opipmux_gel_init'
> 　　init/main.c:835: undefined reference to `ip_auto_config'
> 　　init/main.c:835: relocation truncated to fit: R_MIPS_26 against `ip_auto_config'
> 　　init/built-in.o: In function `start_kernel':
> 　　init/main.c:525: undefined reference to `setup_prom_printf'
> 　　init/main.c:525: relocation truncated to fit: R_MIPS_26 against `setup_prom_printf'
> 　　init/main.c:527: undefined reference to `prom_printf'
> 　　init/main.c:527: relocation truncated to fit: R_MIPS_26 against `prom_printf'
> 　　init/main.c:530: undefined reference to `prom_printf'
> 　　init/main.c:530: relocation truncated to fit: R_MIPS_26 against `prom_printf'
> 　　arch/mips/kernel/built-in.o: In function `test_setdata':
> 　　arch/mips/kernel/syscall.c:461: undefined reference to `set_ipmux_el_tx_buf_data'
> 　　arch/mips/kernel/syscall.c:461: relocation truncated to fit: R_MIPS_26 against `set_ipmux_el_tx_buf_data'
> 　　arch/mips/kernel/built-in.o: In function `test_getdata':
> 　　arch/mips/kernel/syscall.c:453: undefined reference to `get_ipmux_el_rx_buf_data'
> 　　arch/mips/kernel/syscall.c:453: relocation truncated to fit: R_MIPS_26 against `get_ipmux_el_rx_buf_data'
> 　　arch/mips/kernel/built-in.o: In function `test_waitinterrupt':
> 　　arch/mips/kernel/syscall.c:446: undefined reference to `wait_for_host_test_interrupt'
> 　　arch/mips/kernel/syscall.c:446: relocation truncated to fit: R_MIPS_26 against `wait_for_host_test_interrupt'
> 　　kernel/built-in.o: In function `free_module':
> 　　kernel/module.c:1231: undefined reference to `kfree1'
> 　　kernel/module.c:1231: relocation truncated to fit: R_MIPS_26 against `kfree1'
> 　　drivers/built-in.o: In function `snapshot_map':
> 　　drivers/md/dm-snap.c:900: undefined reference to `__cmpdi2'
> 　　drivers/md/dm-snap.c:900: relocation truncated to fit: R_MIPS_26 against `__cmpdi2'
> 　　make: *** [.tmp_vmlinux1] Error 1
> 　　make: *** No rule to make target `../vmlinux', needed by `piggy.lzma'.  Stop.
> 　　copyed to ../wrt_uImage
> 　　cp: cannot stat `uImageLzma': No such file or directory
> 　　ls: cannot access ../wrt_uImage: No such file or directory
> 　　===============================================================
> 　　    output files:                           
> 　　         wrt_uImage : the kernel image      
> 　　
> 　　
> 　　Thanks &Best Wishes,
> 　　Jack_Lu(鲁红刚)
>    益满颖贸易（上海）有限公司
>    上海市愚园路168号环球大厦A座2101室
>    电话：+86 21 62495328/29/30/31 分机：820
>    传真：+86 21 62490538
>    MSN: luhongang@163.com
> 
> 　　
> 
> 
