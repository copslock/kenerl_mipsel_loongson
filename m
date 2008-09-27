Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Sep 2008 18:29:45 +0100 (BST)
Received: from mu-out-0910.google.com ([209.85.134.191]:51722 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20128655AbYI0R26 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Sep 2008 18:28:58 +0100
Received: by mu-out-0910.google.com with SMTP id w9so1196757mue.4
        for <linux-mips@linux-mips.org>; Sat, 27 Sep 2008 10:28:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:message-id:content-type
         :content-transfer-encoding;
        bh=vAAnaxS/ksREG1rmTe+0L55t3vy/0zi4ohTpgG8QAzo=;
        b=PTOSKyGjO6wV91sy7lHHfR6TZCujttAygdFmHvfy6N5lbDtqT0gJD1BUGoyh1xC9HW
         6O4hpCgZA94T6GDubYH+3v/+V2fMHwqhaX66+A0/ivEsxQJ68qGr3W+KFZw43veicW1h
         DT4PjGa/PfV6+skm3sPyiheq2lDEY3Tr7epB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:message-id:content-type
         :content-transfer-encoding;
        b=PT++2j+WQUWl1eIPeNMgt4V8GoUH+od05bMeu824L3FPg/Pc9dbKDhhfNDBrKqxuek
         cFv4Kn60CRRbeHlacj/vKpepP3jWW8OGled6ybQ3Rp+Ap4t6sU6Eef12opfSqwAB3xdQ
         jEnvkX6sQX1v8kti6Ew62pvdNON0CeADwUmTY=
Received: by 10.103.243.7 with SMTP id v7mr2089095mur.24.1222536538515;
        Sat, 27 Sep 2008 10:28:58 -0700 (PDT)
Received: from ?192.168.123.7? (chello089077041080.chello.pl [89.77.41.80])
        by mx.google.com with ESMTPS id y37sm561478mug.13.2008.09.27.10.28.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Sep 2008 10:28:57 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] IDE: Fix platform device registration in Swarm IDE driver
Date:	Sat, 27 Sep 2008 18:59:55 +0200
User-Agent: KMail/1.9.10
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-ide@vger.kernel.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com>
In-Reply-To: <48DA1F9D.6000501@ru.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200809271859.55304.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips


On Wednesday 24 September 2008, Sergei Shtylyov wrote:

[...]

> > @@ -70,41 +59,18 @@ static const struct ide_port_info swarm_
> >   * swarm_ide_probe - if the board header indicates the existence of
> >   * Generic Bus IDE, allocate a HWIF for it.
> >   */
> > -static int __devinit swarm_ide_probe(struct device *dev)
> > +static int __devinit swarm_ide_probe(struct platform_device *pdev)
> >  {
> >  	u8 __iomem *base;
> >  	struct ide_host *host;
> >  	phys_t offset, size;
> > +	struct resource *r;
> >  	int i, rc;
> >  	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
> >  
> > -	if (!SIBYTE_HAVE_IDE)
> > -		return -ENODEV;
> > -
> > -	base = ioremap(A_IO_EXT_BASE, 0x800);
> > -	offset = __raw_readq(base + R_IO_EXT_REG(R_IO_EXT_START_ADDR, IDE_CS));
> > -	size = __raw_readq(base + R_IO_EXT_REG(R_IO_EXT_MULT_SIZE, IDE_CS));
> > -	iounmap(base);
> > -
> > -	offset = G_IO_START_ADDR(offset) << S_IO_ADDRBASE;
> > -	size = (G_IO_MULT_SIZE(size) + 1) << S_IO_REGSIZE;
> > -	if (offset < A_PHYS_GENBUS || offset >= A_PHYS_GENBUS_END) {
> > -		printk(KERN_INFO DRV_NAME
> > -		       ": IDE interface at GenBus disabled\n");
> > -		return -EBUSY;
> > -	}
> > -
> > -	printk(KERN_INFO DRV_NAME ": IDE interface at GenBus slot %i\n",
> > -	       IDE_CS);
> > -
> > -	swarm_ide_resource.start = offset;
> > -	swarm_ide_resource.end = offset + size - 1;
> > -	if (request_resource(&iomem_resource, &swarm_ide_resource)) {
> >   
> 
>    Why drop request_resource() completely? Replace it by 
> request_mem_region().

Yes, this needs fixing (otherwise everything looks good).

Ralf: I guess that your next step will be dropping swarm-specific platform ide
driver in favor of generic one (please see drivers/ide/legacy/ide_platform.c)
as they are _very_ similar now? :)

Thanks,
Bart
