Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Apr 2004 10:35:59 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.173]:23510
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225206AbUDMJfz>; Tue, 13 Apr 2004 10:35:55 +0100
Received: from [212.227.126.179] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1BDKKf-0006wL-00
	for linux-mips@linux-mips.org; Tue, 13 Apr 2004 11:35:53 +0200
Received: from [80.133.133.17] (helo=p50858511.dip0.t-ipconnect.de)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1BDKKc-0006S3-00
	for linux-mips@linux-mips.org; Tue, 13 Apr 2004 11:35:50 +0200
From: Benjamin Collar <collar@onlinehome.de>
To: linux-mips@linux-mips.org
Subject: Hello
Date: Tue, 13 Apr 2004 11:38:22 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404131138.22725.collar@onlinehome.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:117708237306e4cac4d5753bf8790907
Return-Path: <collar@onlinehome.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: collar@onlinehome.de
Precedence: bulk
X-list: linux-mips

Greetings

I've joined this mailing list because I've started a new project: I want to 
port linux 2.6 to the Agenda VR3 PDA.

The Agenda already runs Linux--2.4.0 I think, based on the kernel that was at 
linux-vr.org but now appears to be gone.

I'm totally a beginner here, so please bear with me :)

What I'm doing at the moment is, I'm trying to understand where all of the 
code has gone! There is a different directory structure in 2.6. If someone 
can answer these questions, I'd very much appreciate it:

1. What's the difference between a NEC 4181 and NEC 41xx? In 2.6 there are 
subdirectories for each of these, while in the VR kernel all the code was in 
arch/mips/41xx. The Agenda is a 4181. Should I be using the 4181 common code 
or the 41xx?

2. Where did linux-vr go? Does anyone know where I can get the patches?
