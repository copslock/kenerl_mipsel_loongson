Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2010 15:31:47 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:39346 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491961Ab0FQNbm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jun 2010 15:31:42 +0200
Received: by pxi17 with SMTP id 17so330604pxi.36
        for <multiple recipients>; Thu, 17 Jun 2010 06:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=mpmLSrFrxLLGKuOa+Ja7LU3tsSCX14otThduPLbk0KA=;
        b=M9puIsBF7LIYKjCumII3P2zmjtu5tVTYk0N+xHMxRRPcxY5e50154bkuxxZqwtPIHe
         54ZaC2uHckgC4K7NMgZPejsnO/BUGik9nMrEwuF2Fiai0s7eyWDZJsAIW6pG6DJQGlJf
         LyMKyvctiogIeG3QtOMGYndkPYYav1P5VLgGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Ep7cwBswAFxYRzFy2YERDv3wr/FNEZF0BXmbE49RZTdbGFdhCLociiDxOyi3qrUcmn
         AhmN/jj/N81jaU9X+Lj6VN/oRCtX6QXRSqfuZGoB/Nnyi2+GlSv866gxiL7zI6BVpjyW
         NW4Z1h/LBJhhAIp5hLmxmiUVfd+FJiOfjjT0E=
Received: by 10.115.39.8 with SMTP id r8mr8265580waj.228.1276781495490;
        Thu, 17 Jun 2010 06:31:35 -0700 (PDT)
Received: from [192.168.0.106] ([182.18.29.11])
        by mx.google.com with ESMTPS id c22sm95419439wam.6.2010.06.17.06.31.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Jun 2010 06:31:34 -0700 (PDT)
Subject: Re: zboot for brcm
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Waldemar Brodkorb <mail@waldemar-brodkorb.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <201006171438.15832.florian@openwrt.org>
References: <20100609153831.GA27461@waldemar-brodkorb.de>
         <1276179278.21482.16.camel@localhost>
         <AANLkTikZc02RQ2zJ4Cj0nxUezYXyVIMxQS2opAWSjOrd@mail.gmail.com>
         <201006171438.15832.florian@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Thu, 17 Jun 2010 21:31:19 +0800
Message-ID: <1276781479.4271.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-archive-position: 27160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12044

Hi,

On Thu, 2010-06-17 at 14:38 +0200, Florian Fainelli wrote:
> Hi,
> 
> On Thursday 17 June 2010 14:20:49 wu zhangjin wrote:
> > Hi,
> > 
> > I just got a bcm1250a board, it also uses the CFE as the bootloader, I
> > compiled a compressed vmlinuz-2.6.34 for it and boot with the
> > following command, it works well:
> > 
> > CFE> setenv bootargs root=/dev/nfs rw
> > nfsroot=$nfs_server_ip:/path/to/nfs_root_fs ip=dhcp
> > CFE> ifconfig -auto eth0
> > CFE> boot -elf $tftp_server_ip:/path/to/vmlinuz
> > 
> > With -elf, the boot command of CFE can parse the vmlinuz and boot it
> > normally. I think you have used the wrong options of the boot command.
> 
> CFE on bcm12xx, on bcm47xx and bcm63xx are all three slightly different flavors 
> which may not behave exactly the same way wrt the load command.
> 
> Also, you are on a development board so there are no reasons to restrict CFE 
> commands, this is not the case with end-user products like WRT54G and such.

Hmm, Maybe, I have no such products to test, anybody have such products,
welcome to test it ;)

Best Regards,
	Wu Zhangjin
