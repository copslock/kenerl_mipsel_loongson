Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 08:53:42 +0100 (BST)
Received: from post2.wesleyan.edu ([129.133.6.128]:18659 "EHLO
	post2.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20022228AbXGLHxk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 08:53:40 +0100
Received: from pony2.wesleyan.edu (pony2.wesleyan.edu [129.133.6.193])
	by courier2.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l6C7oDI6020016;
	Thu, 12 Jul 2007 03:50:13 -0400
Received: from pony2.wesleyan.edu (pony2.wesleyan.edu [127.0.0.1])
	by pony2.wesleyan.edu (8.12.11.20060308/8.12.11) with ESMTP id l6C7oDQ5001112;
	Thu, 12 Jul 2007 03:50:13 -0400
Received: (from apache@localhost)
	by pony2.wesleyan.edu (8.12.11.20060308/8.12.11/Submit) id l6C7oCdu001110;
	Thu, 12 Jul 2007 03:50:12 -0400
Received: from 129.133.89.141
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Thu, 12 Jul 2007 01:50:12 -0600 (MDT)
Message-ID: <37831.129.133.89.141.1184226612.squirrel@webmail.wesleyan.edu>
In-Reply-To: <s5h644rjmn2.wl%tiwai@suse.de>
References: <6849c8890707020427q47704326od05ebb8241c3cf@mail.gmail.com>
    <s5hejjpaiwa.wl%tiwai@suse.de>
    <6849c8890707091407g61fe2f01jc4eb8ee41e624f15@mail.gmail.com>
    <s5h644rjmn2.wl%tiwai@suse.de>
Date:	Thu, 12 Jul 2007 01:50:12 -0600 (MDT)
Subject: Re: [alsa-devel] [RFC] SGI O2 MACE audio ALSA module
From:	sknauert@wesleyan.edu
To:	"Takashi Iwai" <tiwai@suse.de>
Cc:	"TJ" <tj.trevelyan@gmail.com>,
	"Linux MIPS List" <linux-mips@linux-mips.org>,
	"ALSA Dev List" <alsa-devel@alsa-project.org>
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Wesleyan-MailScanner-Information: Please contact the ISP for more information
X-Wesleyan-MailScanner:	Found to be clean
X-Originating-IP: 129.133.6.193
X-MailScanner-From: sknauert@wesleyan.edu
Return-Path: <sknauert@wesleyan.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

Okay, I got the module compiled and it and ALSA installed.

I noticed the timing bug, I doubt its a frequency issue as the ALSA guides
to downsample (i.e. if it were doing 48kHz instead of 44.1kHz) didn't
help.

You mentioned on some players it would sound okay? I tried everything from
aplay to xmms and always seemed to play too fast. What CPU are you running
this on, by the way? Aplay does give underruns if I'm heavily
multitasking, though sound output seems the same.
