Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 20:30:15 +0000 (GMT)
Received: from rwcrmhc11.comcast.net ([IPv6:::ffff:204.127.198.35]:18917 "EHLO
	rwcrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8225581AbUAVUaO>; Thu, 22 Jan 2004 20:30:14 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (rwcrmhc11) with SMTP
          id <20040122203007013008n8iae>
          (Authid: kumba12345);
          Thu, 22 Jan 2004 20:30:07 +0000
Message-ID: <4010334A.5050500@gentoo.org>
Date: Thu, 22 Jan 2004 15:32:10 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Solving the cross-compiler issue (Was: Trouble compiling MIPS
 cross-compiler)
References: <Pine.LNX.4.44.0401211633240.31973-101000@zcar.ghs.com>
In-Reply-To: <Pine.LNX.4.44.0401211633240.31973-101000@zcar.ghs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Nathan Field wrote:

> This email is a bit long so here's the short version:
> 	Building cross tools is basically impossible without knowledge 
> which isn't available on the www.linux-mips.org web site
> 	glibc seems to have obvious syntax errors and won't even compile
> 	The prebuilt tools referenced in the FAQ are so out of date 
> they're useless
> 	Even tools provided by various commercial Linux vendors are out of 
> date (at least what MontaVista lets us see in their preview kits)
> 	This could all be solved if someone wrote a script to do all the 
> work which contains all the logic necessary to get a known set of tools to 
> build
> 
> I've written a script which will do all the work, but because there are 
> failures in building glibc it doesn't work. If someone could help me get 
> my script to work it could be used to update the cross compile section of 
> the FAQ. The script as it stands is attached. It needs some configuration 
> (which is why it exits by default), but if you're trying to build a cross 
> compiler you'd better have at least some knowledge of what you're doing.
> 
> Here's what it does:
> 	it wgets specific versions of binutils, gcc and glibc
> 	it sets some environment variables
> 	it uncompresses and builds the tools in the "correct" sequence 
> with the correct options
> 
> There are 2 problems with this script:
> 	1. It references a specific binutils snapshot which will probably 
> go away in a few days
> 	2. It doesn't f'ing work
> 
> That said, here's where things are breaking:
> 
> I'm also trying to build a newer cross toolchain since MontaVista doesn't
> seem to provide one recent enough to even build the linux_2_4 branch from
> the linux-mips cvs repository (it builds, but when I run it on my Malta
> board it crashes immediately). I'm coming up against problems that just
> seem stupidly obvious... Enough ranting though, here are the details.
> 

I also coded my own cross-compiler script, which is partially integrated 
with gentoo's package management system, portage.  It uses the portage 
API to determine the most recent version, download, and patch sources, 
then the script takes over the building process.  It's not flawless, but 
it does work for generating mips[el] cross-compilers on i686 and 
linux-sparc64 hosts (among other targets).

If anyone runs gentoo, it's available as sys-devel/crossdev in the 
portage tree.


> Kumba suggested using:
> 
>>I'd recommend the following:
>>binutils-2.14.90.0.7 (or you can try the latest .8 release, it has some 
>>more mips fixes in it)
>>glibc-2.3.2 (or 2.3.1)
>>gcc-3.3.2
> 
> 	I couldn't find a version of binutils like that, so I grabbed 
> yesterdays snapshot, which builds and runs fine. Then I built the gcc 
> bootstrap fine. Then I tried building glibc-2.3.2. That failed when it got 
> to stdio-common/sscanf. The declaration of sscanf:

That version of binutils is a linux-only release maintained by HJ Lu. 
He even announces new versions to this list.  You can find all the 
versions of this specific branch of binutils at:
http://www.kernel.org/pub/linux/devel/binutils/


> sscanf (s, format)
>      const char *s;
>      const char *format;
> 
> Doesn't match the function, and it should be:
> 
> sscanf (const char *s, const char *format, ...)
> 
> Does no one even bother to test to see if these things compile before they 
> are released? I've had similar syntax error type problems when building 
> several older (2.2.x) versions of glibc for PPC.

This was a bug in early versions of glibc I believe, and is fixed in any 
modern glibc checkout you do from the libc-alpha CVS.


> Anyway, after I fixed that I now get a link failure:
> 
> /space1/ndf/linux/mips/tools/glibc-build/elf/ld.so.1: undefined reference 
> to `elf_machine_rela.7'
> 
> The command which generates this is:

[snip]

> Interestingly when I try glibc 2.3.1 I get the same syntax error in sscanf 
> but the linker complains about elf_machine_rela, without the .7.
> 
> It would be wonderful if I could get some help on this. It seems like a
> chicken and egg problem which will only get worse as more and more people
> try to build the 2.6 kernels.

Another glibc bug, also fixed in modern CVS.  The patch that does fix 
the issue is here:
http://honk.physik.uni-konstanz.de/linux-mips/glibc/patches/applied/elf-machine-rela-mips.dpatch



--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
