Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 17:04:56 +0100 (WEST)
Received: from mail-px0-f186.google.com ([209.85.216.186]:50126 "EHLO
	mail-px0-f186.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022524AbZFDQEu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 17:04:50 +0100
Received: by pxi16 with SMTP id 16so890534pxi.22
        for <multiple recipients>; Thu, 04 Jun 2009 09:04:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=jYOtBrk2gPliAwvR+fY8FhIQWjR97QtUPLkMyCKNgmk=;
        b=Hn7wWaos+NXtceKeAWCQHHf7qS/rs5KlIMOCx+NkPt+5osai18A8WsvFxofPjPXKES
         aAGn68BirWOshKN3B0BWpVggRpDLR/O2kXJ1UGqaVueUGes1rifnB5R18Kaf4k3RaAzy
         suD8HCpwkXc9EJOvOnhG2bFZYhb7yhYju6UZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=dF/dAak6Xc0ReytuLGckWDe/tovfMMCkbj81qG2zvkdn+C0tt2ZPn9Z5ktvh7KXKM5
         vWQ4V4dRQ+SkCTyLWUnz0RPxtnNhFiea2tXniH6HWCWUhO0/pSCjNVDlfvSVNdBPTzfR
         u2Eh7CAUihMW9KZYftH53f3sTbRkHdnhN6Rd8=
Received: by 10.114.60.7 with SMTP id i7mr355006waa.6.1244131481698;
        Thu, 04 Jun 2009 09:04:41 -0700 (PDT)
Received: from ?192.168.2.239? ([202.201.14.140])
        by mx.google.com with ESMTPS id k37sm2894008waf.42.2009.06.04.09.04.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 09:04:41 -0700 (PDT)
Subject: Re: [loongson-PATCH-v3 17/25] add a machtype kernel command line
 argument
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Arnaud Patard <apatard@mandriva.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <m3iqjcm7jd.fsf@anduin.mandriva.com>
References: <cover.1244120575.git.wuzj@lemote.com>
	 <d1f4caa360114f843459dc71827b1175232a24be.1244120575.git.wuzj@lemote.com>
	 <m3iqjcm7jd.fsf@anduin.mandriva.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Fri, 05 Jun 2009 00:04:33 +0800
Message-Id: <1244131473.32116.17.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-06-04 at 15:51 +0200, Arnaud Patard wrote:
> wuzhangjin@gmail.com writes:
> 
> Hi,
> 
> > From: Wu Zhangjin <wuzj@lemote.com>
> >
> > the difference between yeeloong-7inch and yeeloong-8.9inch is very
> > small, only including the screen size and shutdown logic. so, it's very
> > important to share the same kernel image file between them instead of
> > adding some new kernel config options. benefit from this, the
> > distribution developers only have a need to compile the kernel one time.
> >
> > to share the same kernel image file between yeelooong-7inch and
> > yeeloong-8.9inch, there is a need to add a kernel command line, here I
> > name is machtype, it works like this:
> >
> > 	machtype=lemote-yeeloong-2f-7inch
> > 	      company - product - cpu revision - size
> 
> I'm curious. Why can't you use the boot monitor to pass the right
> machine type instead ? iirc, you're using pmon and pmon has a variable
> called "systype". If the systype variable is not designed for that, I'll
> be happy to know its use :)
> 

yes, I just checked the PMON variables, there is "systype" there, but
seems can not be set(when reboot, will become the original one), maybe
hard-coded in PMON? so i added another PMON variable: machtype, and
added some source code: if there is a PMON machtype variable there,
transfer it to a kernel command line.

but i think using a kernel command line is better, because we can either
set it as the karg variable in PMON or pass it in the boot.cfg, which is
more flexible and in-dependent from the bootloader.

and perhaps, someday, we can share the same kernel image file between
fuloong2f box and yeeloong2f laptop via this kernel command line:
machtype, because there is really only a few difference between
them(only the reboot/shutdown logic, serial port). I really want to
share them and remove one of the irq.c file :-)

thanks!
Wu Zhangjin

> 
> Arnaud
