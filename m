Received:  by oss.sgi.com id <S553770AbQLNHVI>;
	Wed, 13 Dec 2000 23:21:08 -0800
Received: from router.isratech.ro ([193.226.114.69]:20746 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553760AbQLNHUl>;
	Wed, 13 Dec 2000 23:20:41 -0800
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id eBE7K9815583;
	Thu, 14 Dec 2000 09:20:10 +0200
Message-ID: <3A38E314.A22393DD@isratech.ro>
Date:   Thu, 14 Dec 2000 10:11:16 -0500
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Brady Brown <bbrown@ti.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: YAMON.
References: <3A37B34B.69C1BF2@isratech.ro> <3A37ACC9.82476B96@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello ,

Thanks . Now I have a much bigger problem. I have to try to start this ATLAS
board without a HDD and without ethernet. At reset it should give me a login
prompt which I have to see throught the console. Can anyone help me ?

Regards
Nicu


Brady Brown wrote:

> Nicu Popovici wrote:
>
> > Hello ,
> >
> > Does anyone know how can I do to start a Linux on a mips board ( ATLAS )
> > without using YAMON. I just want to turn on the mips and to boot in
> > Linux . Is that possible ?
> >
> > Regards,
> > Nicu
>
> It is possible. Look in Atlas Users Manual Sec 5.2 . Dip switch S1-1
> controls booting from either Monitor Flash or System Flash. If you boot
> from System Flash then the monitor is effectively removed. You would of
> course have to have your own boot-up code, PCI enumerator, hardware init,
> kernel loader, kernel image, etc.  in the System Flash all hooked to the
> reset vector for this to work.
>
> --
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Brady Brown (bbrown@ti.com)       Work:(801)619-6103
> Texas Instruments: Broadband Access Group
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
