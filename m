Received:  by oss.sgi.com id <S305166AbPLFMjJ>;
	Mon, 6 Dec 1999 04:39:09 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:25134 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305158AbPLFMij>; Mon, 6 Dec 1999 04:38:39 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id EAA09686; Mon, 6 Dec 1999 04:47:30 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA06953
	for linux-list;
	Mon, 6 Dec 1999 04:35:15 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA87520
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Dec 1999 04:35:12 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA07174
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 04:35:10 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id EAA06016
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 04:35:07 -0800 (PST)
Received: from satanas (fr-host2 [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id EAA29032
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 04:35:06 -0800 (PST)
Message-ID: <008301bf3fe7$b5fbb330$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Linux SGI" <linux@cthulhu.engr.sgi.com>
Subject: Nomenclature: "MIPS32", "MIPS64"
Date:   Mon, 6 Dec 1999 13:44:55 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

I note that various people involved in this effort
refer to the 32-bit version of the MIPS/Linux
port as "MIPS32" and the 64-bit version as
"MIPS64".   Thus far, I have not observed those
strings making it into the source repositories,
but before they do, there's something I must
point out.

"MIPS32" and "MIPS64" have a very specific
meaning now, and for all I know are already
trademarked/brandmarked/whatever by
MIPS Technologies Inc. to describe the new
baseline ISA and privileged resource architecture
(CP0, in other words) standards for 32-bit
and 64-bit MIPS devices.   It's no big deal
for informal discussion, but *please* do not
use the strings "MIPS32" or "MIPS64" in the
code or documentation unless you are really
and truly referring to MIPS32 and MIPS64
as defined by MIPS.   If you want to refer to
the 64-bit versus 32-bit Linux ports, please
express it otherwise, e.g. MIPS64bit,
MIPS_64_bit, 64bitMIPS, etc.   Otherwise
there is going to be a lot of needless confusion
and a further source schism.

            Regards,

            Kevin K.
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
