Received:  by oss.sgi.com id <S42313AbQHCTnU>;
	Thu, 3 Aug 2000 12:43:20 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:37425 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42311AbQHCTm7>;
	Thu, 3 Aug 2000 12:42:59 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA20503
	for <linux-mips@oss.sgi.com>; Thu, 3 Aug 2000 12:34:48 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id MAA89295 for <linux-mips@oss.sgi.com>; Thu, 3 Aug 2000 12:41:50 -0700 (PDT)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA86267;
	Thu, 3 Aug 2000 12:40:17 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: by calypso.engr.sgi.com (Postfix, from userid 37984)
	id 9A4D4A7875; Thu,  3 Aug 2000 12:38:43 -0700 (PDT)
To:     "Robyn Landers [MFCF]" <rblander@math.uwaterloo.ca>
Cc:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: Origin 2000 help
References: <200008031521.LAA32197@math.uwaterloo.ca>
From:   Ulf Carlsson <ulfc@calypso.engr.sgi.com>
Date:   03 Aug 2000 12:38:43 -0700
In-Reply-To: "Robyn Landers [MFCF]"'s message of "Thu, 3 Aug 2000 11:21:59 -0400 (EDT)"
Message-ID: <6ovittiuocc.fsf@calypso.engr.sgi.com>
X-Mailer: Gnus v5.7/Emacs 20.5
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi Robyn,

> I hear from Ralf B. that somebody out there has got
> Linux working on the Origin 2000 platform.

You can read about it at:

http://oss.sgi.com/projects/LinuxScalability/

I don't think anyone has written any complete instructions for getting
it running.  You could use a normal 32-bit Indy filesystem with a
MIPS64 kernel compiled from the Linux/MIPS CVS tree at oss.sgi.com.

The tools we use are located at:

ftp://oss.sgi.com/pub/linux/mips/crossdev/i386-linux/mips64-linux/

Ulf
