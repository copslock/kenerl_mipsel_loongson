Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0T342811314
	for linux-mips-outgoing; Mon, 28 Jan 2002 19:04:02 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0T33hP11278
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 19:03:44 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g0T23eX24073;
	Mon, 28 Jan 2002 18:03:40 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Pete Popov" <ppopov@pacbell.net>
Cc: "linux-mips" <linux-mips@oss.sgi.com>
Subject: RE: Help with OOPSes, anyone?
Date: Mon, 28 Jan 2002 18:03:40 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIIEBLCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <1012262087.8518.174.camel@zeus>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Well, more data.

2.4.0 won't boot.  What I get on the serial console is:

PMON> boot 192.168.1.1:/tftpboot/mdharm/vmlinux-2.4.0
Loading file: 192.168.1.1:/tftpboot/mdharm/vmlinux-2.4.0 (elf)
0x80100000/1490576 + 0x8026be90/127504(z) + 4094 syms\
Entry address is 801005a8
PMON> g
Linux version 2.4.0 (mdharm@GoldenGate) (gcc version egcs-2.91.66
19990314 (egcs-1.1.2 release)) #1 Mon Jan 28 16:37:45 PST 2002
Determined physical RAM map:
 memory: 08000000 @ 00000000 (usable)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line:

and then it just stops.  Go figure.

2.4.5 crashes, but in a different way.  Now I get a stream of:

Got ibe at 2ab60b3c.
Instruction bus error, epc == 2ab60b3c, ra == 2ab5fcac

Over and over again.  I should say the system didn't actually crash,
but every command I run at the shell gives a Segmentation Fault.  And,
even when I'm not trying to run applications, the above message is
streaming out the serial port.

2.4.10 also does something bad.  Rebuilding ncftp causes a bus error
during the compilation process.  As with 2.4.5, no applications will
now run, but this time they all give "Illegal Instruction (core
dumped)".  Nothing appeared on the serial console.

2.4.14 crashes with the following OOPS (decoded for your enjoyment):

ksymoops 2.4.0 on mips 2.4.14.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.14/ (default)
     -m System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 00000020,
epc == 80128228, ra == 80123c28
$0 : 00000000 1000ee88 00000177 81209a20 8129fa80 00000067 2ab06000
00000000
$8 : 90045401 1000001f 00000000 802635a8 00000000 8025b840 87407e90
81205b64
$16: 00000000 00000067 86f54e40 00000000 86dbc520 86f54e40 2ab6d000
00000177
$24: 00000001 006b6c30                   86d20000 86d21dd8 7fd73d98
80123c28
epc  : 80128228    Not tainted
Using defaults from ksymoops -t elf32-tradbigmips -a mips:3000
Status: 90045403
Cause : 00008008
Process cc1 (pid: 3465, stackpage=86d20000)
Stack: 80123b70 7fd75db8 7fd74dc8 7fd74db8 00000000 2ab6d000 86f54e40
86318140
       00000000 86181db4 2ab6d000 8631815c 7fd73d98 80123c28 86d21e78
7fd74db8
       0070c248 86d21f30 7fd71ca8 00000000 00000000 2ab6d000 86318140
00000000
       86f54e40 86d21f30 00000000 80123df0 86f54720 86d20000 8631815c
00000045
       86181db4 ffffffff 86f54e40 86d20000 8631815c 2ab6d000 86318140
8010fcb4
       0000000b ...
Call Trace: [<80123b70>] [<80123c28>] [<80123df0>] [<8010fcb4>]
[<8011db50>] [<8011dc90>]
 [<8011e0e0>] [<8010d76c>] [<80110b98>] [<8010a760>]
Warning (Oops_read): Code line not seen, dumping what data is
available

>>RA;  80123c28 <do_no_page+7c/1c0>
>>PC;  80128228 <filemap_nopage+64/304>   <=====
Trace; 80123b70 <do_anonymous_page+110/14c>
Trace; 80123c28 <do_no_page+7c/1c0>
Trace; 80123df0 <handle_mm_fault+84/144>
Trace; 8010fcb4 <do_page_fault+17c/398>
Trace; 8011db50 <deliver_signal+24/90>
Trace; 8011dc90 <send_sig_info+d4/120>
Trace; 8011e0e0 <send_sig+18/24>
Trace; 8010d76c <do_IRQ+ac/114>
Trace; 80110b98 <nopage_tlbl+f4/fc>
Trace; 8010a760 <signal_return+1c/3c>

And 2.4.17 with the wait instruction turned off still crashes.

The Montavista kernel (which claims to be 2.4.0 #5 build by jsun)
seems to work...  I've done several recompiles on it, and lots of I/O
traffic with no problems.  Unfortunatly, I don't have the source code
to this particular kernel... tho I believe that Montavista is required
to release their source cod by the GPL.

Tho here's a question:  What is the best compiler to build a kernel
with?  I've built all mine with egcs-2.91.66 which I downloaded from
oss.sgi.com a while ago.

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: Pete Popov [mailto:ppopov@pacbell.net]
> Sent: Monday, January 28, 2002 3:55 PM
> To: Matthew Dharm
> Cc: linux-mips
> Subject: RE: Help with OOPSes, anyone?
>
>
> On Mon, 2002-01-28 at 15:31, Matthew Dharm wrote:
> > Well, here's the latest test results...
> >
> > The 2.4.0 kernel from MontaVista seems to work just fine.
>  Of course,
> > it doesn't have support for the full range of interrupts,
> but that's a
> > separate matter.  But it doesn't crash under big compiles.
>
> 2.4.0 from MontaVista? Do you mean the very first release, which was
> 2.4.0-test9?
>
> > 2.4.17 with CONFIG_MIPS_UNCACHED crashes.  It takes
> longer, but that
> > may just be a function of it running so much slower.  The BogoMIPS
> > drops by a factor of 100.  Ouch.
> >
> > So it doesn't look like a cache problem after all.  And it does
> > suggest that something introduced between 2.4.0 and .17
> is what broke
> > things.  But what that is, I have no idea.
> >
> > I'm going to try Jason's modified cache code just in
> case, but I doubt
> > that will change anything.  We'll have to see, tho.
> >
> > Does anyone have any other suggestions to try?  I'm
> starting to wonder
> > if perhaps the PROM isn't setting up the SDRAM properly, but that
> > conflicts with the working 2.4.0 kernel -- the PROM is the same in
> > both cases, so I would expect a PROM error to affect both
> versions.
> >
> > I'm running out of ideas here... anyone?
>
> If you're absolutely sure 2.4.0-test9 doesn't crash (you
> ran the test
> "enough" times), perhaps you can start testing kernels
> between 2.4.0 and
> 2.4.17.   And, you did get rid of the 'wait' instruction in 2.4.17,
> right ;-)?
>
> Pete
>
