Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Sep 2007 23:24:42 +0100 (BST)
Received: from web54007.mail.re2.yahoo.com ([206.190.36.231]:24446 "HELO
	web54007.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20021662AbXIQWYb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Sep 2007 23:24:31 +0100
Received: (qmail 91546 invoked by uid 60001); 17 Sep 2007 22:23:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=LkaN0csPK9D3Ecim16kW+2PxrHW89CCvtf81FZb26EuG9j5tjjECdVxmCivWl6RKFIW+mQKIs/rn0MErQNl9aWBgcSHygPSghYFNBlL48qPazaKeuuDPOA5W5XrJFvgnnsbXs0GXG+Yg0Gw1iIQQadRqK6TlEZXBADVhBRsmk2g=;
X-YMail-OSG: gQhywGsVM1nbSrJ_u0jeYMp4uOgLJLvFex0xfSVc.Ng3lFWDOkt5I1bdn7PWN2DAfw--
Received: from [67.91.200.194] by web54007.mail.re2.yahoo.com via HTTP; Mon, 17 Sep 2007 15:23:25 PDT
Date:	Mon, 17 Sep 2007 15:23:25 -0700 (PDT)
From:	Paul Marciano <pm940@yahoo.com>
Subject: busybox / ELDK fails to run.
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <446032.91533.qm@web54007.mail.re2.yahoo.com>
Return-Path: <pm940@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pm940@yahoo.com
Precedence: bulk
X-list: linux-mips

First, apologies if this is an inappropriate list for
this question, but there doesn't seem to be a list for
ELDK, and there doesn't seem to be much MIPS traffic
in the busybox list...  so I thought this would be the
best place to find help.


I've been using DENX/ELDK-4.0 for a while and recently
upgraded to 4.1.  The version of busybox included
(1.3.0) fails to run with the ld.so error:

symbol lookup error: busybox: undefined symbol:
xsocket_stream_ip4or6

Turning on ld.so debugging, xsocket_stream_ip4or6 is
one of five or so functions not found.  'objdump -T'
shows them all as *ABS* symbols, yet they come from
functions that are included, but unused, in the
busybox source.  Some functions are preceeded in the
source by comments that state they are not compiled
(yet not bracketed by #if, #endif).  Presumably
they're expected to be disposed of by the linker.

The latest, 1.7.1 version of busybox reduces the list
down to one such function (xstrtol_range_sfx) - but
that's enough to make ld.so unhappy.

I noticed while digging around, that the ELDK linker
(gcc-4.0.0, ld-2.16.1) includes many busybox symbols
in the final object's dynamic symbol table, whereas
the i386 build only lists fully external, unresolved
symbols (to be obtained from libc and other external
shared libraries).  I don't know if that's relevant or
if it's just a difference in architecture.


Is anyone else here using the ELDK and busybox?  If
so, I'd be interested in knowing if you've seen the
same problem, or if you think there's something wrong
with my setup.  

As I said, the unknown symbols come from within
busybox itself - the required shared libraries (libc,
libm and libcrypt) are all in place.

I could #if 0 the offending functions, but then I'm
assuming it's an ELDK fault and not my own -
especially given that I can't successfully build
runnable busybox version.  I'd like a second opinion.


I doubt the kernel version is relevant, but it's
2.6.18.

Thanks,
Paul.



      ____________________________________________________________________________________
Fussy? Opinionated? Impossible to please? Perfect.  Join Yahoo!'s user panel and lay it on us. http://surveylink.yahoo.com/gmrs/yahoo_panel_invite.asp?a=7 
