Received:  by oss.sgi.com id <S553648AbQLNRJu>;
	Thu, 14 Dec 2000 09:09:50 -0800
Received: from tower.ti.com ([192.94.94.5]:29927 "EHLO tower.ti.com")
	by oss.sgi.com with ESMTP id <S553645AbQLNRJZ>;
	Thu, 14 Dec 2000 09:09:25 -0800
Received: from dlep8.itg.ti.com ([157.170.134.88])
	by tower.ti.com (8.11.1/8.11.1) with ESMTP id eBEH9I912041;
	Thu, 14 Dec 2000 11:09:18 -0600 (CST)
Received: from dlep8.itg.ti.com (localhost [127.0.0.1])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id LAA16637;
	Thu, 14 Dec 2000 11:09:17 -0600 (CST)
Received: from dlep3.itg.ti.com (dlep3-maint.itg.ti.com [157.170.133.16])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id LAA16614;
	Thu, 14 Dec 2000 11:09:16 -0600 (CST)
Received: from ti.com (IDENT:bbrown@bbrowndt.sc.ti.com [158.218.100.194])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id LAA26485;
	Thu, 14 Dec 2000 11:09:15 -0600 (CST)
Message-ID: <3A38FF12.9311F835@ti.com>
Date:   Thu, 14 Dec 2000 10:10:42 -0700
From:   Brady Brown <bbrown@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Nicu Popovici <octavp@isratech.ro>
CC:     linux-mips@oss.sgi.com
Subject: Re: YAMON.
References: <3A37B34B.69C1BF2@isratech.ro> <3A37ACC9.82476B96@ti.com> <3A38E314.A22393DD@isratech.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Nicu Popovici wrote:

> Hello ,
>
> Thanks . Now I have a much bigger problem. I have to try to start this ATLAS
> board without a HDD and without ethernet. At reset it should give me a login
> prompt which I have to see throught the console. Can anyone help me ?

One possibility: you basically need to write a kernel loader that lives in
Flash and is called at the very end of the boot-up code that replaces YAMON.
Additionally in flash is then a compressed kernel image and a compressed
file-system image. Your kernel loader inflates the kernel into RAM, then jumps
to the start of the kernel. The kernel then takes over. It is built to support
a ram-disk (size depending upon the size of your uncompressed file-system). So
the kernel inflates the file-system into the ram-disk and then mounts it as
root and continues with normal boot up. You can borrow much of the inflater
code within the kernel to generate the stand alone kernel loader. You will also
need to modify the ram-disk code so that it knows how to find the file-system
image in your flash. A fair bit of work, but certainly possible.

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Brady Brown (bbrown@ti.com)       Work:(801)619-6103
Texas Instruments: Broadband Access Group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
