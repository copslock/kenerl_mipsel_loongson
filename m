Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 20:20:30 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:42284 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491030Ab1FLSUY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2011 20:20:24 +0200
Received: by wwb17 with SMTP id 17so3518637wwb.24
        for <multiple recipients>; Sun, 12 Jun 2011 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:subject:date:user-agent:cc
         :references:in-reply-to:organization:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=GG3sFP5RQ+ngdjK60BJ6bq8uruV+BRpQpQ6GWlhkzuw=;
        b=dcxUa6M5GZvGS8OiYDTyuLp5KcVCZd14NQlJ9b0fY2jUGlhfyB7OeD7sIBWatbHehl
         TgXJu0A34fomMFbnWOvQi6SlsxQBhUiUtcaiFJMXb0fdDMdEvKmohXv/hTbNGMMh+lxD
         9/SdDk7TMRvDsdB/+IawT7V9GBnSne0GUj2VQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :organization:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=J2X5nShmsTqj9xb5p5L21OBEJz3eolCcIFfPN6OcYRVdLS3F0D2HWoMd3CcSnze/gb
         8QcMtUOnTO8979lkoArBi2M161xXazwOUSOdHTCtxcp4xTyyBg6/UbkuNRDg60tLglU6
         CJMExSrp6+yMTcJCfXnCX2MMczr28l+AnpcHg=
Received: by 10.216.143.74 with SMTP id k52mr4137913wej.0.1307902819300;
        Sun, 12 Jun 2011 11:20:19 -0700 (PDT)
Received: from bender.localnet (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id o75sm2482938weq.40.2011.06.12.11.20.17
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 11:20:18 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Converting MIPS to Device Tree
Date:   Sun, 12 Jun 2011 20:20:15 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-9-generic; KDE/4.6.2; x86_64; ; )
Cc:     David VomLehn <dvomlehn@cisco.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        "Dezhong Diao (dediao)" <dediao@cisco.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20110606010753.GA16202@linux-mips.org> <20110607230218.GA23552@dvomlehn-lnx2.corp.sa.net> <BANLkTikjgj-QH=8u6NeGbWHy5hi1jiiU6Q@mail.gmail.com>
In-Reply-To: <BANLkTikjgj-QH=8u6NeGbWHy5hi1jiiU6Q@mail.gmail.com>
Organization: OpenWrt
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201106122020.15609.florian@openwrt.org>
X-archive-position: 30354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10205

On Wednesday 08 June 2011 09:15:14 Geert Uytterhoeven wrote:
> On Wed, Jun 8, 2011 at 01:02, David VomLehn <dvomlehn@cisco.com> wrote:
> > I took a look at the issue of passing device trees to the kernel and
> > started by surveying the methods currently in use for passing
> > information from the bootloader to the kernel. I came up with the ten
> > approaches:
> > 
> > How MIPS Bootloaders Pass Information to the Kernel
> > ---------------------------------------------------
> > Apologies for any errors; this was meant more to be a quick survey
> > rather than a detailed analysis.
> > 
> > 6.      a0 - argc
> >        a1 - argv
> >        a2 - non-standard envp
> >        Command line created by concatenating argv strings, starting at
> >        argv[1]. The envp is a pointer to a list of char ptr to name/char
> >        ptr pairs.
> >        Platforms: txx9
> 
> This depends on the actual boot loader. My rbtx4927 has a VxWorks boot
> loader, which just doesn't pass anything.
> 
> Cfr. commit 97b0511ce125b0cb95d73b198c1bdbb3cebc4de2 ("MIPS: TXx9:
> Make firmware parameter passing more robust").

Thinking about this more, on platforms for which we do not have control about 
the bootloader, we can usually still get it to boot a wrapper. Such a wrapper 
could do the following:

- embedd the kernel
- embedd the appropriate dtb
- copy the relevant a0-a3 values and pass to the kernel a pointer to the valid 
dtb in the aX register

such a wrapper already exists, which is the code responsible for decompressing 
the kernel in arch/mips/boot/compressed.

If we want to support multiple flavors of the same SoC, using the same kernel 
image, we only need to relink the boot wrapper with the correct dtb (and 
kernel of course).
--
Florian
