Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA532070; Tue, 19 Aug 1997 11:08:24 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA23127 for linux-list; Tue, 19 Aug 1997 11:07:03 -0700
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA23100 for <linux@cthulhu.engr.sgi.com>; Tue, 19 Aug 1997 11:07:00 -0700
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (940816.SGI.8.6.9/930416.SGI)
	 id OAA16561; Tue, 19 Aug 1997 14:06:50 -0400
Message-ID: <33F9E0BA.3515E0C5@cygnus.detroit.sgi.com>
Date: Tue, 19 Aug 1997 14:06:50 -0400
From: Eric Kimminau <eak@cygnus.detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.02 [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: Stephen Gass <stepheng@zephyr.sydney.sgi.com>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: What works - what doesn't
References: <9708191425.ZM1486@zephyr.sydney.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

YES!  WE ARE NOT INSANE!!!  WE WERE DOING EVERYTHING RIGHT!

Ugh... :)

Stephen Gass wrote:
> 
> Hi All,
> 
> I have just tested booting linux using nfs on 6 indys. I have the following
> results :
> 
> The following systems worked. Notice that the ones that worked are all R4600
> based CPUs with varying memory, CPU speed , CPU cache and Newport graphics
> options. The Indys I couldn't get to boot from a NFS server were all R4400
> based systems !
> 
> ------------------------------------------------------------------------------
> 
> Iris Audio Processor: version A2 revision 4.1.0
> 1 100 MHZ IP22 Processor
> FPU: MIPS R4610 Floating Point Chip Revision: 2.0
> CPU: MIPS R4600 Processor Chip Revision: 2.0
> On-board serial ports: 2
> On-board bi-directional parallel port
> Data cache size: 16 Kbytes
> Instruction cache size: 16 Kbytes
> Main memory size: 96 Mbytes
> Integral ISDN: Basic Rate Interface unit 0, revision 1.0
> Integral Ethernet: ec0, version 1
> Integral SCSI controller 0: Version WD33C93B, revision D
> Disk drive: unit 3 on SCSI controller 0
> Disk drive: unit 1 on SCSI controller 0
> Graphics board: Indy 8-bit
> Vino video: unit 0, revision 0, IndyCam connected
> 
> -----------------------------------------------------------------------------
> 
> Iris Audio Processor: version A2 revision 4.1.0
> 1 133 MHZ IP22 Processor
> FPU: MIPS R4600 Floating Point Coprocessor Revision: 2.0
> CPU: MIPS R4600 Processor Chip Revision: 2.0
> On-board serial ports: 2
> On-board bi-directional parallel port
> Data cache size: 16 Kbytes
> Instruction cache size: 16 Kbytes
> Secondary unified instruction/data cache size: 512 Kbytes on Processor 0
> Main memory size: 96 Mbytes
> Vino video: unit 0, revision 0, IndyCam connected
> Integral ISDN: Basic Rate Interface unit 0, revision 1.0
> Integral Ethernet: ec0, version 1
> Integral SCSI controller 0: Version WD33C93B, revision D
>   Scanner: unit 7 on SCSI controller 0
>   Disk drive: unit 1 on SCSI controller 0
> Graphics board: Indy 24-bit
> 
> N.B. - Worked only after removing the scanner !
> 
> -----------------------------------------------------------------------------
> 
> Iris Audio Processor: version A2 revision 4.1.0
> 1 133 MHZ IP22 Processor
> FPU: MIPS R4600 Floating Point Coprocessor Revision: 2.0
> CPU: MIPS R4600 Processor Chip Revision: 2.0
> On-board serial ports: 2
> On-board bi-directional parallel port
> Data cache size: 16 Kbytes
> Instruction cache size: 16 Kbytes
> Secondary unified instruction/data cache size: 512 Kbytes on Processor 0
> Main memory size: 96 Mbytes
> Vino video: unit 0, revision 0, IndyCam connected
> Integral ISDN: Basic Rate Interface unit 0, revision 1.0
> Integral Ethernet: ec0, version 1
> Integral SCSI controller 0: Version WD33C93B, revision D
>   Disk drive: unit 1 on SCSI controller 0
> Graphics board: Indy 24-bit
> 
> -----------------------------------------------------------------------------
> 
> Iris Audio Processor: version A2 revision 4.1.0
> 1 133 MHZ IP22 Processor
> FPU: MIPS R4600 Floating Point Coprocessor Revision: 2.0
> CPU: MIPS R4600 Processor Chip Revision: 2.0
> On-board serial ports: 2
> On-board bi-directional parallel port
> Data cache size: 16 Kbytes
> Instruction cache size: 16 Kbytes
> Secondary unified instruction/data cache size: 512 Kbytes on Processor 0
> Main memory size: 64 Mbytes
> Vino video: unit 0, revision 0, IndyCam connected
> Integral ISDN: Basic Rate Interface unit 0, revision 1.0
> Integral Ethernet: ec0, version 1
> Integral SCSI controller 0: Version WD33C93B, revision D
>   CDROM: unit 4 on SCSI controller 0
>   Disk drive: unit 2 on SCSI controller 0
>   Disk drive: unit 1 on SCSI controller 0
> Graphics board: Indy 24-bit
> 
> ------------------------------------------------------------------------------
> 
> The following systems did not work :
> 
> ------------------------------------------------------------------------------
> 
> Iris Audio Processor: version A2 revision 4.1.0
> 1 150 MHZ IP22 Processor
> FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0
> CPU: MIPS R4400 Processor Chip Revision: 5.0
> On-board serial ports: 2
> On-board bi-directional parallel port
> Data cache size: 16 Kbytes
> Instruction cache size: 16 Kbytes
> Secondary unified instruction/data cache size: 1 Mbyte on Processor 0
> Main memory size: 64 Mbytes
> Vino video: unit 0, revision 0, IndyCam not connected
> Integral ISDN: Basic Rate Interface unit 0, revision 1.0
> Integral Ethernet: ec0, version 1
> Integral SCSI controller 0: Version WD33C93B, revision D
>     Disk drive / removable media: unit 2 on SCSI controller 0
>   Disk drive: unit 1 on SCSI controller 0
> Graphics board: Indy 24-bit
> 
> Error :
> 
> Unable to handle kernel paging request at virtual address 00000008, epc ==
> 880cbc5c , ra == 880cbc3c
> 
> -----------------------------------------------------------------------------
> 
> Iris Audio Processor: version A2 revision 4.1.0
> 1 200 MHZ IP22 Processor
> FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0
> CPU: MIPS R4400 Processor Chip Revision: 6.0
> On-board serial ports: 2
> On-board bi-directional parallel port
> Data cache size: 16 Kbytes
> Instruction cache size: 16 Kbytes
> Secondary unified instruction/data cache size: 1 Mbyte
> Main memory size: 64 Mbytes
> Integral ISDN: Basic Rate Interface unit 0, revision 1.0
> Integral Ethernet: ec0, version 1
> Integral SCSI controller 0: Version WD33C93B, revision D
> Disk drive: unit 4 on SCSI controller 0
> Disk drive: unit 3 on SCSI controller 0
> Disk drive: unit 2 on SCSI controller 0
> Disk drive: unit 1 on SCSI controller 0
> Graphics board: Indy 24-bit
> Vino video: unit 0, revision 0, IndyCam connected
> 
> Error :
> 
> Unable to handle kernel paging request at virtual address 00000008, epc ==
> 880cbc5c , ra == 880cbc3c
> 
> -----------------------------------------------------------------------------
> 
> --
> Silicon Graphics Pty Ltd    |  E-mail: stepheng@sydney.sgi.com
> 446 Victoria Rd             |  Phone : +61-2-9879-9500  VM#: 56721
> Gladesville, 2111, NSW      |  Mobile :+61-419-879-504
> 
>       "Force - the result of pushing on a door marked pull"

-- 
Eric Kimminau                           System Engineer/RSA
eak@detroit.sgi.com                     Silicon Graphics, Inc
Voice: (248) 848-4455                   39001 West 12 Mile Rd.
Fax:   (248) 848-5600                   Farmington, MI 48331-2903

                 VNet Extension - 6-327-4455
              "I speak my mind and no one else's."
       http://www.dcs.ex.ac.uk/~aba/rsa/perl-rsa-sig.html

    When confronted by a difficult problem, solve it by reducing 
    it to the question, "How would the Lone Ranger handle this?"

Windows 95: n.
    32 bit extensions and a graphical shell for a 16 bit patch to an
    8 bit operating system originally coded for a 4 bit microprocessor,
    written by a 2 bit company that can't stand 1 bit of competition.

    Author unknown.
