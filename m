Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jul 2004 04:10:14 +0100 (BST)
Received: from smtp104.mail.sc5.yahoo.com ([IPv6:::ffff:66.163.169.223]:63831
	"HELO smtp104.mail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8224950AbUGUDEg>; Wed, 21 Jul 2004 04:04:36 +0100
Received: from unknown (HELO ime?ty) (taoyong2002cncq@202.202.6.143 with login)
  by smtp104.mail.sc5.yahoo.com with SMTP; 21 Jul 2004 03:04:34 -0000
Date: Wed, 21 Jul 2004 11:04:52 +0800
From: "taoyong" <taoyong2002cncq@yahoo.com.cn>
Reply-To: taoyong2002cncq@yahoo.com.cn
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: about the uMon
Organization: cqu-swcims
X-mailer: Foxmail 5.0 beta2 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-Id: <20040721030436Z8224950-1530+7111@linux-mips.org>
Return-Path: <taoyong2002cncq@yahoo.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5526
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: taoyong2002cncq@yahoo.com.cn
Precedence: bulk
X-list: linux-mips

Hi linux-mips@linux-mips.org,
    
       We use the CSB350 (CPU is A1100) and use the uMon ,too.  There are some questions after our zImage is tftped to the RAM. the reason may be the file format of the zImage.
Would you please tell us your zImage is an ELF file or other file format?


[root@server tftpboot]# file zImage
zImage: ELF 32-bit LSB MIPS-I executable, MIPS, version 1 (SYSV), statically linked, not stripped


uMON>tfs ls
 Name                        Size   Location   Flags  Info
 boot                          52  0xbf953f4c  e      
 hello                       8938  0xbf95632c  e      
 monrc                        322  0xbf953d1c  e      envsetup
 netcfg                       322  0xbf9539dc  e      envsetup
 zImage                    347336  0xbf8fecac  e      
 zImage2                   685692  0xbf9ffd5c  e      

Total: 6 items listed (1042662 bytes).
uMON>tfs run zImage
Command not found: .ELF..
Terminating script 'zImage' at line 1
uMON>
uMON>
uMON>tfs cp zImage 0xa0300000
uMON>dm 0xa0300000
a0300000: 7f 45 4c 46 01 01 01 00   00 00 00 00 00 00 00 00   .ELF............
a0300010: 02 00 08 00 01 00 00 00   00 00 00 81 34 00 00 00   ............4...
a0300020: 90 38 05 00 01 01 00 00   34 00 20 00 03 00 28 00   .8......4. ...(.
a0300030: 0b 00 08 00 00 00 00 70   00 60 00 00 00 60 00 81   .......p.`...`..
a0300040: 00 60 00 81 18 00 00 00   18 00 00 00 04 00 00 00   .`..............
a0300050: 04 00 00 00 01 00 00 00   00 10 00 00 00 00 00 81   ................
a0300060: 00 00 00 81 70 4b 00 00   70 4b 00 00 05 00 00 00   ....pK..pK......
a0300070: 00 10 00 00 01 00 00 00   00 60 00 00 00 60 00 81   .........`...`.. 
       





Best regards,

> Yong Tao 
> Insitute of Manufacture Engineering of Chongqing University,
> Chongqing,
> China 
> 400030
> tel:(+8623)65111224-108
>     (+86)13752931429
