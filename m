Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2004 16:12:30 +0000 (GMT)
Received: from hnet1.camc.org ([IPv6:::ffff:206.193.127.2]:3783 "EHLO
	mail2.camcare.com") by linux-mips.org with ESMTP
	id <S8225440AbUBBQM3>; Mon, 2 Feb 2004 16:12:29 +0000
Received: from KES.camcare.com (hnet1.camc.org [206.193.127.2])
	by mail2.camcare.com (Postfix) with ESMTP id 316B86DD5
	for <linux-mips@linux-mips.org>; Mon,  2 Feb 2004 12:05:36 -0500 (EST)
Received: by KES.camcare.com with Internet Mail Service (5.5.2650.21)
	id <C9ACSHJ2>; Mon, 2 Feb 2004 11:12:11 -0500
Message-ID: <490E0430C3C72046ACF7F18B7CD76A2A56955D@KES.camcare.com>
From: "Smith, Todd" <Todd.Smith@camc.org>
To: "'linux-mips@linux-mips.org '" <linux-mips@linux-mips.org>
Subject: RE: MIPS Kernel size
Date: Mon, 2 Feb 2004 11:12:10 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Todd.Smith@camc.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Todd.Smith@camc.org
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I am still interested in some older PDA usage that has limited resources.  I
certainly don't want to hold up or stop current kernel dev but is there a
problem with keeping small kernel and/or userspace limits?

Thank you for the discussion.

Todd Smith <todd.smith@camc.org>  

-----Original Message-----
From: Ralf Baechle
Btw, the -tiny tree of 2.6 has been booted on a 2MB system.  Supposedly
that
was an i386 system so MIPS16 should boot in an even smaller system and a
normal 32-bit MIPS kernel should have enough space to wiggle in 4 megs.

Does anybody on this list actually still care about that small systems?

  Ralf
