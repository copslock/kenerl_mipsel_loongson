Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2009 05:14:16 +0000 (GMT)
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:457 "EHLO
	QMTA07.westchester.pa.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S20808190AbZBYFON (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 25 Feb 2009 05:14:13 +0000
Received: from OMTA13.westchester.pa.mail.comcast.net ([76.96.62.52])
	by QMTA07.westchester.pa.mail.comcast.net with comcast
	id KzBk1b00W17dt5G575E8TF; Wed, 25 Feb 2009 05:14:08 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA13.westchester.pa.mail.comcast.net with comcast
	id L5E71b00358Be2l3Z5E70g; Wed, 25 Feb 2009 05:14:08 +0000
Message-ID: <49A4D370.3080300@gentoo.org>
Date:	Wed, 25 Feb 2009 00:13:20 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips@linux-mips.org
Subject: Re: [SOLVED] Re: GCC-4.3.3 sillyness
References: <20090130074407.GA12368@roarinelk.homelinux.net> <20090131085957.399614d1@scarran.roarinelk.net>
In-Reply-To: <20090131085957.399614d1@scarran.roarinelk.net>
Content-Type: multipart/mixed;
 boundary="------------030302060300030401020406"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------030302060300030401020406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Manuel Lauss wrote:
> On Fri, 30 Jan 2009 08:44:07 +0100
> Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> 
>> Hello,
>>
>> Can't build kernel because gcc-4.3.3 comes up with this gem:
>>
>>   CC      arch/mips/kernel/traps.o
>> cc1: warnings being treated as errors
>> /linux-2.6.git/arch/mips/kernel/traps.c: In function 'set_uncached_handler':
>> /linux-2.6.git/arch/mips/kernel/traps.c:1599: error: format not a string literal and no format arguments
> 
> Turns out Gentoo applied a patch (from Debian) which unconditionally
> enables -Wformat-security (which is responsible for the warning).

Yeah, I did some digging and it looks like we added a patch called 
"10_all_gcc-default-format-security.patch" into our gcc-4.3.3 ebuild.  The patch 
claims it was ripped from Debian; can any Debian devs comment on whether you 
guys still use this patch and what the idea behind it is?  I'm not sure if I'll 
find any discussion on our end as to why it's included without finding Mike 
(vapier) around.


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic

--------------030302060300030401020406
Content-Type: text/plain;
 name="10_all_gcc-default-format-security.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="10_all_gcc-default-format-security.patch"

ripped from Debian

# DP: Turn on -Wformat -Wformat-security by  default for C, C++, ObjC, ObjC++.

--- gcc/c-common.c
+++ gcc/c-common.c
@@ -277,7 +277,7 @@
 /* Warn about format/argument anomalies in calls to formatted I/O functions
    (*printf, *scanf, strftime, strfmon, etc.).  */
 
-int warn_format;
+int warn_format = 1;
 
 /* Warn about using __null (as NULL in C++) as sentinel.  For code compiled
    with GCC this doesn't matter as __null is guaranteed to have the right
--- gcc/c.opt
+++ gcc/c.opt
@@ -228,7 +228,7 @@
 Warn about format strings that contain NUL bytes
 
 Wformat-security
-C ObjC C++ ObjC++ Var(warn_format_security) Warning
+C ObjC C++ ObjC++ Var(warn_format_security) Init(1) Warning
 Warn about possible security problems with format functions
 
 Wformat-y2k
--- gcc/doc/invoke.texi
+++ gcc/doc/invoke.texi
@@ -2802,6 +2802,9 @@
 @option{-Wformat-nonliteral}, @option{-Wformat-security}, and
 @option{-Wformat=2} are available, but are not included in @option{-Wall}.
 
+NOTE: In Gentoo, this option is enabled by default for C, C++, ObjC, ObjC++.
+To disable, use @option{-Wformat=0}.
+
 @item -Wformat-y2k
 @opindex Wformat-y2k
 @opindex Wno-format-y2k
@@ -2849,6 +2852,11 @@
 in future warnings may be added to @option{-Wformat-security} that are not
 included in @option{-Wformat-nonliteral}.)
 
+NOTE: In Gentoo, this option is enabled by default for C, C++, ObjC, ObjC++.
+To disable, use @option{-Wno-format-security}, or disable all format warnings
+with @option{-Wformat=0}.  To make format security warnings fatal, specify
+@option{-Werror=format-security}.
+
 @item -Wformat=2
 @opindex Wformat=2
 @opindex Wno-format=2

--------------030302060300030401020406--
