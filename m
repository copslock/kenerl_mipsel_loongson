Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 02:54:30 +0100 (BST)
Received: from smtp110.mail.sc5.yahoo.com ([IPv6:::ffff:66.163.170.8]:63580
	"HELO smtp110.mail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8225219AbUHRByY>; Wed, 18 Aug 2004 02:54:24 +0100
Received: from unknown (HELO ime?ty) (taoyong2002cncq@202.202.6.143 with login)
  by smtp110.mail.sc5.yahoo.com with SMTP; 18 Aug 2004 01:54:19 -0000
Date: Wed, 18 Aug 2004 09:54:45 +0800
From: "taoyong" <taoyong2002cncq@yahoo.com.cn>
Reply-To: taoyong2002cncq@yahoo.com.cn
To: "linux-mips" <linux-mips@linux-mips.org>
Subject: does anyone have the BDI2000 config file for Cognet CSB350?
Organization: cqu-swcims
X-mailer: Foxmail 5.0 beta2 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-Id: <20040818015424Z8225219-1530+8612@linux-mips.org>
Return-Path: <taoyong2002cncq@yahoo.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: taoyong2002cncq@yahoo.com.cn
Precedence: bulk
X-list: linux-mips

Hi linux-mips,
    
      I use the BDI2000 to prog the flash of CSB350,but failed. I am not sure my configfile is correct or not. So anyone have use the CSB350 and would you  please send me the config file?

BDI>md 0xbfc00000
bfc00000 : 0000b400 00001000 00000000 00000200  ................
bfc00010 : 00000000 00000000 00000000 00000000  ................
bfc00020 : 00000000 00001000 00000000 00000000  ................
bfc00030 : 00000011 00004455 00008899 0000ccdd  ....UD..........
bfc00040 : 0000ffff 0000ffff 0000ffff 0000ffff  ................
bfc00050 : 0000ffff 0000ffff 0000ffff 0000ffff  ................
bfc00060 : 00003030 0000333a 00003a35 00003030  00..:3..5:..00..
bfc00070 : 00004500 0000ffff 0000ffff 0000ffff  .E..............
bfc00080 : 00003c09 00004089 00003c09 00003529  .<...@...<..)5..
bfc00090 : 00004089 00004080 00000000 00003c09  .@...@.......<..
bfc000a0 : 00004089 00002408 00002409 0000240a  .@...$...$...$..
bfc000b0 : 00004089 00004200 00000000 0000400b  .@...B.......@..
bfc000c0 : 00003c0c 0000018b 00002529 0000100b  .<......)%......
bfc000d0 : 00000000 00004088 00004080 00004080  .....@...@...@..
bfc000e0 : 00004080 00004200 00002508 0000150a  .@...B...%......
bfc000f0 : 00000000 00004080 00000000 00003c08  .....@.......<..

BDI>md 0xbfd00000
bfd00000 : 0000ffff 0000ffff 0000ffff 0000ffff  ................
bfd00010 : 0000ffff 0000ffff 0000ffff 0000ffff  ................
bfd00020 : 0000ffff 0000ffff 0000ffff 0000ffff  ................
bfd00030 : 0000ffff 0000ffff 0000ffff 0000ffff  ................
bfd00040 : 0000ffff 0000ffff 0000ffff 0000ffff  ................
bfd00050 : 0000ffff 0000ffff 0000ffff 0000ffff  ................
bfd00060 : 0000ffff 0000ffff 0000ffff 0000ffff  ................
bfd00070 : 0000ffff 0000ffff 0000ffff 0000ffff  ................
bfd00080 : 0000ffff 0000ffff 0000ffff 0000ffff  ................
bfd00090 : 0000ffff 0000ffff 0000ffff 0000ffff  ................
bfd000a0 : 0000ffff 0000ffff 0000ffff 0000ffff  ................
bfd000b0 : 0000ffff 0000ffff 0000ffff 0000ffff  ................
bfd000c0 : 0000ffff 0000ffff 0000ffff 0000ffff  ................
bfd000d0 : 0000ffff 0000ffff 0000ffff 0000ffff  ................
bfd000e0 : 0000ffff 0000ffff 0000ffff 0000ffff  ................
bfd000f0 : 0000ffff 0000ffff 0000ffff 0000ffff  ................

 





Best regards,

> Yong Tao 
> Insitute of Manufacture Engineering of Chongqing University,
> Chongqing,
> China 
> 400030
> tel:(+8623)65111224-108
>     (+86)13752931429
