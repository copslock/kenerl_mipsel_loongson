Received:  by oss.sgi.com id <S305168AbQBSMjB>;
	Sat, 19 Feb 2000 04:39:01 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:35112 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQBSMiq>;
	Sat, 19 Feb 2000 04:38:46 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id EAA25103; Sat, 19 Feb 2000 04:34:15 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA27505
	for linux-list;
	Sat, 19 Feb 2000 04:26:50 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA52269
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 19 Feb 2000 04:26:46 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA02028
	for <linux@cthulhu.engr.sgi.com>; Sat, 19 Feb 2000 04:26:49 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port33.duesseldorf.ivm.de [195.247.65.33])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id NAA02745;
	Sat, 19 Feb 2000 13:26:14 +0100
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000219132654.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20000218224609.C24098@uni-koblenz.de>
Date:   Sat, 19 Feb 2000 13:26:54 +0100 (MET)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: Current cvs kernerl fails to compile for decstation
Cc:     linux-mips@vger.rutgers.edu, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com, Florian Lohoff <flo@rfc822.org>,
        Marc Esipovich <marc@mucom.co.il>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


On 18-Feb-00 Ralf Baechle wrote:
> On Fri, Feb 18, 2000 at 03:05:18PM -0200, Marc Esipovich wrote:
> 
>> > #if HZ == 100
>> > #define TCP_TW_RECYCLE_TICK (7+2-TCP_TW_RECYCLE_SLOTS_LOG)
>> > #elif HZ == 1024
>> > #define TCP_TW_RECYCLE_TICK (10+2-TCP_TW_RECYCLE_SLOTS_LOG)
>> > #else
>> > #error HZ != 100 && HZ != 1024.
>> > #endif

Well, I changed that to 
#if HZ == 100 || HZ == 128

HZ has been changed to 128 somewhere in the early 2.3.x series...

> It's 64 because it's not possible to program the DECstation RTC to 100Hz
> or 1024Hz.

Well, 1024 Hz would be possible but certainly total overkill for a DECstation
2100 with a 12.5 Mhz R2000 :-)

---
Regards,
Harald
