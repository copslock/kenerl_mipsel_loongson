Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 20:35:52 +0000 (GMT)
Received: from 154-84-51-66.reonbroadband.com ([IPv6:::ffff:66.51.84.154]:50560
	"EHLO tibook.netx4.com") by linux-mips.org with ESMTP
	id <S8225265AbTBTUfv>; Thu, 20 Feb 2003 20:35:51 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id h1KKZFP01202;
	Thu, 20 Feb 2003 15:35:15 -0500
Message-ID: <3E553C03.10207@embeddededge.com>
Date: Thu, 20 Feb 2003 15:35:15 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tibor Polgar <tpolgar@freehandsystems.com>
CC: Mark Salter <msalter@redhat.com>, krishnakumar@naturesoft.net,
	linux-mips@linux-mips.org
Subject: Re: Ramdisk image on flash.
References: <200302201135.09154.krishnakumar@naturesoft.net> <1045765647.30379.262.camel@zeus.mvista.com> <3E552CDF.ECD08EEF@freehandsystems.com> <20030220194115.2A21378A6D@deneb.localdomain> <3E55342D.6E1D36FF@freehandsystems.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Tibor Polgar wrote:

> The original poster wanted a setup where the initrd was NOT part of the
> kernel, which begs the question of how/where it would be put into flash so
> something could load/uncompress it. 

I regularly do this with compressed kernels (zImage) on PowerPC, ARM, and
Alchemy MIPS processors.  I attach the compressed ramdisk to the zImage,
usually with "cat" and some shell scripts.  The zImage uncompressor code
will relocate the ramdisk (and potentially ask for additional kernel
command line parameters) and will tell the kernel where the ramdisk is
located.  I don't have to recompile the kernel to do this, and best of
all it doesn't require any special boot rom knowledge of the image.  It
works with all boot roms that can load a binary image into a memory location
(not everyone uses RedBoot) :-)  Another advantage is exactly the same
image that you repeatedly test by loading over tftp or with a debugger
can be written into flash memory without modification.  It removes the
need to actually have to write to flash to test the image that will be
eventually written to flash.  You just jump to the start of the image to
uncompress/relocate/initialize/jump to kernel regardless of where it
is located.

When using ramdisks from flash, you must relocate them to RAM because the
kernel thinks it can add the pages used by the compressed ramdisk into the
free pool once the ramdisk is uncompressed into the file system cache.  The
uncompressor code I mentioned above will test the start address of the
image and copy it to ram if necessary.

There are a couple of things keeping me from making a patch for the MIPS
kernel.  This method is in conflict with the "compiled in" ramdisk method,
and reserving the "bootmem" pages to ensure the kernel doesn't allocate the
compressed ramdisk pages before they are freed doesn't work well compared
to other architectures.  I'm still running on luck with this latter problem,
but I think I can fix it.  I don't know yet what to do about the conflicts
and assumptions made about the compiled-in ramdisk.

Thanks.


	-- Dan
