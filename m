Received:  by oss.sgi.com id <S305163AbQCTJrs>;
	Mon, 20 Mar 2000 01:47:48 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:41004 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCTJrb>; Mon, 20 Mar 2000 01:47:31 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id BAA04807; Mon, 20 Mar 2000 01:50:59 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA94358
	for linux-list;
	Mon, 20 Mar 2000 01:27:35 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA38679
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 20 Mar 2000 01:27:13 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA04222
	for <linux@cthulhu.engr.sgi.com>; Mon, 20 Mar 2000 01:27:02 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA04188;
	Mon, 20 Mar 2000 01:26:58 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA10570;
	Mon, 20 Mar 2000 01:26:53 -0800 (PST)
Message-ID: <004401bf924e$f0c526e0$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Andreas Jaeger" <aj@suse.de>
Cc:     "Florian Lohoff" <flo@rfc822.org>, <linux@cthulhu.engr.sgi.com>
Subject: Re: header files state
Date:   Mon, 20 Mar 2000 10:30:26 +0100
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

>Linus has stated quite violantly that glibc should not include any
>kernel headers at all - and we're now including less and less
>headers.  But this process needs time and occasionally breaks older
>glibc's.

What is Linus' rationale for his position?   It's true that 
having includes "reaching in" from libc imposes constraints
on kernel designers, but failure to do so is guaranteed
to induce error - as we have seen.

            Kevin K.
