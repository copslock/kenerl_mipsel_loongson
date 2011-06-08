Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jun 2011 12:06:13 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:49049 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491050Ab1FHKGI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jun 2011 12:06:08 +0200
Received: by wwb17 with SMTP id 17so295017wwb.24
        for <multiple recipients>; Wed, 08 Jun 2011 03:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=60GUw7n+z1w5ETNClsllSqCLXPU9TRvw/XHSaIwJZGU=;
        b=B4jA9dEuruAuyAgqnwJKru7srkAgX2m5nAb+0qnoayCgOPKnCJbngl/iQQE3rU52kX
         vqdMj5p4jO/6F654XY97yrZ0/IT3MR8dM3vucC3N4gg6dRj0wjvymA9QKzsaLc9nbYE2
         xQAcN+wdhjtjPYQPuvZkkfG8k2FH10PzzL7BY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=eEqn7iSOBkncjGi/JUwbcKVlDWHK55x1O1IsPhgaWYANw1Wbz9ZYxtj9Hae09HNyjz
         0UGs27kGq8TK3ZMlmyAzKnrYz+gTJerqH2VodkclH27vSXMTFAF84tWA9RRog8dGlEnR
         MlPaObpwZv0oqinHVTkyYtLam9BZGMMK2tpVs=
Received: by 10.216.142.133 with SMTP id i5mr7250030wej.43.1307527563266;
        Wed, 08 Jun 2011 03:06:03 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id n20sm179690weq.39.2011.06.08.03.06.01
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 03:06:02 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Converting MIPS to Device Tree
Date:   Wed, 8 Jun 2011 12:10:22 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
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
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201106081210.22284.florian@openwrt.org>
X-archive-position: 30294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6667

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

Actually most devices out there OpenWrt is dealing with are in this situation. 
Most of the time because the boot loader was highly hacked and/or locked down.

In the best cases we can get the bootloader to pass a valid command-line to 
the kernel.
--
Florian
