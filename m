Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2006 09:23:56 +0100 (BST)
Received: from wproxy.gmail.com ([64.233.184.228]:14388 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133516AbWDXIXq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Apr 2006 09:23:46 +0100
Received: by wproxy.gmail.com with SMTP id i20so763205wra
        for <linux-mips@linux-mips.org>; Mon, 24 Apr 2006 01:36:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q9NpklqTYipwsmCmJ/PbYL3AYLNxk9q3CB8+Zh8D+0ksVpJ1PZnvzKoBVbDlPNN3gmCRHagAo/7RBlIZK5B7gXZBigw5aKLVydzrCqtrtFBPwOOxsLU/tY13eLtI/UMf9NFFvhlrrkKmB/rZ1ZtA0yHU7d/gRXRIDlBYL7IK6nM=
Received: by 10.65.40.5 with SMTP id s5mr493923qbj;
        Mon, 24 Apr 2006 01:36:43 -0700 (PDT)
Received: by 10.64.131.15 with HTTP; Mon, 24 Apr 2006 01:36:43 -0700 (PDT)
Message-ID: <85e0e3140604240136t6c8e9cc3oa0ec4fc3030777e3@mail.gmail.com>
Date:	Mon, 24 Apr 2006 14:06:43 +0530
From:	Niklaus <niklaus@gmail.com>
To:	zhuzhenhua <zzh.hust@gmail.com>
Subject: Re: "relocation truncated to fit: R_MIPS_CALL16"
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <50c9a2250604222002x37b949fbi585ed5fb31087d5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250604222002x37b949fbi585ed5fb31087d5@mail.gmail.com>
Return-Path: <niklaus@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: niklaus@gmail.com
Precedence: bulk
X-list: linux-mips

On 4/23/06, zhuzhenhua <zzh.hust@gmail.com> wrote:
> i want to write a mini bootloader for my board, so i need jump to c
> code from asm code
> but when i compile and ld, i get "relocation truncated to fit:
> R_MIPS_CALL16" messages for every function call..
I had this error sometime back.
I increased the size of ROM0 and RAM0 in linker script which was used by ld.

I initially had problem using mips-linux-gcc(only for linux userspace
application) toolchain, when i used the target mips-elf-gcc(this one
should be used) i got around it.

> i have try the mips_4KCle-gcc(worked for u-boot),
> mips_fp_le-gcc(worked for mvita linux), and also a
> mipsel-linux-gcc(worked for my linux 2.6 kernel), but they all failed,
> even i add -G0 to gcc.
> and i only compile success by using mips-elf-gcc under cygwin.
> does it be caused by binutils version? or gcc compile CFLAGS?
> thanks for any hints
>
> Best Regards
>
> Zhuzhenhua
>
>
