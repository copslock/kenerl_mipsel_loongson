Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Dec 2003 11:38:36 +0000 (GMT)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:36752 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225230AbTL2Lig>;
	Mon, 29 Dec 2003 11:38:36 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id hBTBWPvq007802;
	Mon, 29 Dec 2003 03:32:26 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id DAA07763;
	Mon, 29 Dec 2003 03:38:22 -0800 (PST)
Message-ID: <056401c3ce00$5cd8a690$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Mark and Janice Juszczec" <juszczec@hotmail.com>,
	<linux-mips@linux-mips.org>
References: <Law10-F61XsDQ1sMzqi00015abf@hotmail.com>
Subject: Re: hardware questions
Date: Mon, 29 Dec 2003 12:39:02 +0100
Organization: MIPS Technologies Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

As Geert pointed out, the big-endian SGI hardware configuration
and the little-endian PDA configuration mean that you'll be cross-compiling
for "mipsel" (MIPS endian-little) on the Indigo anyway.  SGI did
use industry-standard monitors, keyboards, and disks units of the
period (which was 10 years ago - they could be hard to find today), 
but used non-standard NIC and memory cards. You're probably better 
off using a Linux PC as your development host.

----- Original Message ----- 
From: "Mark and Janice Juszczec" <juszczec@hotmail.com>
To: <linux-mips@linux-mips.org>
Sent: Sunday, December 21, 2003 17:20
Subject: hardware questions


> 
> Hi folks
> 
> I'm the guy with the Helio pda running an r3912 chip.  In an effort to 
> create a better development environment, I'm thinking about puchasing a 
> Silicon Graphics Iris Indigo Workstation.
> 
> But, I'm unfamiliar with MIPS hardware.
> 
> First of all, will code developed on this machine run on the r3912 chip?  
> The r3912 is little endian mips, 16 bit I think but maybe 32 bit.
> 
> Can off the shelf monitors, keyboards, hard drives, NICs and memory be 
> installed in this system?
> 
> Mark
> 
> _________________________________________________________________
> Grab our best dial-up Internet access offer: 6 months @$9.95/month.  
> http://join.msn.com/?page=dept/dialup
> 
> 
> 
