Received:  by oss.sgi.com id <S305157AbQAMTuo>;
	Thu, 13 Jan 2000 11:50:44 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:24947 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQAMTuW>;
	Thu, 13 Jan 2000 11:50:22 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA01001; Thu, 13 Jan 2000 11:47:25 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA59334
	for linux-list;
	Thu, 13 Jan 2000 11:39:14 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA03782;
	Thu, 13 Jan 2000 11:39:06 -0800 (PST)
	mail_from (eak@detroit.sgi.com)
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id LAA79748; Thu, 13 Jan 2000 11:38:30 -0800 (PST)
Received: from cx1.detroit.sgi.com (cx1.detroit.sgi.com [169.238.130.4]) by dataserv.detroit.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA27016; Thu, 13 Jan 2000 14:38:27 -0500 (EST)
Received: from detroit.sgi.com (localhost [127.0.0.1]) by cx1.detroit.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA08592; Thu, 13 Jan 2000 14:18:40 -0500 (EST)
Message-ID: <387E2510.43D52D70@detroit.sgi.com>
Date:   Thu, 13 Jan 2000 14:18:40 -0500
From:   Eric Kimminau <eak@detroit.sgi.com>
Reply-To: eak@sgi.com
Organization: sgi
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To:     Vince Weaver <weave@eng.umd.edu>
CC:     linux@cthulhu.engr.sgi.com
Subject: Re: identifying sgi system type under Linux
References: <Pine.GSO.4.21.0001131258320.25401-100000@z.glue.umd.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Vince Weaver wrote:
> 
> Hello again
> 
> I was trying to see if I could get this Indigo2 to display that it is an
> Indigo2 under /proc/cpuinfo [instead of current behavior, which assumes
> all SGI's are indy's].
>
> Is it possible to figure out what system type it is from this info?  Is
> there another way to find out sgi system type?  Or is this just not
> possible?

Howdy Vince!

I can give you a bit of info but I am not sure how helpful it will be.

Booting into the IRIX command monitor (esc on boot)
               To perform system maintenance instead, press <Esc>

(then option 5)
System Maintenance Menu
5) Enter Command Monitor

You have available the hinv command:
>> hinv
                   System: IP22
                Processor: 200 Mhz R4400, with FPU
     Primary I-cache size: 16 Kbytes
     Primary D-cache size: 16 Kbytes
     Secondary cache size: 1024 Kbytes
              Memory size: 128 Mbytes
                 Graphics: Indy 8-bit
                SCSI Disk: scsi(0)disk(1)
                SCSI Disk: scsi(0)disk(2)
                SCSI Disk: scsi(0)disk(3)
                SCSI Disk: scsi(0)disk(6)
                    Audio: Iris Audio Processor: version A2 revision
4.1.0
Also try:
hinv -v
hinv -t
hinv -v -t 
hinv -t -p
hinv -v -t -p

The problem is that IP22 could be an Indy or an Indigo/2. Even under
IRIX if you run hinv it doesn't tell you that a system is an Indy or
an Indigo/2. Your only clues come from knowing additional bits about
what is or is not Indy or I2 hardware.  For example you would never
see Impact graphics on an Indy and you would never see an Indy 8-bit
graphics board on an Indigo/2 (although there were 8 bit boards on an
Indigo/2 - I have been looking aorund internally to see if I can find
one to see what it actually reports at command monitor for graphics).
Further confusion would be to try and identify an older Indigo with an
R4000 upgrade from an Indy.

If you actually got booted to IRIX, you would have even more options
available using the "-c" option to hinv:

Option requires an argument -- c
usage: hinv {-v -m -s -c class -t type -d dev -u unit -a file}
       where class can be:
           processor
           disk
           memory
           serial
           parallel
           tape
           graphics
           network
           scsi
           audio
           iobd
           video
           bus
           misc
           compression
           vscsi
           display
           unconnected scsi lun
           PCI card
           PCI no driver
           prom
           IEEE1394
           rps
           tpu
       type can be:
           fpu
           cpu
           dcache
           icache
           memory
           qic
           a2
           dsp
       dev can be:
           cdsio
           aso
           ec
           et
           ee
           ecf
           ef
           eg
           enp
           fxp
           ep
           hy
           ipg
           rns
           xpi
           fv
           gtr
           mtr
           mtr
           atm
           hippi
           vfe
           gfe
           gsn
           divo
           xthd

but again, hinv -c processor will only tell you that it is an IP22 :

Indy1 % hinv -c processor 
1 200 MHZ IP22 Processor
FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0
CPU: MIPS R4000 Processor Chip Revision: 2.2

Indy2 % hinv -c processor
CPU: MIPS R4600 Processor Chip Revision: 2.0
FPU: MIPS R4600 Floating Point Coprocessor Revision: 2.0
1 133 MHZ IP22 Processor

ChalS% hinv -c processor
CPU: MIPS R4400 Processor Chip Revision: 6.0
FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0
1 200 MHZ IP22 Processor

Indigo2 % hinv -c processor
CPU: MIPS R4400 Processor Chip Revision: 6.0
FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0
1 250 MHZ IP22 Processor

Where graphics would yield more information:
Indy1 % hinv -c graphics
Graphics board: Indy 8-bit

Indy2 % hinv -c graphics
Graphics board: Indy 24-bit

Indigo2% hinv -c graphics
Graphics board: Solid Impact

I am asking around internally to see what if  any portions of kernel
probe related code might be releaseable but the problem with even
attempting that (from the few limited conversations I have had with
kernel engineers) is that none of the IRIX hardware identification
code is in one central place. It is really all over the place and
dynamically builds this type of information in the hardware graph unde
IRIX based on all of the hardware the kernel finds in the system.

Short of identifying every possible piece of SGI hardware and doing
the same kinds of things under Linux as are done in IRIX to build the
hardware graph, I think this is probably going to be a fairly
difficult proposition. I am BCC'ing a few people on this message in
hope that they may respond to you singularly with additional
information.

I wish I could tell you more. I will let you knwo if I do find
something more useful.

Eric.


-- 
.--------1---------2---------3---------4---------5---------6---------7.
  Eric Kimminau           eak@sgi.com       SGI Extranet Services
      Vox:650-933-6441  Fax:248-618-9178  VNET:6-933-6441  
              "I speak my mind and no one else's."
 "I am a bomb technician. If you see me running, try to keep up..."
                    http://support.sgi.com
