Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Sep 2004 08:56:51 +0100 (BST)
Received: from verein.lst.de ([IPv6:::ffff:213.95.11.210]:19679 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8224953AbUIJH4r>;
	Fri, 10 Sep 2004 08:56:47 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id i8A7uj95027633
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 10 Sep 2004 09:56:45 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id i8A7uiEV027631;
	Fri, 10 Sep 2004 09:56:44 +0200
Date: Fri, 10 Sep 2004 09:56:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Peter Buckingham <peter@pantasys.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] make the bcm1250 work
Message-ID: <20040910075644.GA27574@lst.de>
References: <4140C205.7020405@pantasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4140C205.7020405@pantasys.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

>  #ifdef CONFIG_EMBEDDED_RAMDISK
>  /* These are symbols defined by the ramdisk linker script */
> +extern unsigned long initrd_start, initrd_end;
>  extern unsigned char __rd_start;
>  extern unsigned char __rd_end;

Please use the appropinquate header for these.

> +#ifdef CONFIG_BLK_DEV_INITRD
> +extern unsigned long initrd_start, initrd_end;
> +extern void * __rd_start, * __rd_end;
> +#endif

dito.
