Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Sep 2010 19:12:26 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:41123 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491075Ab0ILRMX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Sep 2010 19:12:23 +0200
Received: by wyb38 with SMTP id 38so5846223wyb.36
        for <multiple recipients>; Sun, 12 Sep 2010 10:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=xKwZOE9eIcLeIUSBqeuXB+brHfvRKp3XTGMBqvuEK40=;
        b=Jw38lS64OqbvQO5Yb7VilyHG7FfqzlhIfPYnp80lpHjNaMTEmWBcbKNI9EbvmtQ+Tw
         LEaot/vTgq1SxhY434fGjs+P2yz52pO3Kd5CfVnfOf2pTgCcBaKCrQhvjfzWK1BKxM+m
         GJpKhKjL0yUfrAE3CothcVzBOIGDRsAs5YY1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=CvrE98wmHRkuXT5z693XqslDWiqdGCU6VgUw1fNSMXyBdUyu+4RpuyTYmlTNEnifIy
         I+7jY71ihK6Q8w93wNvvL0Zto55wKknI9n3/JyDzq65tNHNEMHWKWjWJ9rk/ij5Radqq
         Ef/QlQaQIJiuLBZwjrSVE+AzQyYd2Bhsbi5Bo=
Received: by 10.216.176.83 with SMTP id a61mr3370673wem.47.1284311537205;
        Sun, 12 Sep 2010 10:12:17 -0700 (PDT)
Received: from lenovo.localnet (129.199.66-86.rev.gaoland.net [86.66.199.129])
        by mx.google.com with ESMTPS id k83sm3266568weq.14.2010.09.12.10.12.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Sep 2010 10:12:14 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
To:     wuzhangjin@gmail.com
Subject: Re: zboot for brcm
Date:   Sun, 12 Sep 2010 19:13:28 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.35-trunk-amd64; KDE/4.4.5; x86_64; ; )
Cc:     Waldemar Brodkorb <mail@waldemar-brodkorb.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips" <linux-mips@linux-mips.org>
References: <20100609153831.GA27461@waldemar-brodkorb.de> <201006171438.15832.florian@openwrt.org> <1276781479.4271.8.camel@localhost>
In-Reply-To: <1276781479.4271.8.camel@localhost>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <201009121913.29339.florian@openwrt.org>
X-archive-position: 27748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 9368

Hi Wu,

Le Thursday 17 June 2010 15:31:19, Wu Zhangjin a écrit :
> Hi,
> 
> On Thu, 2010-06-17 at 14:38 +0200, Florian Fainelli wrote:
> > Hi,
> > 
> > On Thursday 17 June 2010 14:20:49 wu zhangjin wrote:
> > > Hi,
> > > 
> > > I just got a bcm1250a board, it also uses the CFE as the bootloader, I
> > > compiled a compressed vmlinuz-2.6.34 for it and boot with the
> > > following command, it works well:
> > > 
> > > CFE> setenv bootargs root=/dev/nfs rw
> > > nfsroot=$nfs_server_ip:/path/to/nfs_root_fs ip=dhcp
> > > CFE> ifconfig -auto eth0
> > > CFE> boot -elf $tftp_server_ip:/path/to/vmlinuz
> > > 
> > > With -elf, the boot command of CFE can parse the vmlinuz and boot it
> > > normally. I think you have used the wrong options of the boot command.
> > 
> > CFE on bcm12xx, on bcm47xx and bcm63xx are all three slightly different
> > flavors which may not behave exactly the same way wrt the load command.
> > 
> > Also, you are on a development board so there are no reasons to restrict
> > CFE commands, this is not the case with end-user products like WRT54G
> > and such.
> 
> Hmm, Maybe, I have no such products to test, anybody have such products,
> welcome to test it ;)

I just ran into the issue described by Waldemar on a BCM6348 board. You 
mentionned you were writing a patch, do you have one I could test on BCM63xx?
--
Florian
