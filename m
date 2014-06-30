Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jun 2014 21:17:52 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:57167 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859944AbaF3TRuNTgAw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Jun 2014 21:17:50 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 6A9AB19C01C;
        Mon, 30 Jun 2014 22:17:49 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id fDalMEdzAbE3; Mon, 30 Jun 2014 22:17:42 +0300 (EEST)
Received: from drone (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id C75505BC004;
        Mon, 30 Jun 2014 22:17:42 +0300 (EEST)
Date:   Mon, 30 Jun 2014 22:17:42 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 0/3] MIPS: OCTEON: Minimal support for D-Link DSR-1000N
Message-ID: <20140630191742.GA681@drone.musicnaut.iki.fi>
References: <1403987650-6194-1-git-send-email-aaro.koskinen@iki.fi>
 <53B19B0E.8000702@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53B19B0E.8000702@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

On Mon, Jun 30, 2014 at 10:14:54AM -0700, David Daney wrote:
> On 06/28/2014 01:34 PM, Aaro Koskinen wrote:
> >The following patches add minimal support for D-Link DSR-1000N router.
> 
> Which OCTEON chip does this device contain?

[    0.000000] CPU0 revision is: 000d0601 (Cavium Octeon+)

# cat /proc/cpuinfo
system type             : CUST_DSR1000N (CN5010p1.1-500-SCP)
machine                 : Unknown
processor               : 0
cpu model               : Cavium Octeon+ V0.1
BogoMIPS                : 1000.00
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 64
extra interrupt vector  : yes
hardware watchpoint     : yes, count: 2, address/irw mask: [0x0ffc, 0x0ffb]
isa                     : mips1 mips2 mips3 mips4 mips5 mips64r2
ASEs implemented        :
shadow register sets    : 1
kscratch registers      : 0
core                    : 0
VCED exceptions         : not available
VCEI exceptions         : not available

> Also what is the bootloader version on the board?

D-Link DSR-1000N bootloader# version

U-Boot 1.1.1 (Development build, svnversion: exported) (Build time: Mar 22 2010
- 12:14:14)

BTW, .notes segment from kernel needs to be removed for this bootloader
with "strip -R .notes".

A.
