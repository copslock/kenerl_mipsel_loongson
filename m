Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jul 2008 18:53:41 +0100 (BST)
Received: from mx03.syneticon.net ([87.79.32.166]:22534 "EHLO
	mx03.syneticon.net") by ftp.linux-mips.org with ESMTP
	id S32704464AbYGARxe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Jul 2008 18:53:34 +0100
Received: from localhost (filter1.syneticon.net [192.168.113.3])
	by mx03.syneticon.net (Postfix) with ESMTP id 22DC29601;
	Tue,  1 Jul 2008 19:53:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mx03.syneticon.net
Received: from mx03.syneticon.net ([192.168.113.4])
	by localhost (mx03.syneticon.net [192.168.113.3]) (amavisd-new, port 10025)
	with ESMTP id py1CEgWu3J7t; Tue,  1 Jul 2008 19:53:19 +0200 (CEST)
Received: from [192.168.10.145] (koln-4d0b69d5.pool.mediaWays.net [77.11.105.213])
	by mx03.syneticon.net (Postfix) with ESMTP;
	Tue,  1 Jul 2008 19:53:19 +0200 (CEST)
Message-ID: <486A6F0D.4070802@wpkg.org>
Date:	Tue, 01 Jul 2008 19:53:17 +0200
From:	Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Thunderbird 2.0.0.12 (X11/20080305)
MIME-Version: 1.0
To:	Nicolas Schichan <nschichan@freebox.fr>
CC:	linux-mips@linux-mips.org,
	Kexec Mailing List <kexec@lists.infradead.org>,
	openwrt-devel@lists.openwrt.org
Subject: Re: kexec on mips - anyone has it working?
References: <483BCB75.4050901@wpkg.org> <200805301327.11925.nschichan@freebox.fr> <483FE764.1090901@wpkg.org> <200807011542.29274.nschichan@freebox.fr>
In-Reply-To: <200807011542.29274.nschichan@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mangoo@wpkg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mangoo@wpkg.org
Precedence: bulk
X-list: linux-mips

Nicolas Schichan schrieb:
> On Friday 30 May 2008 13:39:16 Tomasz Chmielewski wrote:
> 
> Hello,
> 
>> Nicolas Schichan schrieb:
>>> On Thursday 29 May 2008 22:15:47 Tomasz Chmielewski wrote:
>>>> Will call new kernel at 00305000
>>> The calling address of the kernel looks quite wrong, it should clearly
>>> be inside the KSEG0 zone. could  you please indicate the output of the
>>> command "mips-linux-readelf -l vmlinux" ?
>> # uname -m
>> mips
>> # readelf -l vmlinux
>>
>> Elf file type is EXEC (Executable file)
>> Entry point 0x80251b50
> 
> This is  quite surprising.   The jump address  that kexec will  use is
> cleary not what  I expected. I would have expected it  to be the Entry
> point address given by readelf.
> 
> could  you try  the  following patch  to  make sure  that the  kimage*
> structure is not corrupted by the code in machine_kexec() ?
> 
> Index: linux/arch/mips/kernel/machine_kexec.c
> ===================================================================
> --- linux/arch/mips/kernel/machine_kexec.c	(revision 8056)
> +++ linux/arch/mips/kernel/machine_kexec.c	(working copy)
> @@ -49,6 +49,8 @@
>  	unsigned long entry;
>  	unsigned long *ptr;
>  
> +	printk("image->start = %p", image->start);
> +
>  	reboot_code_buffer =
>  	  (unsigned long)page_address(image->control_code_page);

Umm?

   CC      arch/mips/kernel/machine_kexec.o
cc1: warnings being treated as errors
arch/mips/kernel/machine_kexec.c: In function 'machine_kexec':
arch/mips/kernel/machine_kexec.c:52: warning: format '%p' expects type 
'void *', but argument 2 has type 'long unsigned int'
make[6]: *** [arch/mips/kernel/machine_kexec.o] Error 1
make[5]: *** [arch/mips/kernel] Error 2
make[5]: Leaving directory 
`/home/tch-data/openwrt/11612/build_dir/linux-brcm47xx/linux-2.6.25.9'



-- 
Tomasz Chmielewski
http://wpkg.org
