Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jul 2004 04:20:59 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:20987 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8224773AbUGUDUz>;
	Wed, 21 Jul 2004 04:20:55 +0100
Received: from [10.2.2.64] (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id UAA29718;
	Tue, 20 Jul 2004 20:20:47 -0700
Subject: Re: about the uMon
From: Pete Popov <ppopov@mvista.com>
To: taoyong2002cncq@yahoo.com.cn
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <20040721030436Z8224950-1530+7111@linux-mips.org>
References: <20040721030436Z8224950-1530+7111@linux-mips.org>
Content-Type: text/plain
Organization: 
Message-Id: <1090380024.4622.4.camel@thinkpad>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 20 Jul 2004 20:20:24 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2004-07-20 at 20:04, taoyong wrote:
> Hi linux-mips@linux-mips.org,
>     
>        We use the CSB350 (CPU is A1100) and use the uMon ,too.  There are some questions after our zImage is tftped to the RAM. the reason may be the file format of the zImage.
> Would you please tell us your zImage is an ELF file or other file format?

The zboot patch in my directory creates two images: an image ready to be
programmed in flash, and an image that can be downloaded to RAM instead.
The first is an srec image that yamon understands (it understands the
flash addresses and programs the file in flash). The latter is a binary
image.

Pete

> 
> [root@server tftpboot]# file zImage
> zImage: ELF 32-bit LSB MIPS-I executable, MIPS, version 1 (SYSV), statically linked, not stripped
> 
> 
> uMON>tfs ls
>  Name                        Size   Location   Flags  Info
>  boot                          52  0xbf953f4c  e      
>  hello                       8938  0xbf95632c  e      
>  monrc                        322  0xbf953d1c  e      envsetup
>  netcfg                       322  0xbf9539dc  e      envsetup
>  zImage                    347336  0xbf8fecac  e      
>  zImage2                   685692  0xbf9ffd5c  e      
> 
> Total: 6 items listed (1042662 bytes).
> uMON>tfs run zImage
> Command not found: .ELF..
> Terminating script 'zImage' at line 1
> uMON>
> uMON>
> uMON>tfs cp zImage 0xa0300000
> uMON>dm 0xa0300000
> a0300000: 7f 45 4c 46 01 01 01 00   00 00 00 00 00 00 00 00   .ELF............
> a0300010: 02 00 08 00 01 00 00 00   00 00 00 81 34 00 00 00   ............4...
> a0300020: 90 38 05 00 01 01 00 00   34 00 20 00 03 00 28 00   .8......4. ...(.
> a0300030: 0b 00 08 00 00 00 00 70   00 60 00 00 00 60 00 81   .......p.`...`..
> a0300040: 00 60 00 81 18 00 00 00   18 00 00 00 04 00 00 00   .`..............
> a0300050: 04 00 00 00 01 00 00 00   00 10 00 00 00 00 00 81   ................
> a0300060: 00 00 00 81 70 4b 00 00   70 4b 00 00 05 00 00 00   ....pK..pK......
> a0300070: 00 10 00 00 01 00 00 00   00 60 00 00 00 60 00 81   .........`...`.. 
>        
> 
> 
> 
> 
> 
> Best regards,
> 
> > Yong Tao 
> > Insitute of Manufacture Engineering of Chongqing University,
> > Chongqing,
> > China 
> > 400030
> > tel:(+8623)65111224-108
> >     (+86)13752931429
> 
> 
> 
> 
> 
