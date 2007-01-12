Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2007 08:02:02 +0000 (GMT)
Received: from py-out-1112.google.com ([64.233.166.181]:16875 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20040702AbXALIB6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Jan 2007 08:01:58 +0000
Received: by py-out-1112.google.com with SMTP id u52so356439pyb
        for <linux-mips@linux-mips.org>; Fri, 12 Jan 2007 00:01:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RAj2YPX06Tcu66Dh8q0quSRQzwwVKz2tY7uhHPD+6qmkAayiyOaIKPaSj8GFYnXKK96/xQU7he9uaEvlVjomivaPzlpSl88x2qZh8sLb1Na2bYu5QexCl8FHuD1c3jFYMjR+jTE1jxNhQBb5pz2iFBYddvuesw5FPXBVfaNLiLk=
Received: by 10.35.41.12 with SMTP id t12mr599909pyj.1168588916769;
        Fri, 12 Jan 2007 00:01:56 -0800 (PST)
Received: by 10.35.26.4 with HTTP; Fri, 12 Jan 2007 00:01:56 -0800 (PST)
Message-ID: <ee9e31d90701120001t31ab7d5et94865936679ef402@mail.gmail.com>
Date:	Fri, 12 Jan 2007 10:01:56 +0200
From:	"K '" <c.flame@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Problem: Xfree cross-compiled for mips, It runs but screen is empty :(
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <c.flame@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: c.flame@gmail.com
Precedence: bulk
X-list: linux-mips

Dear members,

I have a problem with running XFree. I have cross-compiled XFree
version 4.3.0 for mips platform successfully. "make install" command
has created libraries under "/usr/X11R6/lib" and binaries under
"/usr/X11R6/bin". I also copied resultant Xfbdev from
"/build/programs/Xserver" to "usr/X11R6/bin". I set DISPLAY and
required paths with this small script:

#!/bin/sh
export PATH=$PATH:/usr/X11R6/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/X11R6/lib
export DISPLAY=127.0.0.1:0.0

Then I try to run Xfbdef with "Xfbdev &". It actually starts as a
process ("ps aux" shows that it has started), but somehow I cannot see
anything on the screen. I used many sample programs under
"/tmp/usr/X11R6/bin", such as xlogo, xload, xcalc, etc... All of them
runs, but I have nothing on the screen. For example, here is the
output of the xperf (After starting Xfbdev as deamon):

none) # x11perf -all
x11perf - X11 performance program, version 1.5
Keith Packard server version 600300 on 127.0.0.1:0.0
from (none)
Sat Jan  1 23:54:03 2005
Sync time adjustment is 0.8264 msecs.

7000000 reps @   0.0008 msec (1240000.0/sec): Dot
7000000 reps @   0.0008 msec (1240000.0/sec): Dot
7000000 reps @   0.0008 msec (1240000.0/sec): Dot
7000000 reps @   0.0008 msec (1240000.0/sec): Dot
7000000 reps @   0.0008 msec (1230000.0/sec): Dot
35000000 trep @   0.0008 msec (1240000.0/sec): Dot
.
.
.

and goes like that till it finished the performance test, but I see
nothing on the screen. Let me give another example, xcalc:


(none) # xcalc &
(none) # Warning: locale not supported by C library, locale unchanged
Warning: locale not supported by Xlib, locale set to C
Warning: X locale modifiers not supported, using default
Warning: Cannot convert string "8x13" to type FontStruct
Warning: Unable to load any usable fontset
Warning: Cannot convert string
"-adobe-symbol-*-*-*-*-*-120-*-*-*-*-*-*" to type FontStruct

I got some font warnings but I assume they are not important. When I
run "ps aux" afterwards, I see xclac is started:

root       939  0.0  1.6   4148   852 ttyS1    Ss   23:37   0:00 -/bin/sh -i
root       957 12.0  3.2   5864  1688 ttyS1    S    23:51   0:39 Xfbdev
root       998  3.3  3.8   8108  2000 ttyS1    S    23:56   0:00 xcalc
root      1001 10.0  1.8   3600   972 ttyS1    R+   23:56   0:00 ps aux


The screen is black empty. I am trying to get the display from a TFT
screen that is connected to my mips system with SCART (composite video
is used). What might be the problem? It seems a video mode problem,
but I could not find a solution. I am dealing with this problem for
weeks, please help me. "cat /proc/fb" gives:

(none) # cat /proc/fb
0 3rdparty X9812

Also, here are the shell outputs when I try to run Xfbdev:

(none) # Xfbdev &
(none) # Could not init font path element
/usr/X11R6/lib/X11/fonts/misc/, removing from list!
Could not init font path element /usr/X11R6/lib/X11/fonts/75dpi/,
removing from list!
Could not init font path element /usr/X11R6/lib/X11/fonts/100dpi/,
removing from list!
