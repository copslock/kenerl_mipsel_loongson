Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jul 2004 05:50:06 +0100 (BST)
Received: from smtp105.mail.sc5.yahoo.com ([IPv6:::ffff:66.163.169.225]:14240
	"HELO smtp105.mail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8224929AbUGVBu0>; Thu, 22 Jul 2004 02:50:26 +0100
Received: from unknown (HELO ime?ty) (taoyong2002cncq@202.202.6.143 with login)
  by smtp105.mail.sc5.yahoo.com with SMTP; 22 Jul 2004 01:50:23 -0000
Date: Thu, 22 Jul 2004 09:50:47 +0800
From: "taoyong" <taoyong2002cncq@yahoo.com.cn>
Reply-To: taoyong2002cncq@yahoo.com.cn
To: "linux-mips" <linux-mips@linux-mips.org>
Subject: boot "hell world " and linux on CSB350
Organization: cqu-swcims
X-mailer: Foxmail 5.0 beta2 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-Id: <20040722015026Z8224929-1530+7145@linux-mips.org>
Return-Path: <taoyong2002cncq@yahoo.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5537
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: taoyong2002cncq@yahoo.com.cn
Precedence: bulk
X-list: linux-mips

Hi linux-mips,
    
       We have AMD PB1000 and openpda platform and the hardhat linux keranl. csb350 is a new board,and we want to port the hardhat kernal to the csb350. But after we download the "hello world" ,which is comopiled with the mips-elf-gcc,to the ram 0xa0300000,then "call 0xa0300000",we got "Returned: -2147239488 (0x8003b9c0)" . we tftped the kernal image to the RAM 0xa0300000,then call it ,got the same result "Returned: -2147239488 (0x8003b9c0)" or it stopped there.



uMON>tftp 192.168.100.251 get /tftpboot/hello.bin 0xa0300000
Retrieving /tftpboot/hello.bin from 192.168.100.251...TFTP transfer complete.
 1504 bytes
uMON>call 0xa0300000
Returned: -2147239488 (0x8003b9c0)
uMON>dm 0xa0300000
a0300000: 14 a0 1d 3c 00 ff bd 27   11 a0 1c 3c d0 85 9c 27   ...<...'...<...'
a0300010: 04 00 bf af 54 01 04 0c   00 00 00 00 00 00 00 00   ....T...........
a0300020: 04 00 bf 8f 08 00 e0 03   00 00 00 00 00 00 00 00   ................
a0300030: 08 00 e0 03 00 00 00 00   00 00 00 00 00 00 00 00   ................
a0300040: 21 40 00 00 05 00 a0 14   21 48 80 00 30 00 02 24   !@......!H..0..$
a0300050: 00 00 22 a1 08 00 e0 03   01 00 02 24 1b 00 a6 00   .."........$....
a0300060: 12 28 00 00 21 20 28 01   10 10 00 00 01 00 c0 50   .(..! (........P
a0300070: 0d 00 07 00 21 10 e2 00   00 00 43 90 01 00 08 25   ....!.....C....%

uMON>tftp 192.168.100.251 get /tftpboot/vmlinux.bin 0xa0600000
Retrieving /tftpboot/vmlinux.bin from 192.168.100.251...TFTP transfer complete.
 1548288 bytes
uMON>call 0xa0600000
Returned: -2147239488 (0x8003b9c0)

uMON>tftp 192.168.100.251 get /tftpboot/vmlinux.bin 0xa0300000
Retrieving /tftpboot/vmlinux.bin from 192.168.100.251...TFTP transfer complete.
 1548288 bytes
uMON>dm 0xa0300000                                            
a0300000: 00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00   ................
a0300010: 00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00   ................
a0300020: 00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00   ................
a0300030: 00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00   ................
a0300040: 00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00   ................
a0300050: 00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00   ................
a0300060: 00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00   ................
a0300070: 00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00   ................
uMON>call 0xa0300000
 
it stopped here and we have to reset the csb350. what's the reason?








Best regards,

> Yong Tao 
> Insitute of Manufacture Engineering of Chongqing University,
> Chongqing,
> China 
> 400030
> tel:(+8623)65111224-108
>     (+86)13752931429
