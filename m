Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 19:31:11 +0100 (BST)
Received: from wf-out-1314.google.com ([209.85.200.170]:43791 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022936AbZEOSbE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 19:31:04 +0100
Received: by wf-out-1314.google.com with SMTP id 28so1168924wfa.21
        for <multiple recipients>; Fri, 15 May 2009 11:31:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=hGx3IvmCWr901mZQrJzdUr1yRqfnFMmmqH5Uf4LEG5s=;
        b=xT7NWUVTX1/A95N6ob2fhchU3mV3jjJth0Ha/SZ3zhnl8DJo3SIRrNDAC3X0obHs2f
         80ToC0I3uCDQ4X6LWW6n7/xwh0xLFkJKeiuQOeoatCp8UP8TR4UocrH5oYFnypqegXfg
         jg3MdFNKNxW18/XxNXX2LBSDBnU6zmgF2+8nY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=R6k7byMxfdEE0t61J2D6Fd/Yg0rnIvjPP5TnyHK9/UIDMqZdcYbwrSW9slRcqqr4wy
         0VBLPGCuZLeYdpkE1AcQO7RflLU3kKACUtK4xujCIv7gJu3OeNwZrOlbufJzXzgfgdwo
         UgMLlZAsGIYmutTdvAgC4686OlAt3zbEGwO3g=
Received: by 10.142.177.5 with SMTP id z5mr1167320wfe.235.1242412262390;
        Fri, 15 May 2009 11:31:02 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 27sm3121522wfa.22.2009.05.15.11.30.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 11:31:02 -0700 (PDT)
Subject: Re: [GIT repo] loongson: Merge and Clean up fuloong(2e),
 fuloong(2f) and yeeloong(2f) support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Zhang Le <r0bertz@gentoo.org>
Cc:	Arnaud Patard <apatard@mandriva.com>, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <20090515170926.GE28012@adriano.hkcable.com.hk>
References: <1242357553.30339.66.camel@falcon>
	 <m3iqk2rcwd.fsf@anduin.mandriva.com> <1242383903.10164.118.camel@falcon>
	 <20090515170926.GE28012@adriano.hkcable.com.hk>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 02:00:03 +0800
Message-Id: <1242410403.10164.122.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, 2009-05-16 at 01:09 +0800, Zhang Le wrote:
> On 18:38 Fri 15 May     , Wu Zhangjin wrote:
> > On Fri, 2009-05-15 at 10:25 +0200, Arnaud Patard wrote:
> > > - even if it should not affect the kernel, compiling with
> > >   -march=loongson2f even for 2e (you're matching on loongson2 so 2e and
> > >   2f) looks weird.
> > 
> > sorry, this is really a very obvious error, in 2e, -march=loongson2e
> > should be used.
> > 
> > to fix this problem, perhaps we can add two new kernel options:
> > 
> > config CPU_LOONGSON2E
> > 	bool
> > 
> > config CPU_LOONGSON2F
> > 	bool
> > 
> > and then use this solution:
> > 
> > config FULOONG2E
> > 	...
> > 	select CPU_LOONGSON2E
> > 	...
> > 
> > config YEELOONG2F
> > 	...
> > 	select CPU_LOONGSON2F
> > 	...
> > 
> > cflags-$(CONFIG_CPU_LOONGSON2E)  += -march=loongson2e -Wa,--trap
> > cflags-$(CONFIG_CPU_LOONGSON2F)  += -march=loongson2f -Wa,--trap
> > 
> > is this solution okay?
> 
> I have tried to solve this problem once. At that time, there is no loongson-dev
> list. So I send my patch to yanhua and zhang fuxin directly. It seems that they
> didn't forward that patch to you.
> 
> For the whole patch, please check attachment. It does not applicable on top of
> your work any more.
> 
> But here is how I deal with the CPU types:
> 
> @@ -951,14 +929,20 @@ choice
>        prompt "CPU type"
>        default CPU_R4X00
> 
> -config CPU_LOONGSON2
> -       bool "Loongson 2"
> -       depends on SYS_HAS_CPU_LOONGSON2
> -       select CPU_SUPPORTS_32BIT_KERNEL
> -       select CPU_SUPPORTS_64BIT_KERNEL
> -       select CPU_SUPPORTS_HIGHMEM
> +config CPU_LOONGSON2E
> +       bool "Loongson 2E"
> +       depends on SYS_HAS_CPU_LOONGSON2E
> +       select CPU_LOONGSON2
> +       help
> +         The Loongson 2E processor implements the MIPS III instruction set
> +         with many extensions.
> +
> +config CPU_LOONGSON2F
> +       bool "Loongson 2F"
> +       depends on SYS_HAS_CPU_LOONGSON2F
> +       select CPU_LOONGSON2
>         help
> -         The Loongson 2E/2F processor implements the MIPS III instruction set
> +         The Loongson 2F processor implements the MIPS III instruction set
>          with many extensions.
> 
>  config CPU_MIPS32_R1
> @@ -1171,7 +1155,16 @@ config CPU_SB1
> 
>  endchoice
> 
> -config SYS_HAS_CPU_LOONGSON2
> +config CPU_LOONGSON2
> +       bool
> +       select CPU_SUPPORTS_32BIT_KERNEL
> +       select CPU_SUPPORTS_64BIT_KERNEL
> +       select CPU_SUPPORTS_HIGHMEM
> +
> +config SYS_HAS_CPU_LOONGSON2E
> +       bool
> +
> +config SYS_HAS_CPU_LOONGSON2F
>         bool
> 
>  config SYS_HAS_CPU_MIPS32_R1
> 

applied it, thanks!
