Received:  by oss.sgi.com id <S305157AbQCMOAy>;
	Mon, 13 Mar 2000 06:00:54 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:4910 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCMOA0>; Mon, 13 Mar 2000 06:00:26 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id GAA01161; Mon, 13 Mar 2000 06:03:47 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA55018
	for linux-list;
	Mon, 13 Mar 2000 05:47:49 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA82486
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 13 Mar 2000 05:47:46 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (lightning.swansea.uk.linux.org [194.168.151.1]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id FAA17797
	for <linux@cthulhu.engr.sgi.com>; Mon, 13 Mar 2000 05:43:08 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 12UVAr-0007rR-00; Mon, 13 Mar 2000 13:46:21 +0000
Subject: Re: FP emulation patch available
To:     kevink@mips.com (Kevin D. Kissell)
Date:   Mon, 13 Mar 2000 13:46:19 +0000 (GMT)
Cc:     Harald.Koerfgen@home.ivm.de (Harald Koerfgen),
        linux-mips@vger.rutgers.edu, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com (Linux SGI)
In-Reply-To: <002701bf8cc6$c2ef0200$0ceca8c0@satanas.mips.com> from "Kevin D. Kissell" at Mar 13, 2000 09:33:02 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E12UVAr-0007rR-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> Does anyone out there actually need/want an SMP
> version of the emulator?   It's not completely trivial,
> but it would not be all that difficult to do...

If you dont do it please add

#ifdef CONFIG_SMP
#error "Not on this emulator"
#endif

to the emu code - for the person who didnt know 8)
