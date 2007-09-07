Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2007 10:00:56 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.172]:37327 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20025093AbXIGJAr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Sep 2007 10:00:47 +0100
Received: by ug-out-1314.google.com with SMTP id u2so292227uge
        for <linux-mips@linux-mips.org>; Fri, 07 Sep 2007 02:00:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=9KVJqN9EDqTeivmn9wys5BLitwMfxK4aATbe4HONg4M=;
        b=af1Gnx+XZSoLBhsNTTs+/0I8z6pIcaAjeSWU4mSdEc6OK55E+rUBlh1uaeYaPSxh+LwO2E2vp/YBNnVAn0wApuXtcGeSZQkSq2KvW/FqQUv6CYAZHzz7Wu5p3OjoCCzZmExyNZ0aMO+NvUi/u8agVlVTHZOf97/wsmyxRjyA1eM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=U/SusDcvCnkZ/G8VXu7Ylf5JrKhKZasanvZggALKTbuuBG7Zallje3oKlu1VURjMpHssyBfvBs4Qh7PcIP801OUxAFf3QYPAGS+K0RrfWvTK9pFlY2XeU4T+A4oOI8ZM/oCEn91zjSoe+nBeVuqzbmE5UpFMqU9Tel3s8Ch+ccQ=
Received: by 10.67.16.2 with SMTP id t2mr1120956ugi.1189155629770;
        Fri, 07 Sep 2007 02:00:29 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id o30sm3342047ugd.2007.09.07.02.00.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Sep 2007 02:00:25 -0700 (PDT)
Message-ID: <46E11314.9010701@gmail.com>
Date:	Fri, 07 Sep 2007 11:00:04 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: flush_kernel_dcache_page() not needed ?
References: <46DC29F0.3060200@gmail.com>	<20070904.005400.52128244.anemo@mba.ocn.ne.jp>	<46DD53BE.2070004@gmail.com> <20070906.003320.25909195.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070906.003320.25909195.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Tue, 04 Sep 2007 14:46:54 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> One thing you might want to try is:
>>
>> 	$ echo 0 > /proc/sys/kernel/randomize_va_space
>>
>> and see if your system still works fine. This command should avoid a
>> data cache flush when moving the stack around. See shift_arg_pages().
>>
>> With this, maybe you could give this testcase a try:
>>
>> 	$ /bin/echo "`seq 10000`" > seq.txt
>>
>> and see if seq.txt is correct. This command should pass to echo (not
>> the bash builtin one) a long argument that should fill your
>> dcache.
> 
> I tried this and everything worked fine with/without the
> flush_kernel_dcache_page() ;)
> 
>> That said the execve syscall code is quite 'hairy' and it may not be
>> suprising that after this syscall the dcache has been completly
>> flushed and thus make the problem disappear.
> 
> Yes, there is an yet another path to "flush all dcache".
> 
> do_execve()
>   copy_strings()
>     flush_kernel_dcache_page()
>   search_binary_handler()
>     load_elf_binary()
>       flush_old_exec()
>         exec_mmap()
>           mmput()
>             exit_mmap()
>               flush_cache_mm()
>                 r4k_blast_dcache()
> 
> Anyway, the implementation of flush_kernel_dcache_page() is very
> simple so that we can believe it works correctly without any testcase.
> Too optimistic? :)

god only knows ;)

		Franck
