Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Feb 2003 15:37:14 +0000 (GMT)
Received: from masquerade.micron.com ([IPv6:::ffff:137.201.242.130]:34835 "EHLO
	mail-srv1.micron.com") by linux-mips.org with ESMTP
	id <S8225200AbTB0PhN> convert rfc822-to-8bit; Thu, 27 Feb 2003 15:37:13 +0000
Received: from mail-srv1.micron.com (localhost [127.0.0.1])
	by mail-srv1.micron.com (8.12.2/8.12.2) with ESMTP id h1RFcahP015422
	for <linux-mips@linux-mips.org>; Thu, 27 Feb 2003 08:38:41 -0700 (MST)
Received: from ntexchangehub.micron.com (ntexchangehub.micron.com [137.201.16.84])
	by mail-srv1.micron.com (8.12.2/8.12.2) with ESMTP id h1RFc34l014673;
	Thu, 27 Feb 2003 08:38:03 -0700 (MST)
Received: by ntexchangehub.micron.com with Internet Mail Service (5.5.2653.19)
	id <FLCLNQBL>; Thu, 27 Feb 2003 08:36:23 -0700
Message-ID: <DD4AFB45E2CCD211B6EE0008C7333BCF02FE6FDA@ntxmel01.micron.com>
From: ncrook <ncrook@micron.com>
To: "'ZhouY.external@infineon.com'" <ZhouY.external@infineon.com>,
	linux-mips@linux-mips.org
Subject: RE: MIPS Malta board Linux installation 
Date: Thu, 27 Feb 2003 08:36:19 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-Path: <ncrook@micron.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ncrook@micron.com
Precedence: bulk
X-list: linux-mips


>>Start = 0x80100608, range = (0x80100000,0x8024015f), format = SREC
>>YAMON> go . nfsroot=192.168.149.1:/c/linux/mipseb ip=192.168.149.116
>>
>>LINUX started...
>>EURfÐñoeíï>ßüÿû_ÿÿö~ÿÿ¿ßÿë¬RÿßïþëÿÛþïùúßm»>ÿÿÿûÿë®Þýí}®¿ùýoÞ÷ÿï?mÿêó¯Íëýïÿ³ÿ
>>ÿÝûïî¯÷ÿïÿûÿÏÿÿ¿¯ÿý»ºÿgÿ¿ÿ~ÿÿßþÿûþêþÿ÷ÿÿïÿê÷×¢ÿh«Ïÿßýïÿÿþûÿÿýûÿ{ÿ®ÿÿÿÿß÷/óÿí


looks like your serial port baud rate is wrong. At some stage, the
current setting (left by YAMON) gets overwritten by UART setup in 
Linux. Try changing:

go . nfsroot=192.168.149.1:/c/linux/mipseb ip=192.168.149.116

to:

go . nfsroot=192.168.149.1:/c/linux/mipseb ip=192.168.149.116 console=ttyS0,38400

(38400 is the baud rate.. use the value you want)

Just my guess.. worth as much as you paid for it!!

Neal.
