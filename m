Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Feb 2006 00:10:38 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.207]:42596 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133626AbWBVAK2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Feb 2006 00:10:28 +0000
Received: by nproxy.gmail.com with SMTP id n29so844999nfc
        for <linux-mips@linux-mips.org>; Tue, 21 Feb 2006 16:17:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qYV4cXeVXGFnY0cnVqS5c0fASD360D2jKSoDkf4XX7MKtDb4zS3m/q58vRUi3drZepNcBT6t27SZibilWHneACERgcg4JptI6Vf1aDXrqOrn4kQoLJ5WiGi6YLpiAqpK/9r7Tk77JjatYy+4DBY4brS4txh/ftbxcFlCez5nRmM=
Received: by 10.48.244.12 with SMTP id r12mr1643574nfh;
        Tue, 21 Feb 2006 16:17:28 -0800 (PST)
Received: by 10.48.250.13 with HTTP; Tue, 21 Feb 2006 16:17:28 -0800 (PST)
Message-ID: <50c9a2250602211617s1dd9a95ek7dfe983a1cbddb67@mail.gmail.com>
Date:	Wed, 22 Feb 2006 08:17:28 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: "Hw. address read/write mismap 0" or RTL8019 ethernet in linux
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <1140522258.840.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250602202133g2e7350aesdaf1df810c90cef8@mail.gmail.com>
	 <1140522258.840.16.camel@localhost.localdomain>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/21/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2006-02-21 at 13:33 +0800, zhuzhenhua wrote:
> > then i check the code and find it's in 8390.c, caused by uncorrect
> > write of MAC addr, and now i repalce all the inb,outb,inb_p, outb_p
> > with get_reg and put_reg in the 8390.c.as follow:
> >
> > static unsigned char get_reg (unsigned int regno)
> > {
> >       return (*(volatile unsigned char *) regno);
> > }
> >
> > static void put_reg (unsigned int regno, unsigned char val)
> > {
> >       *(volatile unsigned char *) regno = val;
> > }
>
> Should be
>
>         return readb(regno);
>
> and
>
>         writeb(val, regno)
>
> if regno holds the ioremap result of the memory mapped address of the
> 8019. Right now 8390.c assumes PIO mappings and you hardware appears to
> be MMIO ?
>
> > does someone have any idea of this situation?
>
> If the card is MMIO then make sure you are using readb/writeb and
> ioremap properly, otherwise you may get cache consistency and other
> strange errors.
>
>

now i resolve the "Hw. address read/write mismap 0' by
set_io_port_base(0) in my board setup function. and nfs rootfs can
mounted and can copy/delete, also can run the helloworld app in nfs
rootfs, but if i run some big application or something like vi, it
will still get
"nfs: server 192.168.81.142 not responding, still trying"

what may cause this message? ethernet driver? or kernel uncorrect config?

thanks for any hints

Best Regards

zhuzhenhua
