Received:  by oss.sgi.com id <S305155AbPKNQdi>;
	Sun, 14 Nov 1999 08:33:38 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:38718 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbPKNQdO>;
	Sun, 14 Nov 1999 08:33:14 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id RAA12905
	for <linuxmips@oss.sgi.com>; Sat, 13 Nov 1999 17:57:56 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA29540
	for linux-list;
	Sat, 13 Nov 1999 17:20:34 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA30219;
	Sat, 13 Nov 1999 17:20:28 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA1789085; Sat, 13 Nov 1999 08:47:54 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id IAA18408;
	Sat, 13 Nov 1999 08:47:53 -0800 (PST)
Received: from satanas (lyon-fw1-serial [194.51.122.30])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id IAA14286;
	Sat, 13 Nov 1999 08:47:50 -0800 (PST)
Message-ID: <006601bf2df8$118a7850$0228a8c0@satanas>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Mark Spencer" <markster@linux-support.net>,
        "Joan Eslinger" <wombat@kilimanjaro.engr.sgi.com>
Cc:     <linux@cthulhu.engr.sgi.com>
Subject: Re: Challenge "S" 
Date:   Sat, 13 Nov 1999 17:56:43 +0100
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

>Linux runs on a Challenge S, you just can't use the mezzanine peripheral
>cards yet.

I've never tried it, but the Indy kernel should run unmodified on a
Challenge S (which is essentially a "headless" Indy).  I've certainly
run Indy's off the serial console.   The one tricky bit would be that 
for the console serial port to work as the system console, one must 
ensure that /dev/console in the root filesystem actually maps to ttyS0.

            Regards,

            Kevin K.
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
