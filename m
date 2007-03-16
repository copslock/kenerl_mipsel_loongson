Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2007 05:13:35 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.190]:48574 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021585AbXCPFNb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Mar 2007 05:13:31 +0000
Received: by nf-out-0910.google.com with SMTP id l24so111774nfc
        for <linux-mips@linux-mips.org>; Thu, 15 Mar 2007 22:12:30 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kfnUQk9BzgxG2cu/VVcdMYuZYY4i3Wp0QpRthfQ4Tb1a6tmp4rkfm926JWn2otPJi4Z1DvTmwoLgl2CyadU0TLb1oi9ORsBcuGml5nOtOgSktW/0DXAW/Ze68ml3rXQ16oNn2xOV75LeCeCvsfuGWmaoJqMGg5TJkhiQCRSjDug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VW9J4LY8ephpZYg1DHaqJfpynmd7rIKNZg2b6xd+6XR1W5guxU4c5k9Lrgxg/SKmkQpvbJnyA2KVwLUupD7+ROYQghqgYyYLi30AixXwaq7DvWiNnTYfg2jw9xSmDgdEj7payAuMFX7H+J2rKrc54iZRbA6//cfgHckXwZ6nPUI=
Received: by 10.82.167.5 with SMTP id p5mr2271460bue.1174021950585;
        Thu, 15 Mar 2007 22:12:30 -0700 (PDT)
Received: by 10.82.178.13 with HTTP; Thu, 15 Mar 2007 22:12:30 -0700 (PDT)
Message-ID: <b115cb5f0703152212y2e7bd01chf1e7fa7bf8d2f08c@mail.gmail.com>
Date:	Fri, 16 Mar 2007 10:42:30 +0530
From:	"Rajat Jain" <rajat.noida.india@gmail.com>
To:	"Thierry Reding" <thierry@gilfi.de>,
	"Thiemo Seufer" <ths@networkno.de>
Subject: Re: How does boot loader tell the kernel, the location of initrd?
Cc:	kernelnewbies@nl.linux.org, newbie <linux-newbie@vger.kernel.org>,
	linux-mips@linux-mips.org
In-Reply-To: <20070315161718.GB16545@ba.sec>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b115cb5f0703142358j6a422262qe1ad1c6cfcfcdd22@mail.gmail.com>
	 <20070315161718.GB16545@ba.sec>
Return-Path: <rajat.noida.india@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rajat.noida.india@gmail.com
Precedence: bulk
X-list: linux-mips

> > I am experimenting with initrd and my initrd fails to mount. My
> > bootloader (U-BOOT) coorectly loads the initrd into RAM as I can see.
> >
> > I am wondering how does the kernel get to know the address at which
> > the initrd is loaded by boot loader? How does the boot loader
> > communicate this to the kernel?
> >
> > Any code references will be appreciated.
>
> Perhaps lib_mips/mips_linux.c in the U-Boot tree is what you are looking for.
> That code sets up environment parameters that are parsed by the Linux kernel
> later on (see rd_start_early() and friends in arch/mips/kernel/setup.c in the
> Linux tree).

Thanks! That is exactly what I was looking for. However, I noticed
that U-BOOT passes these parameters in environment variables, where as
Linux kernel expects them as command l ine arguments. It wasn't
working for me untill I made changes in U-BOOT to pass them in command
line arguments.

Why is this discrepancy in U-BOOT and the kernel? Are other people
working on the (linux+U-BOOT) combo making the changes that I did?

Thanks,,

Rajat
