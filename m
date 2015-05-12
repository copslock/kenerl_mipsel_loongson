Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2015 18:26:18 +0200 (CEST)
Received: from resqmta-po-10v.sys.comcast.net ([96.114.154.169]:49765 "EHLO
        resqmta-po-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013148AbbELQ0QgO69x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2015 18:26:16 +0200
Received: from resomta-po-10v.sys.comcast.net ([96.114.154.234])
        by resqmta-po-10v.sys.comcast.net with comcast
        id T4Ry1q00753iAfU014SBEX; Tue, 12 May 2015 16:26:11 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-po-10v.sys.comcast.net with comcast
        id T4S91q00T42s2jH014SA0y; Tue, 12 May 2015 16:26:11 +0000
Message-ID: <55522998.7090208@gentoo.org>
Date:   Tue, 12 May 2015 12:26:00 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: IP28: "Inconsistent ISA" messages during kernel build
References: <55516EF3.7010706@gentoo.org> <5551B894.9000204@imgtec.com>
In-Reply-To: <5551B894.9000204@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47347
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

On 05/12/2015 04:23, Markos Chandras wrote:
> On 05/12/2015 04:09 AM, Joshua Kinard wrote:
>>
>> Has anyone tried to build an IP28 kernel lately?  I've been getting quite a few
>> warnings out of the linker regarding e_flags and the new .MIPS.abiflags stuff.
>>  Not seen it on the other SGI platforms, so I am assuming this has something to
>> do with what flags are passed to the compiler/linker.
>>
>> mips64-unknown-linux-gnu-ld: fs/ext4/symlink.o: warning: Inconsistent ISA
>> between e_flags and .MIPS.abiflags
>> mips64-unknown-linux-gnu-ld: fs/ext4/symlink.o: warning: Inconsistent ISA
>> extensions between e_flags and .MIPS.abiflags
>>
>> Seeing this on a build of 4.0.2 based off of a 20150418 checkout from git.
>>
>> --J
>>
> Hi,
> 
> I presume you are using binutils >= 2.25? I have seen this problem in my
> local build tests as well and I discussed this with Matthew (now on CC).
> It seems it's an 'innocent' warning added to binutils 2.25 but I am not
> sure if this is now fixed or not. Matthew might be able to provide more
> information.

Yup, binutils-2.25.  My guess, going by Matthew's description of the XLR, may
be related to one of the fields storing "mips4" as the -march, and the other
field storing "r10000".  I haven't looked at the ELF sections yet, though, to
verify that.  Since I am not seeing this on the other platforms (IP27, IP30, &
IP32), I'm guessing it's possibly something in the arch/mips/Makefile then?

At least it's harmless, but it does clutter the screen up with a ton of warnings.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
