Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Jun 2010 19:57:59 +0200 (CEST)
Received: from mail-ww0-f49.google.com ([74.125.82.49]:47452 "EHLO
        mail-ww0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491992Ab0FTR5z convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 20 Jun 2010 19:57:55 +0200
Received: by wwb13 with SMTP id 13so2199234wwb.36
        for <multiple recipients>; Sun, 20 Jun 2010 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=DfrDkotriH1F2dRynk9/IX/bCeGOiSK4TUmUk1o+NTY=;
        b=Veouf4Bfq3XisBSsLpX0U8chyxLnreR5mRLcMgW654cjWzOscBkQ/TZoqBcfBRFvP+
         iD0yPL7ygOscx9Dmnn7WFJTfOryN2uPT7OPzZMxn2yR/1leyUHgMnLNsAsatZZdpppVp
         ojzKd6+1agHrlvCkIpsZ3v+EGQoSd9K+uisec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=KzTlGTS5qRYUEAS407kjtmxeDjKvHGoEbhB13LFkucU47zHRsKSfHnG6PnOikH2V6d
         4Zg22g6cOs/O+h4c0FcrC0CgeAEPM7LnOEvbYYzq8/b8CGa5fcLhYV8HerIDVxvD8dLu
         4H21/eWg+SmaMij/qJix3kAtxrSgBt0V4nZA8=
Received: by 10.227.157.81 with SMTP id a17mr3695024wbx.146.1277056669237;
        Sun, 20 Jun 2010 10:57:49 -0700 (PDT)
Received: from lenovo.localnet (63.59.76-86.rev.gaoland.net [86.76.59.63])
        by mx.google.com with ESMTPS id n31sm14170001wba.3.2010.06.20.10.57.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Jun 2010 10:57:48 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH v2 00/26] Add support for the Ingenic JZ4740 System-on-a-Chip
Date:   Sun, 20 Jun 2010 19:57:54 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.34-1-amd64; KDE/4.4.4; x86_64; ; )
Cc:     "Lars-Peter Clausen" <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Graham Gower <graham.gower@gmail.com>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de> <4C1E467D.5030204@metafoo.de> <20100620170111.GA8650@alpha.franken.de>
In-Reply-To: <20100620170111.GA8650@alpha.franken.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <201006201957.56978.florian@openwrt.org>
X-archive-position: 27234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13832

Hi,

Le Sunday 20 June 2010 19:01:11, Thomas Bogendoerfer a écrit :
> On Sun, Jun 20, 2010 at 06:49:01PM +0200, Lars-Peter Clausen wrote:
> > different to JZ4750 and JZ4760. So JZ47xx wont fit either.
> > Right now there is no practical use to moving things around, and there
> > wont be until somebody who can actually test it starts adding support
> > for a different JZ47XX SoC.
> 
> great, I like such attitude:-(

I have to agree with Thomas here, if your concern is about the naming, then 
just have a look at the vendor sources and find similarities for what is worth 
being named JZ47XX and what deserves a name which is more specific. Also, it is 
much easier to do that factoring job now instead of when there will be 3 or 
more flavors of that SoC to be supported.

Take a look at BCM63xx for instance, it is named like that because it supports 
4 different versions of the family SoC, even though the internals of the SoC 
have been varying a lot, still we support it with a single kernel and what is 
really family specific is named accordingly from what is chip-specific.
--
Florian
