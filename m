Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2003 18:03:05 +0100 (BST)
Received: from bay1-f17.bay1.hotmail.com ([IPv6:::ffff:65.54.245.17]:28424
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225239AbTEHRDD>; Thu, 8 May 2003 18:03:03 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 8 May 2003 10:02:55 -0700
Received: from 4.35.224.219 by by1fd.bay1.hotmail.msn.com with HTTP;
	Thu, 08 May 2003 17:02:54 GMT
X-Originating-IP: [4.35.224.219]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board
Date: Thu, 08 May 2003 10:02:54 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F17fJpbi7Phnzi00006011@hotmail.com>
X-OriginalArrivalTime: 08 May 2003 17:02:55.0190 (UTC) FILETIME=[AB184760:01C31583]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi JBG,

The MIPS box (Atlas running YAMON) has a fixed IP address assigned by me. 
TFTP boot works fine. But this IP is held within the boot monitor program 
(YAMON).

YAMON> set

baseboardserial (RO)   0000000197
bootfile        (R/W)  vmlinux.rec
bootprot        (R/W)  tftp
bootserport     (R/W)  tty0
bootserver      (R/W)  4.42.102.7
cpuconfig       (R/W)
ethaddr         (RO)   00.d0.a0.00.00.ed
fpu             (R/W)
gateway         (R/W)  12.235.80.1
ipaddr          (R/W)  4.42.102.6
memsize         (RO)   0x04000000
modetty0        (R/W)  115200,n,8,1,hw
modetty1        (R/W)  115200,n,8,1,hw
prompt          (R/W)  YAMON
start           (R/W)
startdelay      (R/W)
subnetmask      (R/W)  255.255.252.0
yamonrev        (RO)   02.04

Apart from the dynamic IP address assignment methods....
Suggest me a method to communicate this value to the RAM resident Linux 
kernel. Or can I assign a fixed IP addredd by passing it as a parameter when 
the linux kernel boots up? If so what is the syntax & please point me to the 
document that has this info. about passed parameter when booting the kernel.

Thanks,
-Mike.


>From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
>To: linux-mips@linux-mips.org
>Subject: Re: Linux for MIPS Atlas 4Kc board
>Date: Thu, 8 May 2003 13:20:53 +0200
>
>On Thu, 2003-05-08 03:09:53 -0700, Michael Anburaj 
><michaelanburaj@hotmail.com>
>wrote in message <BAY1-F62WlX0MGOV6T000004f80@hotmail.com>:
> > Hi all,
> >
> > Finally I got the Atlas 4Kc board running YAMON to talk to Host PC 
>running
> > RedHat Linux 9 & download vmlinux.rec throught tftp. I have set-up NFS
> > export in the same PC under /export/RedHat7.1
> >
> > After the vmlinux.rec got downloaded, I issued the following command on 
>the
> > YAMON (MIPS tartget) prompt to start the downloaded linux kernel:
> >
> > go . nsfroot=4.42.102.7:/export/RedHat7.1
>                                            ^^^^^^^
>
>I think the box doesn't have an IP address, nor has it been told to pick
>one. You should add 'ip=bootp' or 'ip=dhcp' to your command line.
>
> > Protect your PC - get McAfee.com VirusScan Online
> > http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963
>
>Protecting a PeeCee is more an act of not shooting one's own feet by
>running known-bad software...
>
>MfG, JBG
>
>--
>    Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
>    "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen 
>Krieg
>     fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im 
>Irak!
>       ret = do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));
><< attach3 >>

_________________________________________________________________
MSN 8 helps eliminate e-mail viruses. Get 2 months FREE*.  
http://join.msn.com/?page=features/virus
