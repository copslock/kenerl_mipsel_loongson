Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBHM9Tp01737
	for linux-mips-outgoing; Mon, 17 Dec 2001 14:09:29 -0800
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBHM9Lo01733
	for <linux-mips@oss.sgi.com>; Mon, 17 Dec 2001 14:09:21 -0800
Received: from excalibur.cologne.de (pD9511206.dip.t-dialin.net [217.81.18.6])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id WAA23874;
	Mon, 17 Dec 2001 22:04:51 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 16G580-0001lG-00; Mon, 17 Dec 2001 22:16:52 +0100
Date: Mon, 17 Dec 2001 22:16:52 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Cc: ralf@gnu.org
Subject: Re: New style irqs for DEC
Message-ID: <20011217221652.A6765@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@oss.sgi.com, linux-mips@fnet.fr, ralf@gnu.org
References: <20011217172741.A2316@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011217172741.A2316@dea.linux-mips.net>; from ralf@uni-koblenz.de on Mon, Dec 17, 2001 at 05:27:41PM -0200
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Dec 17, 2001 at 05:27:41PM -0200, Ralf Baechle wrote:

> below is my attempt at fixing interrupts for DECstation against the
> latest 2.4.  Can you give it a try?

Gives the following on a DECstation 5000/20 (R3k):

------------------------------------------------------------------------------
>>boot 3/tftp root=/dev/sda5 console=ttyS0
1527808+0+79696
This DECstation is a Personal DS5000/xx
CPU revision is: 00000230
FPU revision is: 00000340
Primary instruction cache 64kb, linesize 4 bytes
Primary data cache 64kb, linesize 4 bytes
Linux version 2.4.16 (karsten@excalibur) (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)) #1 Mon Dez 17 21:43:00 CET 2001
Determined physical RAM map:
 memory: 02800000 @ 00000000 (usable)
On node 0 totalpages: 10240
zone(0): 10240 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda5 console=ttyS0
Calibrating delay loop... 19.82 BogoMIPS
Memory: 38484k/40960k available (1284k kernel code, 2476k reserved, 137k data, 64k init)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
TURBOchannel rev. 1 at 12.5 MHz (without parity)
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starti<1>Unable to handle kernel paging request at virtual address 00000000, epc == 00000000, ra == 8005c84c
Oops in fault.c:do_page_fault, line 204:
$0 : 00000000 1000a801 00000000 000000cd 801928c8 00090f96 8019dcf4 00000000
$8 : 801a05b8 801a0420 00000800 00000800 00000000 00000000 801ee250 fffffffb
$16: 801928c8 000400f7 7fe11ffe 1000a800 8019cf00 80192860 0000003c 00000010
$24: ffffffff 00000020                   801fc000 801fdd48 0c00b620 8005c84c
Hi : 0000000f
Lo : 765e2000
epc  : 00000000    Not tainted
Status: 1000a804
Cause : 00000008
Process swapper (pid: 1, stackpage=801fc000)
Stack: 801a064c 8004def8 fffffffe 1000a800 80192000 801a064c 00000000 fffffffb
       801fdda0 0000003e 8004e244 8004e1f0 00000002 80068188 8019e884 8019ea7c
       fffffff5 000026f0 801ad6d0 0000006e 0000000a 800cabf0 00000001 8005d2b0
       8019e884 8019ea7c 000001f0 801fdf40 00000000 801a0000 ffffffff 00000078
       ffffffff 000d1b70 00012e00 bc100001 00012e00 00012e00 00000018 fffffff0
       00000000 ...
Call Trace: [<8004def8>] [<8004e244>] [<8004e1f0>] [<80068188>] [<800cabf0>] [<8005d2b0>]
 [<80055964>] [<80055754>] [<800f9334>] [<800f9394>] [<8005d2b0>] [<800f9690>]
 [<8004c980>] [<80056974>] [<800ab1a8>] [<800ab16c>] [<80056a10>] [<80056b4c>]
 [<80056fdc>] [<8004804c>] [<80056e68>] [<8015a070>] [<8004804c>] [<8015a060>]
 [<80068510>] [<8016eefc>] [<8004804c>] [<8004805c>] [<800570e8>] [<80047e14>]
 [<8004897c>] [<80048020>] [<80056e68>] [<8004896c>]

Code: (Bad address in epc)

Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
------------------------------------------------------------------------------

Greetings,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
meinungsforschung.
