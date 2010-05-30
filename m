Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 May 2010 05:01:00 +0200 (CEST)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:61292 "EHLO
        mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490967Ab0E3DA5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 May 2010 05:00:57 +0200
Received: by pzk32 with SMTP id 32so1307878pzk.21
        for <multiple recipients>; Sat, 29 May 2010 20:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=xYbPpY4Bt4AnkouTWwu5GsZhv/2Xql9+l0xPIScFMAw=;
        b=AmLFbJw7y+pmxYqMKxkV77AYGRyOTrbWUb81irbwTXbAVxjrqgJKJAV4379MNhi7yz
         DWLRwKgTCuDPAED3b4HheAjDBSBmrY8hycAIH49nsajOMyQea9BGmOdvAoJBFzeGW143
         VEwOivY4l7WOHU3+4X9YWXB1vhSmAdDYKxRi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=ZvnegEQdmqRg/BrfSQytW2/Ar34MtHDGf3tAMGYYJzjwXyEGSJJmDv2eUda+LXS0PI
         smo6OMJgsFup2BQkGdrogSKMaOH0w2w+x0Q0P/UyeZcIo7Wan/A6/INBF9R+0dNdetXk
         kbkau15AFKgG+t8NDSCbruty73zLx41KPXl58=
Received: by 10.115.64.21 with SMTP id r21mr2042722wak.23.1275188449385;
        Sat, 29 May 2010 20:00:49 -0700 (PDT)
Received: from [192.168.2.226] ([202.201.14.140])
        by mx.google.com with ESMTPS id a23sm35256384wam.2.2010.05.29.20.00.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 20:00:48 -0700 (PDT)
Subject: Re: [PATCHv2] mips: drop CLEAN_FILES from arch/mips/Makefile
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20100529194019.GA16249@merkur.ravnborg.org>
References: <20100529111713.GA31550@merkur.ravnborg.org>
         <1275134778.11949.21.camel@localhost>
         <20100529194019.GA16249@merkur.ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sun, 30 May 2010 11:00:42 +0800
Message-ID: <1275188442.4258.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Sam

Most of them looks good, thanks!

[...]
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index 790ddd3..223dd4d 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -100,6 +100,7 @@ OBJCOPYFLAGS_vmlinuz.srec := $(OBJCOPYFLAGS) -S -O srec
>  vmlinuz.srec: vmlinuz
>  	$(call if_changed,objcopy)
>  
> -clean:
> -clean-files += *.o \
> -	       vmlinu*
> +# vmlinu* files created in top-level dir of the kernel
> +clean-files := $(objtree)/vmlinu*
> +# files created in arch/mips/boot/compressed
> +clean-files += vmlinux.* piggy.o

but just tested it, seems the above piggy.o is not needed.

Thanks & Regards,
	Wu Zhangjin
