Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4FMEhnC002818
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 15 May 2002 15:14:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4FMEhTP002817
	for linux-mips-outgoing; Wed, 15 May 2002 15:14:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms1.broadcom.com (mms1.broadcom.com [63.70.210.58])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4FMEenC002814
	for <linux-mips@oss.sgi.com>; Wed, 15 May 2002 15:14:40 -0700
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 MMS-1 SMTP Relay (MMS v4.7)); Wed, 15 May 2002 15:14:39 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from mail-sj1-1.sj.broadcom.com (mail-sj1-1.sj.broadcom.com
 [10.16.128.231]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id PAA27831; Wed, 15 May 2002 15:15:08 -0700 (PDT)
Received: from broadcom.com (kwalker@dt-sj3-158 [10.21.64.158]) by
 mail-sj1-1.sj.broadcom.com (8.8.8/8.8.8/MS01) with ESMTP id PAA26148;
 Wed, 15 May 2002 15:15:07 -0700 (PDT)
Message-ID: <3CE2DDEB.5DA6E868@broadcom.com>
Date: Wed, 15 May 2002 15:15:07 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Matthew Dharm" <mdharm@momenco.com>
cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
References: <NEBBLJGMNKKEEMNLHGAIAEABCHAA.mdharm@momenco.com>
X-WSS-ID: 10FC0245663904-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Matthew Dharm wrote:
> 
> I don't suppose anyone has a primer or white paper on the High Memory
> stuff?  i.e. Applications, requirements, or a quick HOWTO?

Well, the CONFIG option is at the bottom of the Machine Selection menu. 
With a fairly recent 2.4 or 2.5 kernel, it should build at work. 
Basically, if your firmware/boot code conveys info about regions above
physical address 0x1fffffff, the kernel will allocate "struct page"
entries for it, and add them to the pool of allocatable memory.  The
kernel gets at them by mapping them into Kseg2/Kseg3 temporarily.

turn it on, see what happens!  I haven't looked for a primer.

Kip
