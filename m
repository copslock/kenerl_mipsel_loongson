Received: (from majordomo@localhost)
	by oss.sgi.com (8.9.3/8.9.3) id EAA22543
	for linuxmips-outgoing; Thu, 28 Oct 1999 04:45:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linuxmips@oss.sgi.com using -f
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.9.3/8.9.3) with ESMTP id EAA22540
	for <linuxmips@oss.sgi.com>; Thu, 28 Oct 1999 04:45:42 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA5468044
	for <linuxmips@oss.sgi.com>; Thu, 28 Oct 1999 04:49:46 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA73354
	for linux-list;
	Thu, 28 Oct 1999 04:27:40 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA46639
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 28 Oct 1999 04:27:23 -0700 (PDT)
	mail_from (nop@nop.com)
Received: from chmls05.mediaone.net (ne.mediaone.net [24.128.1.70]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA5483513
	for <linux@cthulhu.engr.sgi.com>; Thu, 28 Oct 1999 04:27:22 -0700 (PDT)
	mail_from (nop@nop.com)
Received: from decoy (nopnop.ne.mediaone.net [24.218.146.73])
	by chmls05.mediaone.net (8.8.7/8.8.7) with SMTP id HAA01778;
	Thu, 28 Oct 1999 07:27:11 -0400 (EDT)
Message-ID: <120f701bf2137$5788bc40$0a00000a@nop.com>
From: "Jay Carlson" <nop@nop.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>, "Florian Lohoff" <flo@rfc822.org>
Cc: <linux@cthulhu.engr.sgi.com>, <linux-mips@fnet.fr>,
        <linux-mips@vger.rutgers.edu>
References: <19991026162026.I1207@paradigm.rfc822.org> <19991027103326.A6252@uni-koblenz.de>
Subject: Re: latest binutils cygnus CVS 991025
Date: Thu, 28 Oct 1999 07:26:51 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.5600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.5600
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk

>  - Symbol versioning is broken in the CVS version.  There is no fix yet
for
>    this problem.
>  - The CVS gas version has a few problems with weak symbols, aliases and
>    other special cases.  These usually don't show up.  Anyway, the
patchkit
>    on oss.sgi.com has all these fixes which haven't made their way into
>    CVS.
>
> I've spent a tremendous amount of time into tracking down a large number
of
> other bugs in binutils; I was able to rebuild entire RH 6.0 with that
> linker.

This is the 2.8.1+mips patchkit?

Jay
