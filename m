Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2002 18:27:28 +0200 (CEST)
Received: from mail.linuxcare.com ([216.88.157.164]:16299 "EHLO
	mail.linuxcare.com") by linux-mips.org with ESMTP
	id <S1122961AbSI0Q12>; Fri, 27 Sep 2002 18:27:28 +0200
Received: from linuxcare.com (dmz-gw.linuxcare.com [216.88.157.161])
	by mail.linuxcare.com (Postfix) with ESMTP
	id 54D0F8FBC1; Fri, 27 Sep 2002 09:21:47 -0700 (PDT)
Message-ID: <3D9485C8.90301@linuxcare.com>
Date: Fri, 27 Sep 2002 12:22:32 -0400
From: Alex deVries <adevries@linuxcare.com>
Organization: Linuxcare
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Format of bootable Indy CDs?
References: <3D92B80A.3080802@linuxcare.com> <20020927160000.GB622@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <adevries@linuxcare.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adevries@linuxcare.com
Precedence: bulk
X-list: linux-mips


Florian,

Cool! As soon as I can find a 512-byte ro CDROM, I'll try this.

I've got part of mkefs working, BTW, which I realize is not required to 
make bootable CDs, but might be helpful anyway.

- Alex


Florian Lohoff wrote:
> On Thu, Sep 26, 2002 at 03:32:26AM -0400, Alex deVries wrote:
> 
>>I'm curious about the possibility of making a Linux installer for the 
>>Indy that boots from CD; is there any description of the format of 
>>bootable IRIX CDs out there?  What does the firmware expect?
>>
>>I know that sash is involved somehow...
> 
> 
> Ok - i reworked the procedure a bit whil beeing in Oldenburg.
> 
> flo@split:~/projects/boot$ mkisofs -J -R -V testboot -o iso
> tftpboot-r4k-ip22.img
> Total translation table size: 0
> Total rockridge attributes bytes: 262
> Total directory bytes: 0
> Path table size(bytes): 10
> Max brk space used 6644
> 2208 extents written (4 Mb)
> flo@split:~/projects/boot$ isoinfo -l -R -i iso
> 
> Directory listing of /
> dr-xr-xr-x   2 1750 1750             2048 Sep 27 2002 [    28]  .
> ?---------   0 1750 1750             2048 Sep 27 2002 [    28]  ..
> -rwxr-xr-x   1 1750 1750          4414116 Sep 12 2002 [    31] tftpboot-r4k-ip22.img
> flo@split:~/projects/boot$ echo $[ 31 * 4 ]
> 124
> flo@split:~/projects/boot$ genisovh-0.1/genisovh iso sashARCS:124,4414116 ip22:124,4414116
> 
> The last command adds a "volume header" in the first 512 byte into the
> iso file. This volume header spans the whole iso filesystem and lists 2
> files at identical positions which is the ECOFF tftpboot-r4k-ip22.img.
> The name sashARCS is coded in the Indys prom for the installer when
> using your mouse and "Install System Software" and "Local cdrom".
> 
> Now one needs to write a wrapper for the Indy bootfloppys aka debian-cd
> to produce bootable cds.
> 
> I put up the stuff:
> 
> http://www.silicon-verl.de/home/flo/software/ip22test.iso
> http://www.silicon-verl.de/home/flo/software/genisovh-0.1.tgz
> 
> Flo



-- 
Alex deVries
Principal Architect, Linuxcare Canada, Inc.
(613) 562 2759

Linuxcare. Simplifying Server Consolidation.
