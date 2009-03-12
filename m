Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Mar 2009 09:46:37 +0000 (GMT)
Received: from fk-out-0910.google.com ([209.85.128.189]:36919 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20808485AbZCLJqa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Mar 2009 09:46:30 +0000
Received: by fk-out-0910.google.com with SMTP id 26so132035fkx.0
        for <multiple recipients>; Thu, 12 Mar 2009 02:46:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=1hrNyj4IZ0v6mfRIvJGd+UklS13/5PQ4B90OHM1DQ9g=;
        b=jWtduvZXkQZRZMX+639HiSJtNbwWDIVmncIRxVUWwu2/fjIuGnp02OGl+9sT+3tpcJ
         2c0WJnH6fI5nb5/AHj2BPxx/QjpbXb4M75egomKfumXHTPKICAxEy6pWSJ0aMfOp4bYV
         +VwAJ5r1Y4mg/mLKPZZqvtTaVPIQhnVowaUXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=dTuyyQLMHFeU6zSP+vTquFgmqPczMxmi+At4W/qdEhzQ3GFeIMxDryq+6rSK77jf9p
         /WiHEVs4zh19nnN0b7VkFtl0u5jRsl4IGzp0z9Q7Y3rrQw00Nesi4ma5dc4djJWgDp1k
         0jB+NagG/R8tCgrczDxLwrCeYxuG2N5NRIzrM=
MIME-Version: 1.0
Received: by 10.103.226.10 with SMTP id d10mr4213628mur.84.1236851188977; Thu, 
	12 Mar 2009 02:46:28 -0700 (PDT)
In-Reply-To: <20090312092810.GA13674@linux-mips.org>
References: <20090311112806.GA24541@linux-mips.org>
	 <20090312072618.GA31978@roarinelk.homelinux.net>
	 <20090312092810.GA13674@linux-mips.org>
Date:	Thu, 12 Mar 2009 10:46:28 +0100
X-Google-Sender-Auth: ab5a8f71a642a2da
Message-ID: <f861ec6f0903120246m386a09c7o5825a92a00cef2d6@mail.gmail.com>
Subject: Re: __do_IRQ() going away
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Thu, Mar 12, 2009 at 10:28 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Mar 12, 2009 at 08:26:18AM +0100, Manuel Lauss wrote:
>
>>
>> On Wed, Mar 11, 2009 at 12:28:06PM +0100, Ralf Baechle wrote:
>> > __do_IRQ() is deprecated since a long time and there are plans to remove
>> > it for 2.6.30.  The MIPS platforms seem to fall into three classes:
>>
>> >  o Platforms that still seem to rely on __do_IRQ():
>> >      o All Alchemy platforms:
>> >     db1000_defconfig, db1100_defconfig, db1200_defconfig, db1500_defconfig,
>> >     db1550_defconfig, mtx1_defconfig, pb1100_defconfig, pb1500_defconfig
>> >     and pb1550_defconfig
>>
>> I believe that the defconfigs just need to be updated.  There are no
>> __do_IRQ invocations in the alchemy/ tree anymore, and generic hardirqs are
>> enabled by CONFIG_SOC_AU1X00.
>
> __do_IRQ will be called from the generic code if irq_desc->handle_irq is
> not set for an interrupt and handle_irq will be left NULL if a platform
> only calls set_irq_chip or even does a homebrew initialization.  Fix is
> to call set_irq_chip_and_handler or better set_irq_chip_and_handler_name.

Alchemy does all that...


> Iow, now with CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ always set half the
> platforms will blow up because the function pointer irq_desc->handle_irq
> is unset.

...and it works fine so far on the DB1200 and another 2 boards I have.
(I.e. your patch didn't break anything).  Unless I'm missing something
very big.

Manuel Lauss
