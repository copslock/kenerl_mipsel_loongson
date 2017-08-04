Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Aug 2017 04:05:02 +0200 (CEST)
Received: from resqmta-po-02v.sys.comcast.net ([IPv6:2001:558:fe16:19:96:114:154:161]:41048
        "EHLO resqmta-po-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994928AbdHDCEzPnH1U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Aug 2017 04:04:55 +0200
Received: from resomta-po-12v.sys.comcast.net ([96.114.154.236])
        by resqmta-po-02v.sys.comcast.net with ESMTP
        id dRyidhHDfRvmJdRyrd4fGc; Fri, 04 Aug 2017 02:04:49 +0000
Received: from [192.168.1.13] ([73.201.189.102])
        by resomta-po-12v.sys.comcast.net with SMTP
        id dRyqdUoARcQv5dRyqdWHSo; Fri, 04 Aug 2017 02:04:49 +0000
Subject: Re: Update PS2 R5900 to kernel 4.x?
To:     Fredrik Noring <noring@nocrew.org>
Cc:     linux-mips@linux-mips.org
References: <A4F10467-06DE-4880-B740-10B32CAC9208@nocrew.org>
 <0d0fdd50-929f-da92-dd35-88f2878da8c2@gentoo.org>
 <64C2A7A5-46FD-406C-9B51-5F45AEBA70F0@nocrew.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <b0356404-42b6-6e8b-e15b-57cf98b7d6e6@gentoo.org>
Date:   Thu, 3 Aug 2017 22:04:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <64C2A7A5-46FD-406C-9B51-5F45AEBA70F0@nocrew.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfO+eM1xkZHsvZd35Q8QTCvTla1u0LRVyUABwgD9of13ruuKJwwtWXZSOz9lCuV1a9MtjFWPuZroeyVAt4iUNu3P3c7dLaU8VGVNrvPBgnFCGXqNr5lPu
 kVBFwLdbSHjHiqLSr3ZkDGGWnhamRMpm12wsFQRLK7V/b2in9cVdgGQ4RmwyEDN16BWzpqwqvlw3aHRT1QjONHesByrUmCPvtdk=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59357
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

On 08/03/2017 12:09, Fredrik Noring wrote:
> Hi Joshua!
> 
>> 3 aug. 2017 kl. 16:25 skrev Joshua Kinard <kumba@gentoo.org>:
>>
>> Didn't the PS2 kernel need a lot of userland changes and a special toolchain to
>> deal with the hybrid nature of the R5900?
> 
> It depends, as I understand it. R5900 implements 64-bit MIPS III except LL, SC,
> LLD and SCD, plus many extensions. Some instructions are emulated by the
> kernel for compatibility, see changes to arch/mips/kernel/traps.c:
> 
>     https://github.com/frno7/linux/blob/ps2-v3.9-rc1-974fdb3/arch/mips/kernel/traps.c#L613

I forgot about the lack of LL/SC on that CPU.  Those are MIPS-II instructions,
though, so I'd think that if the R5900 is MIPS-III + some MIPS-IV, that it
would've had LL/SC, especially since Toshiba fabbed the chip?  I wonder why
they or Sony would've omitted those instructions.


> Since emulation is slow and R5900 has 128-bit load/store instructions, some
> (optional) extensions were made:
> 
>     config R5900_128BIT_SUPPORT
>         bool "Support for 128 bit general purpose registers”
> 
>     config MIPS_N32
>         bool "Kernel support for n32 binaries”

The 128-bit register support likely needs the toolchain help, since uint128_t
has only recently shown up in gcc I think?


> Then there is a set of hardware bugs involving NOPs to avoid short loops, SYNCs
> for MFC0 and MTC0, etc. Several updates address these. Jürgen Urban worked on
> both the kernel and binutils about five years ago:
> 
>     https://sourceware.org/ml/binutils/2012-11/msg00360.html
> 
> I suspect the reason it crashes on 3.9 is that some of the changes are way out
> of synch with the rest of the kernel since 2.6.35, even if the patch applies
> fairly easily.

Am not knowledgeable here, unfortunately.  If you have a Oops report and can
trace through a debugger and look at the underlying asm, that might highlight
something.  I've not had a lot of luck doing that on my SGI systems though.


>> Do you have a working userland that can run under the 3.9 kernel?
> 
> I started with the ”Black Rhino” (Debian) distribution and its Busybox, which
> boots with 3.8, but I was actually hoping to get Gentoo MIPS working, as I’ve
> seen you have stage 3 MIPS binaries. What are your thoughts on this?

Could be doable.  I forget, was PS2 big -endian or little-endian?  I primarily
work with big-endian these days due to my SGI systems.  I've got recent stage
builds at several different ABI/ISA combos and even a working netboot
filesystem.  Haven't had time to get kernels rolled yet (IP27 always spoils the
fun).


>> Last I heard, the latest kernel that would work
>> on PS2 was a Sony-modified ~2.4.17 that was put out for some kind of
>> specialized PS2 hardware found only in Japan.
> 
> I have a normal SCPH-70004 unit and as far as I understand the majority of the
> manufactured PS2 units work (the last ones excepted). A slightly tricky part is
> installing a boot loader (e.g. Free MC boot) on a memory card. No modifications
> such as soldering is required.

I have one of the PS2 debug machines in a closet somewhere.  Basically a normal
PS2 with 4x RAM and says "TEST" on the side in the PS2 font.  Can't remember if
it still works or not.

And it's insanely way out of date for modern Gentoo (by ~14 years), but I keep
an archive of the original attempt to run Gentoo on a PS2 from ~2003 here:
http://dev.gentoo.org/~kumba/mips/ps2/gentoo-ps2/

The "ps2dev.diff.bz2" patch might be of interest, as it has the changes for the
toolchain in it.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
