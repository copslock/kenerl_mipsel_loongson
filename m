Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2004 11:55:59 +0000 (GMT)
Received: from [IPv6:::ffff:62.13.60.4] ([IPv6:::ffff:62.13.60.4]:48398 "EHLO
	mail.swemic.net") by linux-mips.org with ESMTP id <S8224988AbUBXLz4>;
	Tue, 24 Feb 2004 11:55:56 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.swemic.net (Postfix) with ESMTP
	id 1BD1D75DBB; Tue, 24 Feb 2004 12:55:52 +0100 (CET)
Received: from mail.swemic.net ([127.0.0.1])
 by localhost (seagle [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 08257-03; Tue, 24 Feb 2004 12:55:38 +0100 (CET)
Received: from corelatus.se (skokloster.swemic.net [62.13.60.22])
	by mail.swemic.net (Postfix) with ESMTP
	id AF33775D83; Tue, 24 Feb 2004 12:55:37 +0100 (CET)
Message-ID: <403B3BB8.8090403@corelatus.se>
Date:	Tue, 24 Feb 2004 12:55:36 +0100
From:	Thomas Lange <thomas@corelatus.se>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031021
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Liu Hongming (Alan)" <alanliu@trident.com.cn>
Cc:	linux-mips@linux-mips.org
Subject: Re: IDE driver problem
References: <15F9E1AE3207D6119CEA00D0B7DD5F680219C648@TMTMS>
In-Reply-To: <15F9E1AE3207D6119CEA00D0B7DD5F680219C648@TMTMS>
X-Enigmail-Version: 0.82.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new at hawk.swemic.net
Return-Path: <thomas@corelatus.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@corelatus.se
Precedence: bulk
X-list: linux-mips

The partition table is written to the first partition
on the device, in your example hda1.
Use mke2fs on hda2 and I am sure it work just great.

Cheers,
/Thomas

Liu Hongming (Alan) wrote:
> Hi All,
> 
> I am porting IDE drivers(Since my hardware has endian issue),
> and now it could work,however it has some abnormal problems:
> 
> I could 'fdisk'  /dev/hda,and partition it into several partitions.
> After this,I reboot my board and see all the partitions is there.
> Then I 'mke2fs' on /dev/hda1,after this, when using 'fdisk' again,
> I found all partitions gone! At this time,I could not access /dev/hda1
> any more.However, I could 'mount /dev/hda /opt', it really worked,and
> I could create/read/write/erase files in it.
> 
> I dumped the first sector of Hard disk and found that it has been
> zeroed.Now I dont know what the problem is,since I am not familiar
> with fs parts of linux kernel,and I dont know what 'mke2fs' has done.
> 
> Any advice?
> 
> Alan
> 
> -----Original Message-----
> From: Kevin D. Kissell [mailto:kevink@mips.com]
> Sent: Tuesday, February 24, 2004 6:47 AM
> To: Mark and Janice Juszczec; linux-mips@linux-mips.org
> Cc: uhler@mips.com; dom@mips.com; echristo@redhat.com
> Subject: Re: r3000 instruction set
> 
> 
> Kaffe's makefiles won't pick up on configuration changes, so any time
> you re-configure for a different engine or debug level, you need to do
> a make clean.  At least, that's the way it was the last time I worked on 
> it.
> If you had a partial build with JIT, then changed to intrp, then you could
> get all kinds of strange behavior.  The address range of your error us a
> dead giveaway.  It's too high to be the kaffe code segment, but too low
> to be a shared library.  It's where I'd expect the heap to be, and where
> I remember the JIT buffers being allocated when I was trying to debug
> that stuff.
> 
>  > Its been a few weeks since I built this version of kaffe.  The configure
>  > output says I did specify --with-engine=intrp.  I'll delete the compiled
>  > stuff, reconfigure (double checking that I give it --with-engine=intrp),
>  > recompile and retest.
>  >
>  > I'll post my results.
>  >
>  > Mark
>  >
>  >
>  >
>  > >From: "Kevin D. Kissell" <kevink@mips.com>
>  > >To: "Mark and Janice Juszczec" <juszczec@hotmail.com>,       
>  > ><linux-mips@linux-mips.org>
>  > >CC: <uhler@mips.com>, <dom@mips.com>, <echristo@redhat.com>
>  > >Subject: Re: r3000 instruction set
>  > >Date: Mon, 23 Feb 2004 18:21:19 +0100
>  > >
>  > > > Someone suggested posting the message I get.  Here it is:
>  > > >
>  > > > >./kaffe-bin FirstClass
>  > > > [kaffe-bin:6] Illgal instruction 674696a at 2abb034, ra=2adbffd0,
>  > > > P0_STATUS=0000500
>  > > > pid 6: killed (signal 4)
>  > > > >Reading command line: Try again
>  > > > Kernel panic: Attmpted to kill int!
>  > >
>  > >Let me guess.  You are running little-endian.  The instruction word
>  > >in memory would be 0x6a697406.  Do you think it's a coincidence
>  > >that 0x6a6974 spells "jit" in ASCII?  ;o)
>  > >
>  > >The reported address range looks like that where kaffe builds its
>  > >JITted instruciton buffers in MIPS/Linux.  And, like I say, JIT is
>  > >somewhat broken for MIPS in Kaffe.  Which version of the kaffe sources
>  > >are you building, and have you tried configuring with 
> --with-engine=intrp
>  > >as I suggested?
>  > >
>  > >             Regards,
>  > >
>  > >             Kevin K.
>  >
>  > _________________________________________________________________
>  > Click, drag and drop. My MSN is the simple way to design your homepage.
>  > http://click.atdmt.com/AVE/go/onm00200364ave/direct/01/
>  >
>  >
> 
