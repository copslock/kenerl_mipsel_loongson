Received:  by oss.sgi.com id <S305154AbQEBXPw>;
	Tue, 2 May 2000 16:15:52 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:25445 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQEBXPd>;
	Tue, 2 May 2000 16:15:33 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA06814; Tue, 2 May 2000 16:10:45 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id QAA62109; Tue, 2 May 2000 16:15:02 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA99992
	for linux-list;
	Tue, 2 May 2000 16:04:02 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from kilimanjaro.engr.sgi.com (kilimanjaro.engr.sgi.com [163.154.5.32])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA26070;
	Tue, 2 May 2000 16:03:59 -0700 (PDT)
	mail_from (wombat@kilimanjaro.engr.sgi.com)
Received: from kilimanjaro.engr.sgi.com (localhost [127.0.0.1]) by kilimanjaro.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA04626; Tue, 2 May 2000 16:04:01 -0700 (PDT)
Message-Id: <200005022304.QAA04626@kilimanjaro.engr.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
cc:     fisher@sgi.com, linux-mips@vger.rutgers.edu,
        "Linux/MIPS fnet" <linux-mips@fnet.fr>, linux@cthulhu.engr.sgi.com
Subject: Re: VC exceptions 
In-reply-to: Your message of "Tue, 02 May 2000 13:18:49 +0200."
             <00b401bfb428$34aae610$0ceca8c0@satanas.mips.com> 
Date:   Tue, 02 May 2000 16:04:01 -0700
From:   Joan Eslinger <wombat@kilimanjaro.engr.sgi.com>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

 * Date:    Tue, 2 May 2000 13:18:49 +0200
 * From:    "Kevin D. Kissell" <kevink@mips.com>
 * 
 * Quibble here:  The Challenge/PowerChallenge bus had
 * little or nothing to do with VME.   I recall that it was a synchronous,
 * "pended operation" bus, and VME is neither.

The main system bus is proprietary, called SysAD. Challenge and Power
Challenge did support VME cards, but I don't remember if the SysAD bus
had a VME extension on it or if you had to stick in a VME/SysAD card to
get that.

Originally "Power Challenge" meant you had an R8000 CPU, but after
R10000s were available "Challenge" and "Power Challenge" both meant
R10k.
