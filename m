Received:  by oss.sgi.com id <S305167AbQBRNWs>;
	Fri, 18 Feb 2000 05:22:48 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:27674 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305163AbQBRNW0>; Fri, 18 Feb 2000 05:22:26 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id FAA01591; Fri, 18 Feb 2000 05:25:21 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA25715
	for linux-list;
	Fri, 18 Feb 2000 05:07:02 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA74480
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 18 Feb 2000 05:06:59 -0800 (PST)
	mail_from (marc@mucom.co.il)
Received: from biff.ibm.net.il (biff.ibm.net.il [192.115.72.164]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA06064
	for <linux@cthulhu.engr.sgi.com>; Fri, 18 Feb 2000 05:07:03 -0800 (PST)
	mail_from (marc@mucom.co.il)
Received: from moose (host13.mucom.co.il [192.115.216.45])
	by biff.ibm.net.il (Postfix) with ESMTP
	id 469B1121C; Fri, 18 Feb 2000 15:06:38 +0200 (IST)
Date:   Fri, 18 Feb 2000 15:05:18 -0200 (GMT+2)
From:   Marc Esipovich <marc@mucom.co.il>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Current cvs kernerl fails to compile for decstation
In-Reply-To: <20000218102505.B369@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.20.0002181504271.6252-100000@mucom.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> #if HZ == 100
> #define TCP_TW_RECYCLE_TICK (7+2-TCP_TW_RECYCLE_SLOTS_LOG)
> #elif HZ == 1024
> #define TCP_TW_RECYCLE_TICK (10+2-TCP_TW_RECYCLE_SLOTS_LOG)
> #else
> #error HZ != 100 && HZ != 1024.
> #endif
> 

Without looking or knowing the source,  my recommendation is, see where HZ
is defined, and find out why it's not defined as either 100 or 1024, but
you know that already ;)


	Marc.
