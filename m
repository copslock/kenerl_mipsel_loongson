Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9P8UpM27319
	for linux-mips-outgoing; Thu, 25 Oct 2001 01:30:51 -0700
Received: from hell.ascs.muni.cz (hell.ascs.muni.cz [147.251.60.186])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9P8UlD27316
	for <linux-mips@oss.sgi.com>; Thu, 25 Oct 2001 01:30:48 -0700
Received: (from xhejtman@localhost)
	by hell.ascs.muni.cz (8.11.2/8.11.2) id f9P8XXG04778;
	Thu, 25 Oct 2001 10:33:33 +0200
Date: Thu, 25 Oct 2001 10:33:33 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: nick@snowman.net
Cc: linux-mips@oss.sgi.com
Subject: Re: Origin 200
Message-ID: <20011025103333.E2045@mail.muni.cz>
References: <20011025010425.C2045@mail.muni.cz> <Pine.LNX.4.21.0110242021240.25602-100000@ns>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0110242021240.25602-100000@ns>; from nick@snowman.net on Wed, Oct 24, 2001 at 08:23:00PM -0400
X-MIME-Autoconverted: from 8bit to quoted-printable by hell.ascs.muni.cz id f9P8XXG04778
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f9P8UmD27317
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Oct 24, 2001 at 08:23:00PM -0400, nick@snowman.net wrote:
> Getting it running 64bit shouldn't be *too* bad, however there are some
> revs of some chips on the MB which linux currently can't deal with, and
> noone is quite sure 1. what revs, 2. why, or 3. anything
> usefull. <Grin>.  Could you send a hinv -v from the prom?  Boot logs would
> also be usefull (so I can tell if we are haveing the exact same problem,
> or just similar ones)

>> hinv -v
IP27 Node Board, Module 1, Slot MotherBoard
    ASIC HUB Rev 3, 90 MHz, (nasid 0)
    Processor A: 180 MHz R10000, Rev 2.6, 1M  120MHz secondary cache, (cpu 0)
      R10000FPC  Rev 0
    Memory on board, 64 MBytes (Standard)
      Bank 0, 64 MBytes (Standard) <-- (Physical Bank 0)
BASEIO Origin 200 IO Board, Module 1, Slot MotherBoard
    ASIC BRIDGE Rev 3, (widget 8)
    adapter PCI-SCSI Rev 4, (pci id 0)
        peripheral SCSI DISK, ID 1, SGI IBM DORS-32160W
    adapter PCI-SCSI Rev 4, (pci id 1)
        peripheral SCSI CDROM, ID 6, TOSHIBA CD-ROM XM-5401TA
    adapter IOC3 Rev 1, (pci id 2)
        controller multi function SuperIO
        controller Ethernet Rev 1
    adapter PCI-SCSI Rev 5, (pci id 5)


-- 
Luká¹ Hejtmánek
