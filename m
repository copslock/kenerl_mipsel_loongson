Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 08:08:51 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.241]:33337 "EHLO
	rv-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20023450AbZDXHIm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Apr 2009 08:08:42 +0100
Received: by rv-out-0708.google.com with SMTP id k29so768913rvb.24
        for <multiple recipients>; Fri, 24 Apr 2009 00:08:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=7h0UPa7Xw8/j9LxWvVWH5EImm3e2Xm+Ryk+EX4G8xAQ=;
        b=spDg2BbtT1dt18B1cRbIOZUP7IcxQCmpGfpy4BJJcbi8Fp4e1LkLadt5mS7RiuqCpY
         FLWkpRN/tBx/nlyEX9x4ePNd4zyMhxoUSogS+TlgFxUv90vf3L1VjJyb0IrMGomzjtRY
         svosIj4vXs1l37+Lq3qZcSsuyg0O5+Zp6eah8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=ARQt5TjuNWunc+KIxwOyIq2WzR6OIzFSZZ6Z4iVr13d3PvizlYuCRM+tpCKPa89V2T
         IvvsiPEke2PcpRb1izQZ9dHjx5pAGu068baBRwYHS+wAPKQPtrCGMGMa1DMA2zbLdBZU
         D3KvpPMoxHx/LYSNoovXAVvfI5nVQFqBtb3as=
Received: by 10.141.84.21 with SMTP id m21mr602092rvl.284.1240556916913;
        Fri, 24 Apr 2009 00:08:36 -0700 (PDT)
Received: from ?172.16.18.144? ([222.92.8.142])
        by mx.google.com with ESMTPS id f42sm1894099rvb.41.2009.04.24.00.08.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Apr 2009 00:08:36 -0700 (PDT)
Subject: Re: [loongson-dev] Re: a pre-release of merging loongson patchs to
 linux-2.6.29.1
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	loongson-dev@googlegroups.com
Cc:	yanh@lemote.com, zhangfx@lemote.com, penglj@lemote.com,
	huhb@lemote.com, taohl@lemote.com, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <49F16061.9010207@thiscow.com>
References: <1240501332.28136.24.camel@falcon>
	 <49F0AFA3.6080408@thiscow.com> <1240535343.25824.14.camel@falcon>
	 <49F16061.9010207@thiscow.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Fri, 24 Apr 2009 15:03:37 +0800
Message-Id: <1240556617.23345.10.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-04-24 at 08:46 +0200, Erwan Lerale wrote:
> Wu Zhangjin a écrit :
> >> I can not compile it :
> >>
> >>   CC      arch/mips/loongson/common/bonito-irq.o
> >>   CC      arch/mips/loongson/common/mem.o
> >>   CC      arch/mips/loongson/common/dbg_io.o
> >> cc1: warnings being treated as errors
> >> arch/mips/loongson/common/dbg_io.c: In function �prom_printf
> >> arch/mips/loongson/common/dbg_io.c:178: error: the frame size of 1040
> >> bytes is larger than 1024 bytes
> >> make[1]: *** [arch/mips/loongson/common/dbg_io.o] Error 1
> >> make: *** [arch/mips/loongson/common] Error 2
> >>
> >>     
> >
> > which gcc compiler do you use? gcc 4.4? i just try to compile it in gcc
> > 4.4, get the same error. but i only test it in gcc 4.3(cross-compiler)
> > before, only a few "trivial" warnings.
> >
> > a new branch for gcc 4.4 will be created as quickly as i can.
> >
> >   

a new branch for gcc 4.4 is created as linux-2.6.29-stable-loongson-gcc4.4, 
welcome to pull it.

$ git clone git://dev.lemote.com/rt4ls.git
$ git checkout -b linux-2.6.29-stable-loongson-gcc4.4 --track origin/linux-2.6.29-stable-loongson-gcc4.4

if you have cloned it, just update it and then checkout the branch

$ git pull
$ git checkout -b linux-2.6.29-stable-loongson-gcc4.4 --track origin/linux-2.6.29-stable-loongson-gcc4.4

> I would be happy to help with the code but my C skills are need the 
> "hello world" stuff  :)
> I can help with testing and writing documentations.
> 

thanks all the same :-)

> Cheers
> Erwan
> 
> --~--~---------~--~----~------------~-------~--~----~
> You received this message because you are subscribed to the Google Groups "loongson-dev" group.
> To post to this group, send email to loongson-dev@googlegroups.com
> To unsubscribe from this group, send email to loongson-dev+unsubscribe@googlegroups.com
> For more options, visit this group at http://groups.google.com/group/loongson-dev?hl=en
> -~----------~----~----~----~------~----~------~--~---
> 
