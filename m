Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 02:09:48 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.246]:20980 "EHLO
	rv-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20021811AbZDXBJj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Apr 2009 02:09:39 +0100
Received: by rv-out-0708.google.com with SMTP id k29so670806rvb.24
        for <multiple recipients>; Thu, 23 Apr 2009 18:09:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=6I5LgQ9BBukY5MSwmV/A3wqXSq7s3dyqeoG3PEf3mt0=;
        b=xUCRer7ly/z77UtiHbybn/luT9wsNFhDDvUMuycz4gM8mZ3zstdDKitOIS4miKNkCj
         vrZBc/+jkXm6KN4CeK4lD1o7i63IaHY+i/ViyWwoM4mh6WwsRa4MsKi71T2elu5Hm3vH
         CAv0DdepibK/HCdY+rsK9MPzMkEbnCMMAFp2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=mu0vblIDIO1qdSn02wK07qrjZBbq0NVY9IIIJ30RVhliP1hrb9NKJhohCfqRneixL/
         kyLu+g8NgE9ZMWIP4Bc91O778DL3puryQkCrRB6sINQgvXgyFpz6GqZvH9ltOViWVu2w
         fC07sp94iz8zZ72pafv1PiR26ZT82U+vDcW6w=
Received: by 10.114.208.20 with SMTP id f20mr1005821wag.225.1240535372771;
        Thu, 23 Apr 2009 18:09:32 -0700 (PDT)
Received: from ?172.16.18.144? ([222.92.8.142])
        by mx.google.com with ESMTPS id k21sm851729waf.41.2009.04.23.18.09.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 18:09:32 -0700 (PDT)
Subject: Re: [loongson-dev] Re: a pre-release of merging loongson patchs to
 linux-2.6.29.1
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	loongson-dev@googlegroups.com
Cc:	yanh@lemote.com, zhangfx@lemote.com, penglj@lemote.com,
	huhb@lemote.com, taohl@lemote.com, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <49F0AFA3.6080408@thiscow.com>
References: <1240501332.28136.24.camel@falcon>
	 <49F0AFA3.6080408@thiscow.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Fri, 24 Apr 2009 09:09:03 +0800
Message-Id: <1240535343.25824.14.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-04-23 at 20:12 +0200, Erwan Lerale wrote:
> Wu Zhangjin wrote:
> > hi, all
> >
> > these days, I am working on merging loongson patchs to linux-2.6.29.1, 
> > the fuloong(2f) & yeeloong source code have been completely merged to an
> > 2f directory, most of the 2e & 2f source code have been merged except
> > the irq.c & reset.c, fixup-loongson2e.c & fixup-loongson2f.c.
> >   
> 
> Cool ! :)
> 
> [...]
> 
> > a current version is released to git://dev.lemote.com/rt4ls.git, 
> > (for avoid creating another git repository for it, i just use my
> > RT_PREEMPT git tree instead, so, it may be very big :-( )
> >
> > $ git clone git://dev.lemote.com/rt4ls.git
> > $ git checkout linux-2.6.29-stable-loongson --track
> > origin/linux-2.6.29-stable-loongson
> >   
> 
> You meant :
> 
> git checkout -b linux-2.6.29-stable-loongson --track
> origin/linux-2.6.29-stable-loongson
> 
> don't you ?
> 
Yes, thanks for correcting this error, forget to add the -b option.
> 
> I can not compile it :
> 
>   CC      arch/mips/loongson/common/bonito-irq.o
>   CC      arch/mips/loongson/common/mem.o
>   CC      arch/mips/loongson/common/dbg_io.o
> cc1: warnings being treated as errors
> arch/mips/loongson/common/dbg_io.c: In function �prom_printf
> arch/mips/loongson/common/dbg_io.c:178: error: the frame size of 1040
> bytes is larger than 1024 bytes
> make[1]: *** [arch/mips/loongson/common/dbg_io.o] Error 1
> make: *** [arch/mips/loongson/common] Error 2
> 

which gcc compiler do you use? gcc 4.4? i just try to compile it in gcc
4.4, get the same error. but i only test it in gcc 4.3(cross-compiler)
before, only a few "trivial" warnings.

a new branch for gcc 4.4 will be created as quickly as i can.

> I have used the config file from here :
> arch/mips/configs/yeeloong2f_defconfig
> 
> Cheers and thanks for your work !
> 

really thanks for your encouragement, welcome to take part in, lots of
source code lines need to be cleaned up.

> Erwan
> 
> 
> --~--~---------~--~----~------------~-------~--~----~
> You received this message because you are subscribed to the Google Groups "loongson-dev" group.
> To post to this group, send email to loongson-dev@googlegroups.com
> To unsubscribe from this group, send email to loongson-dev+unsubscribe@googlegroups.com
> For more options, visit this group at http://groups.google.com/group/loongson-dev?hl=en
> -~----------~----~----~----~------~----~------~--~---
> 
