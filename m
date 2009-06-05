Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2009 14:52:41 +0100 (WEST)
Received: from mail-bw0-f225.google.com ([209.85.218.225]:56190 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023038AbZFENwe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Jun 2009 14:52:34 +0100
Received: by bwz25 with SMTP id 25so1568499bwz.0
        for <multiple recipients>; Fri, 05 Jun 2009 06:52:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LyKFzGUU+0rsOA6bIBM5ao4YxE3vP1JYN3mvNSEaEQ4=;
        b=JcnblBzhRxripwX4RS0T9FKdDYPTi23qFAiE7cT322Vc5IR16rfga4BfEmZDcdgZ3N
         IqiVuSqacDJ+tt8HAPo1VhTS+WBQxmee8x+6E43QPBZjr0kTxcxGD904BoQ1QQ8NsXUS
         4lumglpynqZba4BrbrqNvfV6nF+N7ReQDSf5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=lmI8B442PHd4EMnKfDCNz7n3ULnJqwhv7k7EMsdZLXoJXyrYzzRk85Cc0jGLmgIDxI
         XlOmFHgYXo8Ta/n+WcYuc7MrvMCU+JBis9KOxuNe6LrbFfs9mqEzzHN2yVKyl9z6T1mL
         diFF/1HJ0gKKlUae11kPB/GTnXTmrFUrvN4Tg=
Received: by 10.204.100.10 with SMTP id w10mr3187011bkn.211.1244209948087;
        Fri, 05 Jun 2009 06:52:28 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 28sm12909446fkx.54.2009.06.05.06.52.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 06:52:27 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 8/8] 8250: add Texas Instruments AR7 internal UART
Date:	Fri, 5 Jun 2009 15:52:24 +0200
User-Agent: KMail/1.9.9
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-serial@vger.kernel.org
References: <200906041622.47591.florian@openwrt.org> <20090604222020.GA14843@alpha.franken.de>
In-Reply-To: <20090604222020.GA14843@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906051552.25529.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hallo Thomas,

Le Friday 05 June 2009 00:20:20 Thomas Bogendoerfer, vous avez écrit :
> On Thu, Jun 04, 2009 at 04:22:46PM +0200, Florian Fainelli wrote:
> > We discussed that in private, there are a couple of things
> > to fix in order to get 8250 working properly with TI AR7 HW.
> > If you can still merge that bit, this would ease future work, thanks !
>
> I still have a tree here, which works without any changes to the 8250
> serial driver on a TNETD7300 device.

That specific patch just adds an AR7 port to the 8250 uart driver. My 
TNETD7300 really needs patching in the 8250 driver to work properly, Alan 
already suggested to perform some testing. I still think there is a HW bug 
with different silicon revisions.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
