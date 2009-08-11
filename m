Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Aug 2009 23:20:12 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:54832 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492954AbZHKVUG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Aug 2009 23:20:06 +0200
Received: by ewy12 with SMTP id 12so4864385ewy.0
        for <linux-mips@linux-mips.org>; Tue, 11 Aug 2009 14:20:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LnQ/YSiC0XwTd4ZH/UqwjTqmaNoRbhTzk2abTlxZ+EI=;
        b=otaT7dha4cfXt7OVLJzh7bEP2ddKP2EF5FnUOUtEcExQwWs0rauFwqGSDYXbEiFF20
         sAcFtqmZabBXxhEKLJbJmVxkuSxJhc/Ek9FgXVQTUexoacR3OPePISx1vmsxVsw38f67
         q+rmV9XdKmVtLkNZc+qUD36bcJxkAKycUt/WU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=J88UcqHYh50H2K+IayVyw7zbeXBwkNpvXRx7oEtmoXa0hrLS80BwjcRGj/wDNM15z+
         qcfx3uRKyC7ErhAPGt/BjPK1KexIMSsz14KxzDOMc8jXSFSRP+9kg9OtL8EM9pD8oefj
         blUMGRVe3TGfqSTY0uXkh/znNoSFbrOpZVGwY=
Received: by 10.211.194.4 with SMTP id w4mr1487243ebp.41.1250025601264;
        Tue, 11 Aug 2009 14:20:01 -0700 (PDT)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id 28sm943217eye.34.2009.08.11.14.20.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 14:20:00 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Alexander Clouter <alex@digriz.org.uk>
Subject: Re: AR7 runtime identification [was:- Re: [PATCH -v1] MIPS: add support for gzip/bzip2/lzma compressed kernel images]
Date:	Tue, 11 Aug 2009 23:19:56 +0200
User-Agent: KMail/1.9.9
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org
References: <1249894154-10982-1-git-send-email-wuzhangjin@gmail.com> <20090810101205.GW19816@chipmunk> <200908102342.30031.florian@openwrt.org>
In-Reply-To: <200908102342.30031.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200908112319.58367.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Monday 10 August 2009 23:42:27 Florian Fainelli, vous avez écrit :
> Hi Alexander,
>
> Le Monday 10 August 2009 12:12:05 Alexander Clouter, vous avez écrit :
> > * Florian Fainelli <florian@openwrt.org> [2009-08-10 12:06:07+0200]:
> > > Hi Alexander,
> > >
> > > Le Monday 10 August 2009 11:03:15 Alexander Clouter, vous avez écrit :
> > > > I notice in arch/mips/ar7/prom.c the while loop hangs on
> > > > "(serial_in(UART_LSR) & UART_LSR_TEMT)" instead, is this because of
> > > > the buggy UART's seen in some revisions of the AR7?  As it stands
> > > > Wu's putc() implementation works fine for me but I'm guessing it is
> > > > because the UART has not much opportunity for over/underruns as not
> > > > much is being sent.
> > >
> > > Even with the silicon bug, this should not be a problem as long as you
> > > keep polling the LSR_TEMT bit in the LSR register. The problem appears
> > > when running the UART with interrupts.
> >
> > Ahhhh, that makes sense.  I'll leave Wu's code alone :)
> >
> > > > The UART on my board is buggy (missing/repeated characters like many
> > > > others seem to get) to, but I remember seeing somewhere (in a chat
> > > > you had years ago with Alan Cox if I remember correctly) the UART is
> > > > not buggy on *all* AR7 based boards?  Is is possible to detect a
> > > > buggy UART at runtime (maybe via a AR7 revision match test)?
> > >
> > > Alan Cox suggested to perform some tests which I did not carry out yet.
> > > By using two different hardware revisions in two different routers I
> > > noticed that the silicon bug is present in TNETD7300GDU revision 4,
> > > while revision 5 does not have it.
> > >
> > > The revision id can certainly help differentiating between the silicon
> > > version, later tonight when I have access to the hardware I will
> > > compare between a WAG54G and a C54APRx. I remember being them different
> > > for theTNETD7300GDU rev 4 and the rev 5.
> >
> > Well, I was offering that I could add an extra datapoint if need be.
> > There must be a way to fix up the UART without adding a 'new' UART type,
> > in a clean way.  I'll have a look into it tonight, but I imagine you
> > have looked at this in far more detail than I could...but hey, it gives
> > me something to do tonight[1]. :)
>
> For your information, the TNETD7300GDU is detected like this:
> TI AR7 (TNETD7300), ID: 0x0005, Revision: 0x02
>
> and the TNETD7300EZDW (ADSL 2+) is detected like this:
> TI AR7 (TNETD7200), ID: 0x002b, Revision: 0x10 which also has the UART bug
> and is wrongly detected as a TNETD7200.
>
> I have left the WAG54G at work and will get my hands back on it tomorow.

The bad news is that my WAG54G v2 which is also a TNEDT7300GDU has this HW bug 
too rendering the runtime detection of the bug more difficult.
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
