Received:  by oss.sgi.com id <S305196AbQDCRCx>;
	Mon, 3 Apr 2000 10:02:53 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:55158 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305168AbQDCRC2>; Mon, 3 Apr 2000 10:02:28 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA09677; Mon, 3 Apr 2000 10:06:11 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id KAA56282; Mon, 3 Apr 2000 10:02:26 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA51247
	for linux-list;
	Mon, 3 Apr 2000 09:51:44 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA57068
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 3 Apr 2000 09:51:38 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA03640
	for <linux@cthulhu.engr.sgi.com>; Mon, 3 Apr 2000 09:51:38 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id JAA05790;
	Mon, 3 Apr 2000 09:51:37 -0700 (PDT)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id JAA14637;
	Mon, 3 Apr 2000 09:51:33 -0700 (PDT)
Message-ID: <019d01bf9d8d$76b7a680$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Florian Lohoff" <flo@rfc822.org>, <linux@cthulhu.engr.sgi.com>
Subject: Re: config.in revised #2
Date:   Mon, 3 Apr 2000 18:55:41 +0200
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

>-if [ "$CONFIG_CPU_LITTLE_ENDIAN" = "n" ]; then
>-   define_bool CONFIG_BINFMT_IRIX y
>-   define_bool CONFIG_FORWARD_KEYBOARD y
>-fi

As someone more concerned with embedded apps
than old SGI platforms, I would take issue with forcing
IRIX binary format support and keyboard forwarding just
because a big-endian CPU is configured.  Yes, I know
that this is for 2.3, and most of embedded apps are
2.0 or 2.2 based, but I figure it's better to speak up now...

            Regards,

            Kevin K.
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
