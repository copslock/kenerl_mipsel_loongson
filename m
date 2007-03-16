Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2007 05:09:48 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.185]:58283 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021574AbXCPFJo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Mar 2007 05:09:44 +0000
Received: by nf-out-0910.google.com with SMTP id l24so111062nfc
        for <linux-mips@linux-mips.org>; Thu, 15 Mar 2007 22:08:43 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c7C8AOi8RCG4HPKAxw6TyMhId6dnT8tFcLFRppN4Yg2eqAVxWMp8/uMfUUXzn5Jbdv4qhhWpOGnMgrmQDrMXgn5a1ZZLzJr9C0ns01yG+apG2pd7K2Sg+AqnZrQ+/Xd0XhOXp248GhTT59ut50LkBljn/vPGLKTLZDWTqGK0924=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KEmNfRKShizYUqCpiyunGxc2Ggh2zgf11XnRPD9VFHOUOdVXpgAzKlC5B1AZC+FHle009UGwQWRC7ElczawSQb3XfEuVtyXUbLJVJhZ4vngzyNRj5LU1ACKhqPFpATxAYrlDQ3OSaWlrCAIsNFtNU4YtmHB72fCYtRt8nfsLBlU=
Received: by 10.82.114.3 with SMTP id m3mr2322432buc.1174021723283;
        Thu, 15 Mar 2007 22:08:43 -0700 (PDT)
Received: by 10.82.178.13 with HTTP; Thu, 15 Mar 2007 22:08:43 -0700 (PDT)
Message-ID: <b115cb5f0703152208p45f63d9ah63ba527970b943bc@mail.gmail.com>
Date:	Fri, 16 Mar 2007 10:38:43 +0530
From:	"Rajat Jain" <rajat.noida.india@gmail.com>
To:	"Thiemo Seufer" <ths@networkno.de>
Subject: Re: How does boot loader pass initrd address / size to kernel?
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070315134306.GB25863@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b115cb5f0703150143y46a1f877m9dbb43345721c355@mail.gmail.com>
	 <20070315133950.GA25863@networkno.de>
	 <20070315134306.GB25863@networkno.de>
Return-Path: <rajat.noida.india@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rajat.noida.india@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/15/07, Thiemo Seufer <ths@networkno.de> wrote:
> Thiemo Seufer wrote:
> > Rajat Jain wrote:
> > > Hi,
> > >
> > > I'm running an ancient Linux kernel 2.4.20 (please don't ask me why
> > > :-( ) on a MIPS 4KEC. I am experimenting with initrd and my initrd
> > > fails to mount. My bootloader (U-BOOT) coorectly loads the initrd into
> > > RAM as I can see.
> > >
> > > I am wondering how does the kernel get to know the address at which
> > > the initrd is loaded by boot loader? How does the boot loader
> > > communicate this to the kernel?
> > >
> > > I can see that when emebedding root filesystem into kernel image, the
> > > symbols __rd_start and __rd_end are defined by the linker script and
> > > hence the kernel gets to know. However, how does this happen when
> > > bootloader loads the ramdisk and needs to tell the kernel?
> >
> > http://www.linux-mips.org/wiki/Kernel_Command_Line_Arguments mentions
> > rd_start and rd_size which are used for this purpose.

Ah thanks a lot ... this is what I was looking for.

Rajat
