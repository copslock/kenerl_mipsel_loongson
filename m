Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 May 2005 22:05:04 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.203]:38420 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225556AbVECVEt> convert rfc822-to-8bit;
	Tue, 3 May 2005 22:04:49 +0100
Received: by wproxy.gmail.com with SMTP id 57so1495024wri
        for <linux-mips@linux-mips.org>; Tue, 03 May 2005 14:04:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZNDG7UDQQJVXWM9OyMAzFZK/ajdrgFqmaEtvW+NpGPCiSfobTtisXBdC1PM+mdL7zH+5ZsMfIgUccHkcQksn+2T6NpvtfVtAhnB7ozQkSdHPVdDZdglo/MAps/2uBJdjlQDfQmBicfXfEfrxEZ8EkGpsYPcIb/NyJR5h2q8d/To=
Received: by 10.54.123.20 with SMTP id v20mr1327493wrc;
        Tue, 03 May 2005 14:04:41 -0700 (PDT)
Received: by 10.54.38.20 with HTTP; Tue, 3 May 2005 14:04:41 -0700 (PDT)
Message-ID: <e02bc6610505031404eda9738@mail.gmail.com>
Date:	Tue, 3 May 2005 23:04:41 +0200
From:	Sergio Ruiz <quekio@gmail.com>
Reply-To: Sergio Ruiz <quekio@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: How to the the physical addresses under linux (au1500)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <quekio@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quekio@gmail.com
Precedence: bulk
X-list: linux-mips

On 5/3/05, Dan Malek <dan@embeddededge.com> wrote:
>
> On May 3, 2005, at 3:56 PM, Sergio Ruiz wrote:
>
> > I am trying to program  the DMA (with the ac97) in assembler using a
> > linux kernel module for mips teaching purposes.
>
> I think you want to choose a more simple teaching example :-)

Well, in fact we are two the students, the teacher gave us a xxs1500
and invited us to go as far as we could. It is a computer arquitecture
subject, so we wanted to use some periferic under linux and
assembler(requiered) to promote GNU stuff with other students.

The other alternative was to use YAMON, but we like linux and look
around YOUR source code ;-)

>
> > Looking at the kernel source code, I found that I can get the physical
> > address subtracting 0x8000000, but It doesnt seem to work.
>
> Not always.  On systems like this one that are not cache coherent,
> we play games with mapped addresses to get uncached spaces
> or you need to apply various macros/functions to keep the space
> coherent.
>

We got the ac97 working, so we would make it much cooler if we get the
DMA working with the ac97. If there is no way, no problem.

So, If there is a way to get it I would appreciate it a lot. We use a
char device so I have to make an external program to pass the buffer.
Using this way, is there any easy way to solve the problem??


> > Any idea?
>
> Use a more simple example.  Maybe just update one of the
> LED displays on the board.
>
>
>         -- Dan
>
>

Thanks a lot! If there is no solution, dont worry,

Thanks again,

Sergio

If anyone is interested, we are documenting what we are doing, but it
is in spanish :(
