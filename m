Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2LHhrJ02615
	for linux-mips-outgoing; Thu, 21 Mar 2002 09:43:53 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2LHhkq02610
	for <linux-mips@oss.sgi.com>; Thu, 21 Mar 2002 09:43:46 -0800
Received: from mail.ict.ac.cn ([159.226.39.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id GAA07008
	for <linux-mips@oss.sgi.com>; Thu, 21 Mar 2002 06:03:27 -0800 (PST)
	mail_from (fxzhang@ict.ac.cn)
Message-Id: <200203211403.GAA07008@sgi.com>
Received: (qmail 26791 invoked from network); 21 Mar 2002 12:01:54 -0000
Received: from unknown (HELO foxsen) (159.226.40.150)
  by 159.226.39.4 with SMTP; 21 Mar 2002 12:01:54 -0000
Date: Thu, 21 Mar 2002 20:31:48 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Dominic Sweetman <dom@algor.co.uk>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: Re: PCI VGA Card Initilization (SIS6326 / PT80)
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g2LHhlq02611
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,
 
ÔÚ 2002-03-21 10:37:00 you wrote£º
>Zhang Fuxin (fxzhang@ict.ac.cn) writes:
>
>> We have tried several cards on Algor P6032 board,but only matrox
>> Gxxx cards (G450 needs the latest code) can be used by linux kernel
>> without vga bios executed. With a x86 emulator we are able to use
>> Riva TNT2,and probably more can work. Unfortunately that emulator is
>> an executable from Algor, as a kindly help. We can't get more
>> control on it and finally give up...
>
>Just a note: Zhang, if you want source code of the Algorithmics
>simulator, we've no problem at all supplying it on our standard
>license.  
Thank you for your information. We may request for it again if we
could not make one. I always deem the executable as 'a kindly help'
and appreciate all your contribution to mips world. 
>
>Whether that source is useful to you is another question: the BIOS
>emulator was created out of pieces of a complete x86 emulator, and
>it's a fairly complicated bit of software.
In fact I am interesting in this task itself,no one ask me to do it.
Anyway we are a reseaching institute:).But it is a pity that mips platform 
can't get its own display easily,and cheaply. Just too many things to do..

Our plan is to port X86 bios emulation code(as Alan pointed out) into pmon.
bochs has been considered too.
>
>One of my colleagues saw Zhang's request and said he'd consult, and
>then the message got lost - sorry.
>
>Our standard license is not GPL and it does have one restriction - if
>you build our software into something you sell, we ask you to get a
>further license from us before you take the money from your customers.
>
>We can be persuaded to put software out on GPL instead (as we did with
>the floating-point emulation code).  But generally some commercial
>organisation - the difference only matters then, right? - has to ask
>nicely...
Yes,i understand. 
>
>--
>Dominic Sweetman
>Algorithmics Ltd
>The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
>phone +44 1223 706200/fax +44 1223 706250/direct +44 1223 706205
>http://www.algor.co.uk

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
