Received:  by oss.sgi.com id <S553743AbQKIHLe>;
	Wed, 8 Nov 2000 23:11:34 -0800
Received: from router.isratech.ro ([193.226.114.69]:55314 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553722AbQKIHL1>;
	Wed, 8 Nov 2000 23:11:27 -0800
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id eA97BEg10622
	for <linux-mips@oss.sgi.com>; Thu, 9 Nov 2000 09:11:14 +0200
Message-ID: <3A0ABCD5.FA556A09@isratech.ro>
Date:   Thu, 09 Nov 2000 10:03:49 -0500
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: [Fwd: Warning: could not send message for past 4 hours]
Content-Type: multipart/mixed;
 boundary="------------52ED9AC7ABEF626DD11746EC"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------52ED9AC7ABEF626DD11746EC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------52ED9AC7ABEF626DD11746EC
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Return-Path: <MAILER-DAEMON@router.isratech.ro>
Received: from localhost (localhost)
	by router.isratech.ro (8.10.2/8.10.2) id eA8IrUg20360;
	Wed, 8 Nov 2000 20:53:30 +0200
Date: Wed, 8 Nov 2000 20:53:30 +0200
From: Mail Delivery Subsystem <MAILER-DAEMON@isratech.ro>
Message-Id: <200011081853.eA8IrUg20360@router.isratech.ro>
To: <octavp@isratech.ro>
MIME-Version: 1.0
Content-Type: multipart/report; report-type=delivery-status;
	boundary="eA8IrUg20360.973709610/router.isratech.ro"
Subject: Warning: could not send message for past 4 hours
Auto-Submitted: auto-generated (warning-timeout)
X-Mozilla-Status2: 00000000

This is a MIME-encapsulated message

--eA8IrUg20360.973709610/router.isratech.ro

    **********************************************
    **      THIS IS A WARNING MESSAGE ONLY      **
    **  YOU DO NOT NEED TO RESEND YOUR MESSAGE  **
    **********************************************

The original message was received at Wed, 8 Nov 2000 16:48:41 +0200
from calin.cs.tuiasi.ro [193.231.15.163]

   ----- The following addresses had transient non-fatal errors -----
<ralf@oss.sgi.com>

   ----- Transcript of session follows -----
<ralf@oss.sgi.com>... Deferred: oss.sgi.com.: No route to host
Warning: message still undelivered after 4 hours
Will keep trying until message is 5 days old

--eA8IrUg20360.973709610/router.isratech.ro
Content-Type: message/delivery-status

Reporting-MTA: dns; router.isratech.ro
Arrival-Date: Wed, 8 Nov 2000 16:48:41 +0200

Final-Recipient: RFC822; ralf@oss.sgi.com
Action: delayed
Status: 4.4.1
Remote-MTA: DNS; oss.sgi.com
Last-Attempt-Date: Wed, 8 Nov 2000 20:53:30 +0200
Will-Retry-Until: Mon, 13 Nov 2000 16:48:41 +0200

--eA8IrUg20360.973709610/router.isratech.ro
Content-Type: message/rfc822

Return-Path: <octavp@isratech.ro>
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id eA8EmfM31942
	for <ralf@oss.sgi.com>; Wed, 8 Nov 2000 16:48:41 +0200
Sender: nicu
Message-ID: <3A09D68C.AF1D5AAA@isratech.ro>
Date: Wed, 08 Nov 2000 17:41:16 -0500
From: Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: MIPS kernel!
References: <3A09753F.DB2457EE@isratech.ro> <004101c04969$b744b160$0323c0d8@Ulysses> <20001108151048.A13841@bacchus.dhis.org>
Content-Type: multipart/mixed;
 boundary="------------D4D29154E5C4E1D2C0F29A3E"

This is a multi-part message in MIME format.
--------------D4D29154E5C4E1D2C0F29A3E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:

> On Wed, Nov 08, 2000 at 10:53:14AM +0100, Kevin D. Kissell wrote:
>
> > In general, at MIPS, we generally build native or semi-native
> > (mipsel on mipseb machines and vice versa).  In cross-builds
> > of other components, however, I have observed that problems
> > such as those you describe can result from include files
> > on the host platform being erroneously pulled in to the cross-build.
> > Cross-gcc and the makefiles have been known to be set up such
> > that, if the needed include file can be found neither in the explicitly
> > requested directories nor in the cross-compiler's default includes,
> > it will silently search the host /usr/include directories.
>
> This is either a bug in the version that you're using, a wrongly installed
> compiled or simply wrong -I directives passed to the compiler.  The
> crosscompiler rpms as distributed on oss will only search:
>
>  /usr/lib/gcc-lib/mips-linux/egcs-2.91.66/include
>  /usr/mips-linux/include
>
> by default.  I just tried, egcs-1.1.2-2 also doesn't search silently in
> other directories.  So it's not a problem of gcc itself which leaves the
> makefiles.  If you find any instance of the wrong directories being
> searched, please tell me.  Or better, include a patch :-)
>
>   Ralf

Hello Ralf,

I managed to pass that stage with crosscompiler.
I managed to make the following thing
make CROSS_COMPILE=mips-linux-

and I get the follwing error.

mips-linux-ld -static -G 0 -T arch/mips/ld.script.big -Ttext 0x80100000
arch/mip
        --start-group \
        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o arch/mips/fpu_emulator/fpu_emulator.o \
        fs/filesystems.a \
        net/network.a \
        drivers/block/block.a drivers/char/char.a drivers/misc/misc.a
drivers/net/net.a drivers/scsi/scsi.a drivers/pci/pci.a \
        arch/mips/lib/lib.a /home/nicu/linux/lib/lib.a
arch/mips/atlas/kernel/atlaskern.a arch/mips/atlas/prom/atlasprom.a \
        --end-group \
        -o vmlinux
arch/mips/kernel/kernel.o: In function `__compute_return_epc':
branch.c(__ksymtab+0x70): undefined reference to `__mips_bh_counter'
drivers/net/net.a(8390.o): In function `ei_start_xmit':
8390.c(.text+0x304): undefined reference to `disable_irq_nosync'
8390.c(.text+0x304): relocation truncated to fit: R_MIPS_26
disable_irq_nosync
8390.c(.text+0x3a0): undefined reference to `disable_irq_nosync'
8390.c(.text+0x3a0): relocation truncated to fit: R_MIPS_26
disable_irq_nosync
make: *** [vmlinux] Error 1

Best Regards,
Nicu

--------------D4D29154E5C4E1D2C0F29A3E
Content-Type: text/x-vcard; charset=us-ascii;
 name="octavp.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Nicu Popovici
Content-Disposition: attachment;
 filename="octavp.vcf"

begin:vcard 
n:POPOVICI;Nicolae Octavian 
tel;cell:+40 93 605020
x-mozilla-html:FALSE
org:SC Silicon Service SRL;Software
adr:;;;;;;
version:2.1
email;internet:octavp@isratech.ro
title:Software engineer
x-mozilla-cpt:;0
fn:Nicolae Octavian POPOVICI
end:vcard

--------------D4D29154E5C4E1D2C0F29A3E--


--eA8IrUg20360.973709610/router.isratech.ro--

--------------52ED9AC7ABEF626DD11746EC
Content-Type: text/x-vcard; charset=us-ascii;
 name="octavp.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Nicu Popovici
Content-Disposition: attachment;
 filename="octavp.vcf"

begin:vcard 
n:POPOVICI;Nicolae Octavian 
tel;cell:+40 93 605020
x-mozilla-html:FALSE
org:SC Silicon Service SRL;Software
adr:;;;;;;
version:2.1
email;internet:octavp@isratech.ro
title:Software engineer
x-mozilla-cpt:;0
fn:Nicolae Octavian POPOVICI
end:vcard

--------------52ED9AC7ABEF626DD11746EC--
