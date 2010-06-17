Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2010 14:39:50 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:43069 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492196Ab0FQMjq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jun 2010 14:39:46 +0200
Received: by wyb40 with SMTP id 40so3160250wyb.36
        for <linux-mips@linux-mips.org>; Thu, 17 Jun 2010 05:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=E+9QpdyLYAnJp3tY2wOL9WDsqq0Y+6m2ksJbceC1sqU=;
        b=qypQCovPhYLtwfNjdPo//IrVyLWO2lz/wKKubLhf37oBAJKPKrZOZqfY6a3+smEToW
         Pu+5bw89hfkrOgMeLvAZKqaESLCxTHtvfAla+C7a837zjdJNA1TIvzgv3LuL+k5R/Hiq
         IVUUrceiewKAZVW+WaEP+wKeZ6f/FBvmfST4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=mQA8cb/WE5huYjoW4cxQBGLfFlpnqUEp4ODiaPdpPB/f8F48JUoNfwKNYTsGVOYEjY
         o3ql7c82sKrFVuWyBc7cA++J7Aq8/OIfLPgmYVQGdyhv+uftBcosHmIvl5uW2xxloTPO
         NAbxAh6aX/hXP+K40LJEmQqS1kg1a5Z3qFxc0=
Received: by 10.216.90.15 with SMTP id d15mr2019489wef.0.1276778380603;
        Thu, 17 Jun 2010 05:39:40 -0700 (PDT)
Received: from flexo.localnet ([213.228.1.121])
        by mx.google.com with ESMTPS id n29sm2722604wej.17.2010.06.17.05.39.38
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 17 Jun 2010 05:39:38 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     wu zhangjin <wuzhangjin@gmail.com>
Subject: Re: zboot for brcm
Date:   Thu, 17 Jun 2010 14:38:15 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.32-22-server; KDE/4.4.2; x86_64; ; )
Cc:     Waldemar Brodkorb <mail@waldemar-brodkorb.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips" <linux-mips@linux-mips.org>
References: <20100609153831.GA27461@waldemar-brodkorb.de> <1276179278.21482.16.camel@localhost> <AANLkTikZc02RQ2zJ4Cj0nxUezYXyVIMxQS2opAWSjOrd@mail.gmail.com>
In-Reply-To: <AANLkTikZc02RQ2zJ4Cj0nxUezYXyVIMxQS2opAWSjOrd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201006171438.15832.florian@openwrt.org>
X-archive-position: 27158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12001

Hi,

On Thursday 17 June 2010 14:20:49 wu zhangjin wrote:
> Hi,
> 
> I just got a bcm1250a board, it also uses the CFE as the bootloader, I
> compiled a compressed vmlinuz-2.6.34 for it and boot with the
> following command, it works well:
> 
> CFE> setenv bootargs root=/dev/nfs rw
> nfsroot=$nfs_server_ip:/path/to/nfs_root_fs ip=dhcp
> CFE> ifconfig -auto eth0
> CFE> boot -elf $tftp_server_ip:/path/to/vmlinuz
> 
> With -elf, the boot command of CFE can parse the vmlinuz and boot it
> normally. I think you have used the wrong options of the boot command.

CFE on bcm12xx, on bcm47xx and bcm63xx are all three slightly different flavors 
which may not behave exactly the same way wrt the load command.

Also, you are on a development board so there are no reasons to restrict CFE 
commands, this is not the case with end-user products like WRT54G and such.
--
Florian
