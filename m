Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Feb 2003 16:06:44 +0000 (GMT)
Received: from smtp2.infineon.com ([IPv6:::ffff:194.175.117.77]:6285 "EHLO
	smtp2.infineon.com") by linux-mips.org with ESMTP
	id <S8225200AbTB0QGn> convert rfc822-to-8bit; Thu, 27 Feb 2003 16:06:43 +0000
Received: from mucse011.eu.infineon.com (mucse011.ifx-mail1.com [172.29.27.228])
	by smtp2.infineon.com (8.12.2/8.12.2) with ESMTP id h1RG4N5N005552;
	Thu, 27 Feb 2003 17:04:23 +0100 (MET)
Received: by mucse011.eu.infineon.com with Internet Mail Service (5.5.2653.19)
	id <FY22HL6R>; Thu, 27 Feb 2003 17:06:37 +0100
Message-ID: <3A5A80BF651115469CA99C8928706CB603D7B302@mucse004.eu.infineon.com>
From: ZhouY.external@infineon.com
To: ncrook@micron.com, linux-mips@linux-mips.org
Subject: AW: MIPS Malta board Linux installation 
Date: Thu, 27 Feb 2003 17:06:36 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-Path: <ZhouY.external@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ZhouY.external@infineon.com
Precedence: bulk
X-list: linux-mips

Hi Neal,
  First, thanks a lot!
  Second, I tried as you mentioned, but the result is still same--screens of
rubbish characters.

  Any other solutions? 

  Best regards,
  Yidan 

-----Ursprüngliche Nachricht-----
Von: ncrook [mailto:ncrook@micron.com]
Gesendet am: Donnerstag, 27. Februar 2003 16:36
An: Zhou Yidan (COM AC CE M external); linux-mips@linux-mips.org
Betreff: RE: MIPS Malta board Linux installation 


>>Start = 0x80100608, range = (0x80100000,0x8024015f), format = SREC
>>YAMON> go . nfsroot=192.168.149.1:/c/linux/mipseb ip=192.168.149.116
>>
>>LINUX started...
>>EURfÐñoeíï>ßüÿû_ÿÿö~ÿÿ¿ßÿë¬RÿßïþëÿÛþïùúßm»>ÿÿÿûÿë®Þýí}®¿ùýoÞ÷ÿï?mÿêó¯Íëýïÿ
³ÿ
>>ÿÝûïî¯÷ÿïÿûÿÏÿÿ¿¯ÿý»ºÿgÿ¿ÿ~ÿÿßþÿûþêþÿ÷ÿÿïÿê÷×¢ÿh«Ïÿßýïÿÿþûÿÿýûÿ{ÿ®ÿÿÿÿß÷/ó
ÿí


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
