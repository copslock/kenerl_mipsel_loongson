Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2007 17:47:12 +0100 (BST)
Received: from post1.wesleyan.edu ([129.133.6.131]:20953 "EHLO
	post1.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20024431AbXEVQrH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 May 2007 17:47:07 +0100
Received: from pony2.wesleyan.edu (pony2.wesleyan.edu [129.133.6.193])
	by courier1.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l4MGkwIc001883
	for <linux-mips@linux-mips.org>; Tue, 22 May 2007 12:46:58 -0400
Received: from pony2.wesleyan.edu (pony2.wesleyan.edu [127.0.0.1])
	by pony2.wesleyan.edu (8.12.11.20060308/8.12.11) with ESMTP id l4MGkwdL002921
	for <linux-mips@linux-mips.org>; Tue, 22 May 2007 12:46:58 -0400
Received: (from apache@localhost)
	by pony2.wesleyan.edu (8.12.11.20060308/8.12.11/Submit) id l4MGkvkH002917;
	Tue, 22 May 2007 12:46:57 -0400
Received: from 129.133.92.31
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Tue, 22 May 2007 12:46:57 -0400 (EDT)
Message-ID: <33252.129.133.92.31.1179852417.squirrel@webmail.wesleyan.edu>
In-Reply-To: <20070522151848.GB19833@networkno.de>
References: <20070516151939.GH19816@deprecation.cyrius.com>
    <20070516160313.GA3409@bongo.bofh.it>
    <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org>
    <20070517151636.GJ3586@deprecation.cyrius.com>
    <20070521154726.GE5943@linux-mips.org>
    <20070522110956.GB29118@linux-mips.org>
    <1179834093.7896.23.camel@scarafaggio>
    <34888.129.133.92.31.1179835313.squirrel@webmail.wesleyan.edu>
    <20070522122808.GD32557@linux-mips.org>
    <36324.129.133.92.31.1179840724.squirrel@webmail.wesleyan.edu>
    <20070522151848.GB19833@networkno.de>
Date:	Tue, 22 May 2007 12:46:57 -0400 (EDT)
Subject: Cross-Compile difficulties
From:	sknauert@wesleyan.edu
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Wesleyan-MailScanner-Information: Please contact the ISP for more information
X-Wesleyan-MailScanner:	Found to be clean
X-MailScanner-From: sknauert@wesleyan.edu
Return-Path: <sknauert@wesleyan.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

> sknauert@wesleyan.edu wrote:
>> > On Tue, May 22, 2007 at 08:01:53AM -0400, sknauert@wesleyan.edu wrote:
>> >
>> >> I've noticed that besides kernel complied from the Debian 2.6.18, I
>> >> can't
>> >> get any other kernel (vanilla from kernel.org or the separate
>> linux-MIPS
>> >> repository) to boot on my O2.
>> >>
>> >> If you need beta testers, I can try, but it will take a day or so
>> >> (compiling on the O2 is slow).
>> >
>> > Sounds almost like you're building an excessibly large kernel
>> > configuration.
>> > A realistic kernel config will crosscompile within a few minutes on a
>> > modest machine such as a 3GHz / 1GB P4-class PC.
>> >
>>
>> I could never get cross-compiling to work, so I've been doing all my
>> compiling directly on the R5K 300 Mhz CPU in my O2. If there is an easy
>> way to get this to work, I'd be very thankful for some pointers. Might
>> my
>> trying to compile on the actual machine be why I can't seem to use any
>> source other than Debian's 2.6.18?
>
> Should be rather straightforward:
>
> - Add the sources.list line mentioned in the repository to your
>   /etc/apt/sources.list, for debian/stable that's:
>
>   deb http://people.debian.org/~ths/toolchain/current etch/
>
> - apt-get update
> - apt-get install gcc-4.1-mips-linux-gnu
>
> - In your www.linux-mips.org source tree, compile with e.g.
>   make CROSS_COMPILE=mips-linux-gnu- oldconfig
>   make CROSS_COMPILE=mips-linux-gnu- all
>
>
> Thiemo
>
>

Thanks for your help, but that isn't working.
With both the 2.6.20.11 and 2.6.21.1 I get the same results.
To be verbose:

Shiva:/usr/src/linux-2.6.20.11# more /etc/apt/sources.list
deb http://ftp.debian.org/ etch main contrib non-free
deb http://mirrors.kernel.org/debian/ etch main contrib non-free
deb http://debian.lcs.mit.edu/debian/ etch main contrib non-free
deb http://people.debian.org/~ths/toolchain/current etch/
deb http://security.debian.org/ etch/updates main

Shiva:/usr/src/linux-2.6.20.11# apt-get update
Get:1 http://debian.lcs.mit.edu etch Release.gpg [378B]
Hit http://debian.lcs.mit.edu etch Release
Ign http://debian.lcs.mit.edu etch/main Packages/DiffIndex
Ign http://debian.lcs.mit.edu etch/contrib Packages/DiffIndex
Ign http://debian.lcs.mit.edu etch/non-free Packages/DiffIndex
Hit http://debian.lcs.mit.edu etch/main Packages
Hit http://debian.lcs.mit.edu etch/contrib Packages
Hit http://debian.lcs.mit.edu etch/non-free Packages
Ign http://people.debian.org etch/ Release.gpg
Get:2 http://ftp.debian.org etch Release.gpg [378B]
Ign http://people.debian.org etch/ Release
Get:3 http://mirrors.kernel.org etch Release.gpg [378B]
Hit http://ftp.debian.org etch Release
Ign http://people.debian.org etch/ Packages/DiffIndex
Ign http://ftp.debian.org etch/main Packages/DiffIndex
Hit http://mirrors.kernel.org etch Release
Ign http://people.debian.org etch/ Packages
Ign http://ftp.debian.org etch/contrib Packages/DiffIndex
Ign http://ftp.debian.org etch/non-free Packages/DiffIndex
Get:4 http://security.debian.org etch/updates Release.gpg [189B]
Hit http://people.debian.org etch/ Packages
Ign http://mirrors.kernel.org etch/main Packages/DiffIndex
Hit http://ftp.debian.org etch/main Packages
Hit http://ftp.debian.org etch/contrib Packages
Hit http://ftp.debian.org etch/non-free Packages
Ign http://mirrors.kernel.org etch/contrib Packages/DiffIndex
Ign http://mirrors.kernel.org etch/non-free Packages/DiffIndex
Hit http://security.debian.org etch/updates Release
Hit http://mirrors.kernel.org etch/main Packages
Hit http://mirrors.kernel.org etch/contrib Packages
Hit http://mirrors.kernel.org etch/non-free Packages
Ign http://security.debian.org etch/updates/main Packages/DiffIndex
Hit http://security.debian.org etch/updates/main Packages
Fetched 4B in 0s (5B/s)
Reading package lists... Done

Shiva:/usr/src/linux-2.6.20.11# apt-get install gcc-4.1-mips-linux-gnu
Reading package lists... Done
Building dependency tree... Done
gcc-4.1-mips-linux-gnu is already the newest version.
0 upgraded, 0 newly installed, 0 to remove and 2 not upgraded.

Shiva:/usr/src/linux-2.6.20.11# make CROSS_COMPILE=mips-linux-gnu- oldconfig
  HOSTCC  scripts/basic/fixdep
scripts/basic/fixdep.c:107:23: error: sys/types.h: No such file or directory
scripts/basic/fixdep.c:108:22: error: sys/stat.h: No such file or directory
scripts/basic/fixdep.c:109:22: error: sys/mman.h: No such file or directory
scripts/basic/fixdep.c:110:20: error: unistd.h: No such file or directory
scripts/basic/fixdep.c:111:19: error: fcntl.h: No such file or directory
scripts/basic/fixdep.c:112:20: error: string.h: No such file or directory
scripts/basic/fixdep.c:113:20: error: stdlib.h: No such file or directory
scripts/basic/fixdep.c:114:19: error: stdio.h: No such file or directory
In file included from
/usr/lib/gcc/i486-linux-gnu/4.1.2/include/syslimits.h:7,
                 from /usr/lib/gcc/i486-linux-gnu/4.1.2/include/limits.h:11,
                 from scripts/basic/fixdep.c:115:
/usr/lib/gcc/i486-linux-gnu/4.1.2/include/limits.h:122:61: error:
limits.h: No such file or directory
scripts/basic/fixdep.c:116:19: error: ctype.h: No such file or directory
scripts/basic/fixdep.c:117:23: error: arpa/inet.h: No such file or directory
scripts/basic/fixdep.c: In function ‘usage’:
scripts/basic/fixdep.c:131: warning: implicit declaration of function
‘fprintf’
scripts/basic/fixdep.c:131: warning: incompatible implicit declaration of
built-in function ‘fprintf’
scripts/basic/fixdep.c:131: error: ‘stderr’ undeclared (first use in this
function)
scripts/basic/fixdep.c:131: error: (Each undeclared identifier is reported
only once
scripts/basic/fixdep.c:131: error: for each function it appears in.)
scripts/basic/fixdep.c:132: warning: implicit declaration of function ‘exit’
scripts/basic/fixdep.c:132: warning: incompatible implicit declaration of
built-in function ‘exit’
scripts/basic/fixdep.c: In function ‘print_cmdline’:
scripts/basic/fixdep.c:140: warning: implicit declaration of function
‘printf’
scripts/basic/fixdep.c:140: warning: incompatible implicit declaration of
built-in function ‘printf’
scripts/basic/fixdep.c: At top level:
scripts/basic/fixdep.c:143: error: ‘NULL’ undeclared here (not in a function)
scripts/basic/fixdep.c: In function ‘grow_config’:
scripts/basic/fixdep.c:156: warning: implicit declaration of function
‘realloc’
scripts/basic/fixdep.c:156: warning: assignment makes pointer from integer
without a cast
scripts/basic/fixdep.c:158: warning: implicit declaration of function
‘perror’
scripts/basic/fixdep.c:158: warning: incompatible implicit declaration of
built-in function ‘exit’
scripts/basic/fixdep.c: In function ‘is_defined_config’:
scripts/basic/fixdep.c:174: warning: implicit declaration of function
‘memcmp’
scripts/basic/fixdep.c: In function ‘define_config’:
scripts/basic/fixdep.c:187: warning: implicit declaration of function
‘memcpy’
scripts/basic/fixdep.c:187: warning: incompatible implicit declaration of
built-in function ‘memcpy’
scripts/basic/fixdep.c: In function ‘use_config’:
scripts/basic/fixdep.c:206: error: ‘PATH_MAX’ undeclared (first use in
this function)
scripts/basic/fixdep.c:214: warning: incompatible implicit declaration of
built-in function ‘memcpy’
scripts/basic/fixdep.c:220: warning: implicit declaration of function
‘tolower’
scripts/basic/fixdep.c:222: warning: incompatible implicit declaration of
built-in function ‘printf’
scripts/basic/fixdep.c:206: warning: unused variable ‘s’
scripts/basic/fixdep.c: At top level:
scripts/basic/fixdep.c:225: error: expected declaration specifiers or
‘...’ before ‘size_t’
scripts/basic/fixdep.c: In function ‘parse_config_file’:
scripts/basic/fixdep.c:227: error: ‘len’ undeclared (first use in this
function)
scripts/basic/fixdep.c:233: warning: implicit declaration of function ‘ntohl’
scripts/basic/fixdep.c:244: warning: implicit declaration of function
‘isalnum’
scripts/basic/fixdep.c: In function ‘strrcmp’:
scripts/basic/fixdep.c:259: warning: implicit declaration of function
‘strlen’
scripts/basic/fixdep.c:259: warning: incompatible implicit declaration of
built-in function ‘strlen’
scripts/basic/fixdep.c: In function ‘do_config_file’:
scripts/basic/fixdep.c:270: error: storage size of ‘st’ isn’t known
scripts/basic/fixdep.c:274: warning: implicit declaration of function ‘open’
scripts/basic/fixdep.c:274: error: ‘O_RDONLY’ undeclared (first use in
this function)
scripts/basic/fixdep.c:276: warning: incompatible implicit declaration of
built-in function ‘fprintf’
scripts/basic/fixdep.c:276: error: ‘stderr’ undeclared (first use in this
function)
scripts/basic/fixdep.c:278: warning: incompatible implicit declaration of
built-in function ‘exit’
scripts/basic/fixdep.c:280: warning: implicit declaration of function ‘fstat’
scripts/basic/fixdep.c:282: warning: implicit declaration of function ‘close’
scripts/basic/fixdep.c:285: warning: implicit declaration of function ‘mmap’
scripts/basic/fixdep.c:285: error: ‘PROT_READ’ undeclared (first use in
this function)
scripts/basic/fixdep.c:285: error: ‘MAP_PRIVATE’ undeclared (first use in
this function)
scripts/basic/fixdep.c:285: warning: assignment makes pointer from integer
without a cast
scripts/basic/fixdep.c:292: error: too many arguments to function
‘parse_config_file’
scripts/basic/fixdep.c:294: warning: implicit declaration of function
‘munmap’
scripts/basic/fixdep.c:270: warning: unused variable ‘st’
scripts/basic/fixdep.c: At top level:
scripts/basic/fixdep.c:299: error: expected declaration specifiers or
‘...’ before ‘size_t’
scripts/basic/fixdep.c: In function ‘parse_dep_file’:
scripts/basic/fixdep.c:302: error: ‘len’ undeclared (first use in this
function)
scripts/basic/fixdep.c:304: error: ‘PATH_MAX’ undeclared (first use in
this function)
scripts/basic/fixdep.c:306: warning: implicit declaration of function
‘strchr’
scripts/basic/fixdep.c:306: warning: incompatible implicit declaration of
built-in function ‘strchr’
scripts/basic/fixdep.c:308: warning: incompatible implicit declaration of
built-in function ‘fprintf’
scripts/basic/fixdep.c:308: error: ‘stderr’ undeclared (first use in this
function)
scripts/basic/fixdep.c:309: warning: incompatible implicit declaration of
built-in function ‘exit’
scripts/basic/fixdep.c:311: warning: incompatible implicit declaration of
built-in function ‘memcpy’
scripts/basic/fixdep.c:312: warning: incompatible implicit declaration of
built-in function ‘printf’
scripts/basic/fixdep.c:304: warning: unused variable ‘s’
scripts/basic/fixdep.c: In function ‘print_deps’:
scripts/basic/fixdep.c:341: error: storage size of ‘st’ isn’t known
scripts/basic/fixdep.c:345: error: ‘O_RDONLY’ undeclared (first use in
this function)
scripts/basic/fixdep.c:347: warning: incompatible implicit declaration of
built-in function ‘fprintf’
scripts/basic/fixdep.c:347: error: ‘stderr’ undeclared (first use in this
function)
scripts/basic/fixdep.c:349: warning: incompatible implicit declaration of
built-in function ‘exit’
scripts/basic/fixdep.c:353: warning: incompatible implicit declaration of
built-in function ‘fprintf’
scripts/basic/fixdep.c:357: error: ‘PROT_READ’ undeclared (first use in
this function)
scripts/basic/fixdep.c:357: error: ‘MAP_PRIVATE’ undeclared (first use in
this function)
scripts/basic/fixdep.c:357: warning: assignment makes pointer from integer
without a cast
scripts/basic/fixdep.c:364: error: too many arguments to function
‘parse_dep_file’
scripts/basic/fixdep.c:341: warning: unused variable ‘st’
scripts/basic/fixdep.c: In function ‘traps’:
scripts/basic/fixdep.c:376: warning: incompatible implicit declaration of
built-in function ‘fprintf’
scripts/basic/fixdep.c:376: error: ‘stderr’ undeclared (first use in this
function)
scripts/basic/fixdep.c:378: warning: incompatible implicit declaration of
built-in function ‘exit’
make[1]: *** [scripts/basic/fixdep] Error 1
make: *** [scripts_basic] Error 2
Shiva:/usr/src/linux-2.6.20.11#

Any ideas?
