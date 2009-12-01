Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 12:25:23 +0100 (CET)
Received: from 60-248-150-25.HINET-IP.hinet.net ([60.248.150.25]:47728 "EHLO
        dns.allplus-cn.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1492002AbZLAFaB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 06:30:01 +0100
Received: from DELLPC (unknown [116.231.39.52])
        by dns.allplus-cn.com (Postfix) with ESMTP id C41B42DBB23;
        Tue,  1 Dec 2009 14:28:03 +0800 (CST)
From:   "jack_lu" <jacklu@allplus-cn.com>
To:     <wuzhangjin@gmail.com>
Cc:     <linux-mips@linux-mips.org>
References: <74D96A2497124516897C6F4D06D8B5AB@DELLPC> <1259644416.5139.11.camel@falcon.domain.org>
In-Reply-To: <1259644416.5139.11.camel@falcon.domain.org>
Subject: =?gb2312?B?tPC4tDogaGVsbG8hIGNhbiB5b3UgaGVscCBtZSBmb3IgY29tcGlsaQ==?=
        =?gb2312?B?bmcgdGhlIGxpbnV4IGtlcm5lbD8=?=
Date:   Tue, 1 Dec 2009 13:29:32 +0800
Message-ID: <1A667674F8FA4416BF13CA3E9B322994@DELLPC>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="gb2312"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.1.7600.16385
Thread-Index: AcpyTUIR86a5UbZCQDKxZPGeG8YtqgAB2Dmw
X-Allplus-MailScanner-Information: Please contact the ISP for more information
X-Allplus-MailScanner: Found to be clean
X-Allplus-MailScanner-From: jacklu@allplus-cn.com
Return-Path: <jacklu@allplus-cn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25234
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jacklu@allplus-cn.com
Precedence: bulk
X-list: linux-mips

Dear Wu，
     The demo board is ONU. It is used in EPON systerm.
     I copy the cross-compilation to /opt,then modify CROSS_COMPILE
=/opt/openwrt/kamikaze_7.09/staging_dir_mips/bin/mips-linux-uclibc- in
mklzma.sh and Makefile.
     Then make config,and compile kernel.
     Use make command or sh mklzma.sh command can compile kernel.the same
errors come when excute one of two commands

Best Wishes
Jack Lu


-----邮件原件-----
发件人: Wu Zhangjin [mailto:wuzhangjin@gmail.com] 
发送时间: 2009年12月1日 13:14
收件人: jack_lu
抄送: linux-mips@linux-mips.org
主题: Re: hello! can you help me for compiling the linux kernel?

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
> 　　init/main.c:833: relocation truncated to fit: R_MIPS_26 against
`opipmux_gel_init'
> 　　init/main.c:835: undefined reference to `ip_auto_config'
> 　　init/main.c:835: relocation truncated to fit: R_MIPS_26 against
`ip_auto_config'
> 　　init/built-in.o: In function `start_kernel':
> 　　init/main.c:525: undefined reference to `setup_prom_printf'
> 　　init/main.c:525: relocation truncated to fit: R_MIPS_26 against
`setup_prom_printf'
> 　　init/main.c:527: undefined reference to `prom_printf'
> 　　init/main.c:527: relocation truncated to fit: R_MIPS_26 against
`prom_printf'
> 　　init/main.c:530: undefined reference to `prom_printf'
> 　　init/main.c:530: relocation truncated to fit: R_MIPS_26 against
`prom_printf'
> 　　arch/mips/kernel/built-in.o: In function `test_setdata':
> 　　arch/mips/kernel/syscall.c:461: undefined reference to
`set_ipmux_el_tx_buf_data'
> 　　arch/mips/kernel/syscall.c:461: relocation truncated to fit: R_MIPS_26
against `set_ipmux_el_tx_buf_data'
> 　　arch/mips/kernel/built-in.o: In function `test_getdata':
> 　　arch/mips/kernel/syscall.c:453: undefined reference to
`get_ipmux_el_rx_buf_data'
> 　　arch/mips/kernel/syscall.c:453: relocation truncated to fit: R_MIPS_26
against `get_ipmux_el_rx_buf_data'
> 　　arch/mips/kernel/built-in.o: In function `test_waitinterrupt':
> 　　arch/mips/kernel/syscall.c:446: undefined reference to
`wait_for_host_test_interrupt'
> 　　arch/mips/kernel/syscall.c:446: relocation truncated to fit: R_MIPS_26
against `wait_for_host_test_interrupt'
> 　　kernel/built-in.o: In function `free_module':
> 　　kernel/module.c:1231: undefined reference to `kfree1'
> 　　kernel/module.c:1231: relocation truncated to fit: R_MIPS_26 against
`kfree1'
> 　　drivers/built-in.o: In function `snapshot_map':
> 　　drivers/md/dm-snap.c:900: undefined reference to `__cmpdi2'
> 　　drivers/md/dm-snap.c:900: relocation truncated to fit: R_MIPS_26
against `__cmpdi2'
> 　　make: *** [.tmp_vmlinux1] Error 1
> 　　make: *** No rule to make target `../vmlinux', needed by `piggy.lzma'.
Stop.
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



-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
