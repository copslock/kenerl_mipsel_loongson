Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 16:29:10 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:61453 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492922AbZKYP3G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2009 16:29:06 +0100
Received: by pwi15 with SMTP id 15so5169689pwi.24
        for <multiple recipients>; Wed, 25 Nov 2009 07:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=1/IJgrBZ/mLZfyA0j/Vgv2Cak4jss/GUYKmz4KIxvuY=;
        b=LDFlFs4mupK/g8ZtyUczm1yfq+i1VkBC5OwijYx0dqArFNlTLU0vOet9RJT3J4RXEr
         bK72eXX2QzmKbOnmLy1a0YeZI2Z4VAZ1Tg8W8esuVnTGcuBsiVZ0W0KjIm27pUUhnpvY
         xXLtHRBLetdzpS8z72as3nsx8S6xmjkZIknkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=co1VXk48tbIfU+rJr+EGnWwXmqRjw4XCXlY4fl7XjzR82NQOEtDfWIDnuieang+Vpa
         IB1VIZX9rMD2iSjNz+Huc7tvleBWMLeD0zOHWJ87zFcj3fFosjNj3XgWIOK1nQjL1RDx
         3XuF3qiSP7gId9KevGWwd1QWvrzR5pXljdGiM=
Received: by 10.115.81.24 with SMTP id i24mr4556359wal.194.1259162938949;
        Wed, 25 Nov 2009 07:28:58 -0800 (PST)
Received: from ?192.168.1.100? ([118.132.131.118])
        by mx.google.com with ESMTPS id 20sm3858633pxi.3.2009.11.25.07.28.55
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 07:28:57 -0800 (PST)
Subject: Re: how to support more than 512MB RAM for MIPS32 ?
From:   "Figo.zhang" <figo1802@gmail.com>
To:     Kevin Hickey <khickey@netlogicmicro.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <1259159857.4675.11.camel@kh-d280-64>
References: <c6ed1ac50911242234p12817b55r1a062d59949308bf@mail.gmail.com>
         <1259159857.4675.11.camel@kh-d280-64>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 25 Nov 2009 23:31:14 +0800
Message-ID: <1259163074.2049.6.camel@myhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <figo1802@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: figo1802@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-11-25 at 08:37 -0600, Kevin Hickey wrote:
> We use HIGHMEM on the Au1300 to access any memory spaces >256 MB.  Our
> I/O area starts at 256 MB.  We just map the extra DRAM to any area
> outside the I/O space,

how to do map extra RAM to any ouside I/O space?
it is just motify:

1. arch/mips/kernel/setup.c: bootm_init()function, motity the define
"HIGHMEM_START", for me: 
#define HIGHMEM_START 0x2000,0000   //512MB

2. use add_memory_region, for me:
 add_memory_region(0x20000000, 0x40000000, BOOT_MEM_RAM); //extra 1G RAM

is it ok ?

Best,
Figo.zhang


>  enable highmem, and register it as BOOT_MEM_RAM
> with add_memory_region.  Works great.
> 
> =Kevin
> --
> Kevin Hickey
> Netlogic Microsystems
> 
> 
> On Wed, 2009-11-25 at 14:34 +0800, figo zhang wrote:
> > hi all,
> > 
> > I am using 24KEC SOC, i want to support larger more than 512MB RAM.
> > The mips32 architure  in Kseg0/Kseg1,
> > such as:
> > 0x8000,0000 ~ 0x92c0,0000  # 300MB for RAM
> > 0x92c0,0000 ~ 0xa000,0000  # 212 for I/O register
> > 
> > so, mips32 only support 300MB memory, i dont how to support more than
> > 512MB in linux-mips kernel , such as 2GB memory? it is using HIGHMEM
> > strategy
> > for kernel(ZONE_HIGHMEM)?
> > 
> > Best,
> > Figo.zhang
> 
