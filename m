Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2003 15:44:16 +0000 (GMT)
Received: from [IPv6:::ffff:209.116.120.7] ([IPv6:::ffff:209.116.120.7]:2320
	"EHLO tnint11.telogy.design.ti.com") by linux-mips.org with ESMTP
	id <S8225689AbTABPoP>; Thu, 2 Jan 2003 15:44:15 +0000
Received: by tnint11.telogy.design.ti.com with Internet Mail Service (5.5.2653.19)
	id <WY1Z4JYL>; Thu, 2 Jan 2003 10:42:06 -0500
Message-ID: <37A3C2F21006D611995100B0D0F9B73CBFE3E1@tnint11.telogy.design.ti.com>
From: "Zajerko-McKee, Nick" <nmckee@telogy.com>
To: 'chamak man' <chamakmann@yahoo.co.in>, linux-mips@linux-mips.org
Subject: RE: System Call in MIPS
Date: Thu, 2 Jan 2003 10:42:05 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <nmckee@telogy.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nmckee@telogy.com
Precedence: bulk
X-list: linux-mips

One thing to check is if unistd.h matches whats in the syscall table.  In
2.4.17 I was working with, there were more entries in the defines than in
the table so when I added my calls they went to never never land...

-----Original Message-----
From: chamak man [mailto:chamakmann@yahoo.co.in]
Sent: Wednesday, January 01, 2003 10:57 PM
To: linux-mips@linux-mips.org
Subject: System Call in MIPS


Hi,

   I am finding problems in adding a new system call
for MIPS kernel.  Where can i get information on it. 

with regards,
sumanth.g



________________________________________________________________________
Missed your favourite TV serial last night? Try the new, Yahoo! TV.
       visit http://in.tv.yahoo.com
