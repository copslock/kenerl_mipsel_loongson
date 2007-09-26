Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 17:26:02 +0100 (BST)
Received: from mx.orange-ftgroup.ru ([194.84.254.251]:40130 "EHLO
	mx.orange-ftgroup.ru") by ftp.linux-mips.org with ESMTP
	id S20029798AbXIZQZy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 17:25:54 +0100
Received: from mx.orange-ftgroup.ru (localhost [127.0.0.1])
	by mx.orange-ftgroup.ru (8.13.1/8.13.1) with ESMTP id l8QGPbQw014274
	for <linux-mips@linux-mips.org>; Wed, 26 Sep 2007 20:25:38 +0400
Received: from smtp.globalone.ru (smtp.globalone.ru [172.16.38.5])
	by mx.orange-ftgroup.ru (8.13.1/8.13.1) with ESMTP id l8QGPPh4014246
	for <linux-mips@linux-mips.org>; Wed, 26 Sep 2007 20:25:25 +0400
Received: from voropaya ([172.16.38.7]) by smtp.globalone.ru
          (Netscape Messaging Server 4.15) with SMTP id JOZHMD00.BL5; Wed,
          26 Sep 2007 20:25:25 +0400 
Message-ID: <029001c80059$d7a14960$e90d11ac@spb.in.rosprint.ru>
Reply-To: "Alexander Voropay" <alec@nwpi.ru>
From:	"Alexander Voropay" <alec@nwpi.ru>
To:	<qemu-devel@nongnu.org>, "Thiemo Seufer" <ths@networkno.de>
Cc:	<linux-mips@linux-mips.org>, <vlad@comsys.ro>
References: <46E68AA3.2010907@comsys.ro> <20070911125421.GE10713@networkno.de> <46E69AAF.2090509@comsys.ro>
Subject: Re: [Qemu-devel] Qemu and Linux 2.4
Date:	Wed, 26 Sep 2007 20:25:18 +0400
Organization: NWPI
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.3028
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.61 on 172.16.38.2
Return-Path: <alec@nwpi.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alec@nwpi.ru
Precedence: bulk
X-list: linux-mips

<vlad@comsys.ro> wrote:

>>> - QEMU malta emulation is not really complete, to put it mildly
>> Out of curiosity, what parts did you miss?
> Like, for example, the PCI stuff. So I can use the network card.

 PCI stuff in the QEMU/Malta works fine, but pseudo-bootrom
does not perform PCI enumeration and leaves uninitialized PCI BARs.

 Linux MIPS/Malta 2.4 can not perform PCI enumeration too.  The LANCE
Ethernet driver *requres* a pre-initialized BARs. The situation even worse,
since current Linux 2.4 can't be even built with NEW_PCI and PCI_AUTO
options at all (due to linkage error).

http://www.linux-mips.org/wiki/PCI_Subsystem

 There is the same PCI problem with NetBSD/evbmips and seems VxWorks/Malta.

> And yes, I am aware of YAMON.

 AFAIK, YAMON may runs on the MIPS hardware only, and may not
be redistribuded in the source or binary form.

 Anyway, YAMON binary does not work on the Qemu/Malta. The Galileo
chip is far more complicated then Qemu emulation. It contains four DMA
channels, four timers e.t.c. e.t.c.

>> I recommend to improve the Qemu Malta emulation, and make it work with
>> 2.4 Malta kernels. (ISTR it used to work, so it shouldn't need a lot to
>> get there.)
> 
> I'm sure that improving the Qemu Malta emulation is a very noble goal, 
> but for people that need a working 2.4 kernel NOW, my patch could be 
> useful. Having the QEMU target in 2.6 surely helped me.

 The only thing we need is a good bootrom (BIOS) for the MIPS/Malta
(Free-YAMON ;)

 As a quick'n'disty solution you could initialize PCI BARs of the
device number 12 (0x0b, LANCE) with GDB:

(gdb) set variable {int}0xbbe00cf8=0x80005810   <--- I/O address
(gdb) set variable {int}0xbbe00cfc=0x00002001
(gdb) set variable {int}0xbbe00cf8=0x80005814  <--- Mem address
(gdb) set variable {int}0xbbe00cfc=0xfc200000
(gdb) set variable {int}0xbbe00cf8=0x80005804  <--- Enable Mem and I/O
(gdb) set variable {int}0xbbe00cfc=0x00000003
(gdb) set variable {int}0xbbe00cf8=0x8000583c   <---- IRQ=10 tied to Pin A
(gdb) set variable {int}0xbbe00cfc=0xff06010a
(gdb) cont
Continuing.

...
Linux version 2.4.35.3 (alec@ilias.nwpi.ru) (gcc version 3.3.6) #2 Tue Sep 25 18:59:10 MSD 2007
...
pcnet32.c:v1.30h 06.24.2004 tsbogend@alpha.franken.de
pcnet32: PCnet/PCI II 79C970A at 0x2000, 52 54 00 12 34 56 assigned IRQ 10.
eth0: registered as PCnet/PCI II 79C970A
pcnet32: 1 cards_found.
...

# lspci -v
....
00:0b.0 Class 0200: 1022:2000 (rev 10)
        Flags: bus master, fast devsel, latency 64, IRQ 10
        I/O ports at 2000 [size=32]
        Memory at fc200000 (32-bit, non-prefetchable) [size=32]


# ifconfig eth0 192.168.1.1 netmask 255.255.255.0 up
#
# ping 192.168.1.1
PING 192.168.1.1 (192.168.1.1): 56 data bytes
64 bytes from 192.168.1.1: icmp_seq=0 ttl=64 time=4.2 ms



--
-=AV=-

*******************************************************************************************************
This message and any attachments (the "message") are confidential and intended solely for the addressees. 
Any unauthorised use or dissemination is prohibited.
Messages are susceptible to alteration. Orange Business Services shall not be liable for the message if altered, changed or
falsified. If you are not the intended addressee of this message, please cancel it immediately and inform 
the sender.
*******************************************************************************************************
