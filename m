Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 May 2003 05:19:31 +0100 (BST)
Received: from shell.cyberus.ca ([IPv6:::ffff:216.191.236.4]:32264 "EHLO
	shell.cyberus.ca") by linux-mips.org with ESMTP id <S8225072AbTEYETW>;
	Sun, 25 May 2003 05:19:22 +0100
Received: from hadi (helo=localhost)
	by shell.cyberus.ca with local-esmtp (Exim 4.14)
	id 19JmyJ-000EFN-VO
	for linux-mips@linux-mips.org; Sun, 25 May 2003 00:18:59 -0400
Date: Sun, 25 May 2003 00:18:59 -0400 (EDT)
From: Jamal Hadi <hadi@shell.cyberus.ca>
To: linux-mips@linux-mips.org
Subject: profiling SMP/SB1250
Message-ID: <20030525001222.B54761@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <hadi@shell.cyberus.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hadi@shell.cyberus.ca
Precedence: bulk
X-list: linux-mips


Hi,

Newbie to MIPS here and not on the list (so cc me please).
I am playing around with a SB1250 board; it has two CPUs. Attempt to
kernel profile:
on bootup selected profile=2 to enable profiling(validated because
/proc/profile shows up). readprofile produce some strange
output after i ran a lot of interupt related stresses. The output seems
to claim the CPU was idle ... I know it was not.
The SB1250 ties all IO interupts on CPU0 - i wonder if this was causing me
some issues? Is what i am doing the right way to turn on profiling on
MIPS or the SB1250?

cheers,
jamal
