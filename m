Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2006 13:01:45 +0100 (BST)
Received: from mx.globalone.ru ([194.84.254.251]:17543 "EHLO mx.globalone.ru")
	by ftp.linux-mips.org with ESMTP id S20041087AbWHHMBl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2006 13:01:41 +0100
Received: from mx.globalone.ru (localhost [127.0.0.1])
	by mx.globalone.ru (8.13.1/8.13.1) with ESMTP id k78C1QYF008834
	for <linux-mips@linux-mips.org>; Tue, 8 Aug 2006 16:01:27 +0400
Received: from smtp.globalone.ru (smtp.globalone.ru [172.16.38.5])
	by mx.globalone.ru (8.13.1/8.13.1) with ESMTP id k78C1JaN008810
	for <linux-mips@linux-mips.org>; Tue, 8 Aug 2006 16:01:19 +0400
Received: from voropaya ([172.16.38.7]) by smtp.globalone.ru
          (Netscape Messaging Server 4.15) with SMTP id J3OHE700.JTJ; Tue,
          8 Aug 2006 16:01:19 +0400 
Message-ID: <0c0b01c6bae2$a464c300$e90d11ac@spb.in.rosprint.ru>
Reply-To: "Alexander Voropay" <a.voropay@equant.ru>
From:	"Alexander Voropay" <a.voropay@equant.ru>
To:	"Kishore K" <hellokishore@gmail.com>, <linux-mips@linux-mips.org>
Cc:	<yoichi_yuasa@tripeaks.co.jp>
References: <f07e6e0608062331p4ef621afn67764067f5b822c2@mail.gmail.com> <08f801c6ba47$7ee0e4b0$e90d11ac@spb.in.rosprint.ru> <f07e6e0608080241i6a928d6dh35be89f9dfdefb65@mail.gmail.com> <f07e6e0608080250n782e50dci2dd1c61057cd72ce@mail.gmail.com>
Subject: Re: Problem booting malta with 2.4.33-rc1
Date:	Tue, 8 Aug 2006 16:03:19 +0400
Organization: &Equant
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
X-Scanned-By: MIMEDefang 2.56 on 172.16.38.2
Return-Path: <a.voropay@equant.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.voropay@equant.ru
Precedence: bulk
X-list: linux-mips

Kishore K wrote:

>>> When trying to bring up Malta (4KC) board with 2.4.33-rc1 from linux-mips,
>>>the kernel crashes. Boot log is enclosed along with this mail.
>>
>>Could yoy try this kernel ?
>>
>> http://www.nwpi.ru/~alec/mips/vmlinux_2_4_33-rc2-ide-pci-ramdisk.elf.gz
>>
>> It known to work with GXEmul Malta emulatort and on the real Malta Bonito.
>>
>>What is your version of the Malta CoreCard ? See there for more info: 
>>
>>http://www.linux-mips.org/wiki/Mips_Malta 
>
> 
>Thanks for your mail. My board is coming up with this kernel image.
>May I know, whether you have done any changes in linux 2.4.33-rc2 ?
>Here is the information regarding my Malta board
>
>
>Compilation time =              Jul 27 2001  12:17:49
>Board type/revision =           0x02 (Malta) / 0x00
>Core board type/revision =      0x01 (CoreLV) / 0x01
>FPGA revision =                 0x0001
>MAC address =                   00.d0.a0.00.03.22
>Board S/N =                     0000000554
>PCI bus frequency =             33.33 MHz
>Processor Company ID/options =  0x01 (MIPS Technologies, Inc.) / 0x00
>Processor ID/revision =         0x80 (MIPS 4Kc) / 0x05 
>Endianness =                    Little
>CPU/Bus frequency =             125 MHz / 63 MHz
>Flash memory size =             4 MByte
>SDRAM size =                    64 MByte
>First free SDRAM address =      0x8009e0d0 
> 

 It's a latest 2.4 kernel from the linux-mips GIT w/o any modification.
Note, it's a generic mips-linux kernel, not a special mips-malta.

 My toolchain is gcc 3.3.6 from the Buildroot-20060523  snapshot.


 There were some modification made between 2.4.32 and 2.4.33-pre2 :

1) The MIPS32 FPU save-restore support. There was no MIPS32
support in the 2.4 before the 2.4.33-pre2.
2) PCI and PC-style COM-port issue resolved


--
-=AV=-
