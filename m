Received:  by oss.sgi.com id <S305185AbQB1OHp>;
	Mon, 28 Feb 2000 06:07:45 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:63091 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305166AbQB1OHe>; Mon, 28 Feb 2000 06:07:34 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id GAA06971; Mon, 28 Feb 2000 06:10:40 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA20161
	for linux-list;
	Mon, 28 Feb 2000 05:53:45 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA03116
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 28 Feb 2000 05:53:37 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA06442
	for <linux@cthulhu.engr.sgi.com>; Mon, 28 Feb 2000 05:53:47 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id FAA09607;
	Mon, 28 Feb 2000 05:53:35 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id FAA26863;
	Mon, 28 Feb 2000 05:53:32 -0800 (PST)
Message-ID: <017a01bf81f3$92709130$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc:     "Linux/MIPS fnet" <linux-mips@fnet.fr>,
        "Linux/MIPS algor" <linux-porters@algor.co.uk>,
        "Linux SGI" <linux@cthulhu.engr.sgi.com>
Subject: Re: Kernel/User Memory Access and Original Sin
Date:   Mon, 28 Feb 2000 14:56:04 +0100
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

>__access_ok has one purpose. To verify the address range given is entirely
>sensible to feed to __copy_*_user. If you have to do handling the complex
>way (eg if your cpu design requires it) then __access_ok can just return 1
>and the __copy_*_user - inline or out of line - can do all the work.


Thanks.  I think I have localized the hole in the signal handling that
would have defeated these mechanisms, though another related
failure that was also solved by the sledgehammer __access_ok
remains mysterious.  I'll apply the more localized fix and repeat the 
crashme experiments...

            Kevin K.
