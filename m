Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 10:15:04 +0100 (BST)
Received: from nz-out-0506.google.com ([64.233.162.236]:37879 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022620AbXCZJPC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 10:15:02 +0100
Received: by nz-out-0506.google.com with SMTP id x7so1393004nzc
        for <linux-mips@linux-mips.org>; Mon, 26 Mar 2007 02:14:01 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F32stS7LOV1yO9ck543+fpP+EwhLpmnSYpDRXbd59B0KEIEszcTcSVnOyNwjVSW/hkv/aKvlrEZpuEsByioavoHBAW0HfP47BDf3J4lcwHiaOpTkhqThQAikz0bV2wh8FbVpPOLxjdiF01eMJS6KyvZ14K7nCksOg9S1wQhuetc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KFUu2K04lzDjx/gW0t6vxd1HZq+nkFjtnMcznN0gvDwukE/ZsZJddNL1z6DHE4uoo83qVabVZxFaJIfoN9f5YsVvwZ++AZ0ztW8pXCPAGK+bMD+gKJgA14OCRthAYk1gWy+VsWgBH023xVl4NvB9B/3UMrrCmJqXdqy0XfEeSYI=
Received: by 10.114.201.1 with SMTP id y1mr2554278waf.1174900440932;
        Mon, 26 Mar 2007 02:14:00 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Mon, 26 Mar 2007 02:14:00 -0700 (PDT)
Message-ID: <cda58cb80703260214y536d871dq20575ce32da9cd07@mail.gmail.com>
Date:	Mon, 26 Mar 2007 11:14:00 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
Cc:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, kumba@gentoo.org,
	linux-mips@linux-mips.org, ths@networkno.de
In-Reply-To: <20070325164008.GA29334@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070324.234727.25910303.anemo@mba.ocn.ne.jp>
	 <20070324231602.GP2311@networkno.de> <46062400.8080307@gentoo.org>
	 <20070326.011000.75185255.anemo@mba.ocn.ne.jp>
	 <20070325164008.GA29334@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/25/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> Note IP27 works fine either way and the code size difference is considerable:
> Here are numbers for ip27_defconfig with gcc 4.1.2 and binutils 2.17:
>
>    text    data     bss     dec     hex filename
> 3397944  415768  256816 4070528  3e1c80 vmlinux BUILD_ELF64=n
> 3774968  415768  248624 4439360  43bd40 vmlinux BUILD_ELF64=y
>

Impressive figures !

However I can't understand why there's a such difference, I'm surely
missing something. AFAIK, we're not doing so many symbol loads in the
kernel ? Maybe this difference is related to ksymall ?

Could you make these 2 kernels available for downloading ?

thanks
-- 
               Franck
