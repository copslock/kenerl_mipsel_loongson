Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Feb 2003 16:44:14 +0000 (GMT)
Received: from smtp2.infineon.com ([IPv6:::ffff:194.175.117.77]:43678 "EHLO
	smtp2.infineon.com") by linux-mips.org with ESMTP
	id <S8225205AbTB0QoN> convert rfc822-to-8bit; Thu, 27 Feb 2003 16:44:13 +0000
Received: from mucse011.eu.infineon.com (mucse011.ifx-mail1.com [172.29.27.228])
	by smtp2.infineon.com (8.12.2/8.12.2) with ESMTP id h1RGfr5N013653;
	Thu, 27 Feb 2003 17:41:54 +0100 (MET)
Received: by mucse011.eu.infineon.com with Internet Mail Service (5.5.2653.19)
	id <FY22H34V>; Thu, 27 Feb 2003 17:44:07 +0100
Message-ID: <3A5A80BF651115469CA99C8928706CB603D7B303@mucse004.eu.infineon.com>
From: ZhouY.external@infineon.com
To: ncrook@micron.com
Cc: linux-mips@linux-mips.org
Subject: AW: MIPS Malta board Linux installation 
Date: Thu, 27 Feb 2003 17:44:07 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-Path: <ZhouY.external@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ZhouY.external@infineon.com
Precedence: bulk
X-list: linux-mips

I tried again. The result is same. 
The green LED display shows 'LINUX' not 'LINUX on malta'. All the status LED
are green except the LED rst is off. There are 2 kernel images(el and eb),
one of them is vmlinux-2.2.12.mips.malta.eb-01.05.srec, which is the current
one. I double checked my console and its baud rate is 38400. 
  From this symptom, what kind of conclusion can you draw?

  Best regards,

  Yidan

-----Urspr�ngliche Nachricht-----
Von: ncrook [mailto:ncrook@micron.com]
Gesendet am: Donnerstag, 27. Februar 2003 17:25
An: Zhou Yidan (COM AC CE M external)
Betreff: RE: MIPS Malta board Linux installation 

Hmm, well, for a start, you can just boot like this:

go . console=ttyS0,38400

.. your boot isn't getting anywhere near far enough to care
about IP addresses and nfs root disks; Once you get far
enough to see a message about "attempting to mount root
file system" then you can start worrying about ip and nfsroot
arguments.

..take a look at the green 8-character display (U42). If it
is scrolling the text "linux on malta" then the kernel is
almost certainly up and running, and I would suspect your
serial port settings are wrong in your terminal emulator.
If not, check you're using a big-endian kernel for a malta.

that's all I can think of. Happy hunting

Neal.


-----Original Message-----
From: ZhouY.external@infineon.com [mailto:ZhouY.external@infineon.com]
Sent: 27 February 2003 16:03
To: ncrook@micron.com
Subject: AW: MIPS Malta board Linux installation 


Hi Neal,
  First, thanks a lot!
  Second, I tried as you mentioned, but the result is still same--screens of
rubbish characters.

  Any other solutions? 

  Best regards,
  Yidan 

-----Urspr�ngliche Nachricht-----
Von: ncrook [mailto:ncrook@micron.com]
Gesendet am: Donnerstag, 27. Februar 2003 16:36
An: Zhou Yidan (COM AC CE M external)
Betreff: RE: MIPS Malta board Linux installation 


>>Start = 0x80100608, range = (0x80100000,0x8024015f), format = SREC
>>YAMON> go . nfsroot=192.168.149.1:/c/linux/mipseb ip=192.168.149.116
>>
>>LINUX started...
>>EURf��oe��>����_���~������R������������m�>���������}����o����?m��������
��
>>���������������������g���~�����������������ע�h���������������{��������/�
��


looks like your serial port baud rate is wrong. At some stage, the
current setting (left by YAMON) gets overwritten by UART setup in 
Linux. Try changing:

go . nfsroot=192.168.149.1:/c/linux/mipseb ip=192.168.149.116

to:

go . nfsroot=192.168.149.1:/c/linux/mipseb ip=192.168.149.116
console=ttyS0,38400

(38400 is the baud rate.. use the value you want)

Just my guess.. worth as much as you paid for it!!

Neal.
