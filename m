Received:  by oss.sgi.com id <S553736AbQLOJBa>;
	Fri, 15 Dec 2000 01:01:30 -0800
Received: from router.isratech.ro ([193.226.114.69]:43275 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553648AbQLOJBF>;
	Fri, 15 Dec 2000 01:01:05 -0800
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id eBF90S622222;
	Fri, 15 Dec 2000 11:00:29 +0200
Message-ID: <3A3A4C13.9FAD7FB8@isratech.ro>
Date:   Fri, 15 Dec 2000 11:51:32 -0500
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
CC:     linux-mips@oss.sgi.com, Brady Brown <bbrown@ti.com>
Subject: Re: YAMON.
References: <XFMail.030222095511.Harald.Koerfgen@home.ivm.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi Harald,

Thanks. In principle I want to do such a thing and to run linux from ROM if this
is possible and I saw that it is possible. Now I read the documentation and I hope
to manage to setup this kind of kernel.

Thanks again.
Nicu

Harald Koerfgen wrote:

> On 14-Dec-00 Nicu Popovici wrote:
> > Thanks . Now I have a much bigger problem. I have to try to start this ATLAS
> > board without a HDD and without ethernet. At reset it should give me a login
> > prompt which I have to see throught the console. Can anyone help me ?
>
> The linux-vr tree has a nice feature called XIP (eXecute In Place). This allows
> to prepare a kernel to run directly out of ROM.
>
> http://linuxvr-org
>
> if that's what you're looking for.
>
> --
> Regards,
> Harald
