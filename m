Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 18:13:13 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:32149 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20029821AbXIZRNF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 18:13:05 +0100
Received: by nf-out-0910.google.com with SMTP id c10so1712145nfd
        for <linux-mips@linux-mips.org>; Wed, 26 Sep 2007 10:12:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=oIA4RpezcjjYispZdqOk9MOoCsAox347tWWZhHbpX+g=;
        b=SatBG0uJpZnR8xs8SLUIqpaD11To46PkGfoV6RXOaGDo/Pc+MrWbKifMHIjgxI8e9YWwQPtRP2boeIVDhYCV4bBb33Ifny9XBiOwBqXA94WJThOT4v3NsXqpeiybymIHpjSCMbf6uXq4N56aex+KAIXNXhbX6fsopC/oeOruPhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=upd78bJQac64K7YOwRE/vE0oTHfZTWx/Il6kGBedSbd1YJCNkieNnOC4rMSYLK9w89duA6+v9Zzvx53Zei9LX9/yLmIEwVYTKTkna+7qScsyaWhgU/R/1XwJ4Qq/8MLsi9ZmwQq0Mm+QL4+IDZySgFF4MHp0kd2o2KMYOY/+sdY=
Received: by 10.78.107.8 with SMTP id f8mr896058huc.1190826767093;
        Wed, 26 Sep 2007 10:12:47 -0700 (PDT)
Received: by 10.78.121.3 with HTTP; Wed, 26 Sep 2007 10:12:41 -0700 (PDT)
Message-ID: <f43fc5580709261012l6ba9defew11623efa418bbe2b@mail.gmail.com>
Date:	Wed, 26 Sep 2007 20:12:41 +0300
From:	"Blue Swirl" <blauwirbel@gmail.com>
To:	"Alexander Voropay" <alec@nwpi.ru>, qemu-devel@nongnu.org,
	openbios@openbios.org
Subject: Re: [Qemu-devel] Qemu and Linux 2.4
Cc:	"Thiemo Seufer" <ths@networkno.de>, linux-mips@linux-mips.org,
	vlad@comsys.ro
In-Reply-To: <029001c80059$d7a14960$e90d11ac@spb.in.rosprint.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <46E68AA3.2010907@comsys.ro> <20070911125421.GE10713@networkno.de>
	 <46E69AAF.2090509@comsys.ro>
	 <029001c80059$d7a14960$e90d11ac@spb.in.rosprint.ru>
Return-Path: <blauwirbel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blauwirbel@gmail.com
Precedence: bulk
X-list: linux-mips

On 9/26/07, Alexander Voropay <alec@nwpi.ru> wrote:
> <vlad@comsys.ro> wrote:
>
> >>> - QEMU malta emulation is not really complete, to put it mildly
> >> Out of curiosity, what parts did you miss?
> > Like, for example, the PCI stuff. So I can use the network card.
>
>  PCI stuff in the QEMU/Malta works fine, but pseudo-bootrom
> does not perform PCI enumeration and leaves uninitialized PCI BARs.
>
>  Linux MIPS/Malta 2.4 can not perform PCI enumeration too.  The LANCE
> Ethernet driver *requres* a pre-initialized BARs. The situation even worse,
> since current Linux 2.4 can't be even built with NEW_PCI and PCI_AUTO
> options at all (due to linkage error).
>
> http://www.linux-mips.org/wiki/PCI_Subsystem
>
>  There is the same PCI problem with NetBSD/evbmips and seems VxWorks/Malta.
>
> > And yes, I am aware of YAMON.
>
>  AFAIK, YAMON may runs on the MIPS hardware only, and may not
> be redistribuded in the source or binary form.
>
>  Anyway, YAMON binary does not work on the Qemu/Malta. The Galileo
> chip is far more complicated then Qemu emulation. It contains four DMA
> channels, four timers e.t.c. e.t.c.
>
> >> I recommend to improve the Qemu Malta emulation, and make it work with
> >> 2.4 Malta kernels. (ISTR it used to work, so it shouldn't need a lot to
> >> get there.)
> >
> > I'm sure that improving the Qemu Malta emulation is a very noble goal,
> > but for people that need a working 2.4 kernel NOW, my patch could be
> > useful. Having the QEMU target in 2.6 surely helped me.
>
>  The only thing we need is a good bootrom (BIOS) for the MIPS/Malta
> (Free-YAMON ;)

Someone could port OpenBIOS or LinuxBIOS to MIPS.
