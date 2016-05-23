Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 17:15:58 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:56226 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033448AbcEWPP5QmmCu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 May 2016 17:15:57 +0200
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd001.nsn-inter.net (8.15.2/8.15.2) with ESMTPS id u4NFFpcE025766
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 23 May 2016 15:15:51 GMT
Received: from ak-desktop.emea.nsn-net.net ([10.144.36.118])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with SMTP id u4NFFnUZ025055;
        Mon, 23 May 2016 17:15:49 +0200
Received: by ak-desktop.emea.nsn-net.net (sSMTP sendmail emulation); Mon, 23 May 2016 18:13:46 +0300
Date:   Mon, 23 May 2016 18:13:46 +0300
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: THP broken on OCTEON?
Message-ID: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 3331
X-purgate-ID: 151667::1464016551-00001B3D-A053FEBF/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nokia.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi,

I'm getting kernel crashes (see below) reliably when building Perl in
parallel (make -j16) on OCTEON EBH5600 board (8 cores, 4 GB RAM) with
Linux 4.6.

It seems that CONFIG_TRANSPARENT_HUGEPAGE has something to do with the
issue - disabling it makes build go through fine.

Any ideas?

A.

[ 2457.467155] Got mcheck at 00000001200a82b4
[ 2457.479447] CPU: 6 PID: 15916 Comm: lib/unicore/mkt Not tainted 4.6.0-octeon-distro.git-v2.16-1-gfc3b10e-dirty-00001-g16a7aa0 #1
[ 2457.514121] task: 80000000eccf2b80 ti: 80000000ecda4000 task.ti: 80000000ecda4000
[ 2457.536551] $ 0   : 0000000000000000 3e000000105bc006 0000000000000000 ffffffff957e4728
[ 2457.560686] $ 4   : 00000000000000f2 0000000000000067 000000012015e8ab 00000000332295cf
[ 2457.584822] $ 8   : 0000000000000000 0000000000000000 0000000000000001 0000000000000003
[ 2457.608957] $12   : 00000001204e04d8 0000000000000008 0000000000000001 ffffffffffffffff
[ 2457.633093] $16   : 0000000120383d60 00000001203a3828 00000000332295cf 000000000000000b
[ 2457.657228] $20   : 000000012015e8a0 0000000000000000 000000000000000c 0000000000000000
[ 2457.681363] $24   : 0000000000000010 00000001200a80e8                                  
[ 2457.705496] $28   : 00000001201a0300 000000ffffda82a0 000000012019b9b8 0000000120039f5c
[ 2457.729631] Hi    : 0000000000000000
[ 2457.740341] Lo    : 0000000000000008
[ 2457.751055] epc   : 00000001200a82b4 0x1200a82b4
[ 2457.764891] ra    : 0000000120039f5c 0x120039f5c
[ 2457.778726] Status: 00308cf3	KX SX UX USER EXL IE 
[ 2457.793284] Cause : 00800060 (ExcCode 18)
[ 2457.805296] PrId  : 000d0409 (Cavium Octeon+)
[ 2457.818350] Index    : 80000000
[ 2457.827759] PageMask : 1fe000
[ 2457.836646] EntryHi  : 00000001203820f4
[ 2457.848136] EntryLo0 : 00000000105b8006
[ 2457.859628] EntryLo1 : 00000000105bc006
[ 2457.871119] Wired    : 0
[ 2457.878704] PageGrain: e0000000
[ 2457.888111] 
[ 2457.892573] Index: 25 pgmask=4kb va=00120456000 asid=f4
[ 2457.908256] 	[ri=0 xi=0 pa=000e47d3000 c=0 d=1 v=1 g=0] [ri=0 xi=0 pa=000c31bc000 c=0 d=1 v=1 g=0]
[ 2457.935230] Index: 26 pgmask=4kb va=001200a8000 asid=f4
[ 2457.950915] 	[ri=0 xi=0 pa=000e0e1c000 c=0 d=0 v=1 g=0] [ri=0 xi=0 pa=000c50ed000 c=0 d=0 v=1 g=0]
[ 2457.977888] Index: 27 pgmask=4kb va=001203a2000 asid=f4
[ 2457.993574] 	[ri=0 xi=0 pa=00000000000 c=0 d=0 v=0 g=0] [ri=0 xi=1 pa=0009005a000 c=1 d=0 v=1 g=0]
[ 2458.020548] 
[ 2458.025008] 
Code: de100000  1200001c  00000000 <de110008> 8e220000  1452fffa  00000000  8e220004  1453fff7 
[ 2458.054470] Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB.
[ 2458.087614] ---[ end Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB.
[ 2458.122835] 
do_page_fault(): sending SIGSEGV to make for invalid write access to 0000000000000012[ 2458.149565] 
[ 2458.149565] do_page_fault(): sending SIGSEGV to miniperl for invalid write access to 0000000000000010epc = 0000000120089500 in miniperl[120000000+181000]ra  = 00000001200c18a4 in miniperl[120000000+181000][ 2458.149590] 

[ 2458.212999] epc = 0000000120015400 in make[120000000+35000]
[ 2458.229780] ra  = 000000ffeca7f570 in[ 2458.240797] 

*** NMI Watchdog interrupt on Core 0x0 ***

A.
