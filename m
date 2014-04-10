Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2014 05:02:32 +0200 (CEST)
Received: from qmta15.westchester.pa.mail.comcast.net ([76.96.59.228]:39651
        "EHLO qmta15.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821115AbaDJDC2uhu3b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Apr 2014 05:02:28 +0200
Received: from omta06.westchester.pa.mail.comcast.net ([76.96.62.51])
        by qmta15.westchester.pa.mail.comcast.net with comcast
        id o2rC1n00316LCl05F32LvE; Thu, 10 Apr 2014 03:02:20 +0000
Received: from [192.168.1.13] ([50.190.84.14])
        by omta06.westchester.pa.mail.comcast.net with comcast
        id o32L1n0050JZ7Re3S32Lrl; Thu, 10 Apr 2014 03:02:20 +0000
Message-ID: <534609B2.5070808@gentoo.org>
Date:   Wed, 09 Apr 2014 23:02:10 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed
 option -mr10k-cache-barrier=store.  Stop.
References: <534138d9.RISUZQYUMS8U8s42%fengguang.wu@intel.com> <20140409051929.GA29246@localhost> <20140409082445.GC1438@pax.zz.de> <20140409133229.GA22315@alpha.franken.de> <20140409231345.GC8370@localhost> <5345DB6A.7060004@gentoo.org> <20140410003806.GV17197@linux-mips.org>
In-Reply-To: <20140410003806.GV17197@linux-mips.org>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1397098940;
        bh=zsIEtfTqdB2nzrv0uJfG0meOJgWc4ccz9dkVdM3WCmw=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=G3yK2c+yNiww7T7huomtv7r7cv04Q11ip3QaPDclF/ufdK7D6jq+MXzigXSmnRBrY
         kxeI5KH8RgR5pw27IXhipntCOJhx0tQEwwNMJPI4H90NyIu2qnwq3rBSUtcdzRXJtN
         Qz7Vq3rjngsSw/LfpKYlgfT38t2OMeUNkSQmNDzMODXVjxrwmCqydvHsqnR/E5Xeg9
         m7t55ONGTOU5bT22BpKeT+1uxmG1K09fkIbsNkovAICp9NTXCKBiyG57DfHy9QVFQy
         tet3dBPCEaby45ZY1l8PRlD4Ep8FDlSV2Uhmh0aBmcCrSOkfHL2SqAZ661g7+kVL6e
         evVlJb79lDxWw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 04/09/2014 20:38, Ralf Baechle wrote:
> On Wed, Apr 09, 2014 at 07:44:42PM -0400, Joshua Kinard wrote:
> 
>> If you weren't using a mips64 compiler, that's probably the issue.  R10000
>> processors are 64-bit only, so a 'mips' toolchain probably doesn't include
>> the R10K cache-barrier code, causing that option to fail.
> 
> No - there's no mode switch.  An R10000 will happily run 32-bit code
> otherwise 32 bit kernels wouldn't work.  32 bit code just doesn't use
> 64 bit addressing, instructions or the upper 32 bit of the 64 bit registers.
> 
> $ mips-linux-gcc -mr10k-cache-barrier=store -c -O2 -o c.o c.c
> c.c:1:0: error: ‘-mr10k-cache-barrier’ requires a target that provides the ‘cache’ instruction
> [...]
> 
> When adding an option like -mips32 the compilation will succeed.

Odd, I thought R10K systems were locked to booting 64-bit kernels only.  At
least the Octane was when it was bootable.  Not sure about IP27.

Maybe that's another one of ARCS' ingenious features...


>> Are you configuring for IP22 (Indy, Indigo2 R4x00), or IP28 (R10000)?  Note,
>> IP26 (R8000) is not supported in Linux.  I think OpenBSD got it working, though.
> 
> Wish I'd have a box ....

They do pop up on eBay from time-to-time.  UPS destroyed the case mine came
in, though.  I've got it in a closet, with duct tape holding the teal skins
on.  It does boot to the PROM, but the RTC is probably dead by now.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
