Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FFJjn22739
	for linux-mips-outgoing; Fri, 15 Feb 2002 07:19:45 -0800
Received: from server3.toshibatv.com (mail.toshibatv.com [67.32.37.75])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FFJf922736
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 07:19:42 -0800
Received: by SERVER3 with Internet Mail Service (5.5.2653.19)
	id <ZNHAMHQ7>; Fri, 15 Feb 2002 08:19:13 -0600
Message-ID: <7DF7BFDC95ECD411B4010090278A44CA1B7579@ATVX>
From: "Siders, Keith" <keith_siders@toshibatv.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: RE: hot patching
Date: Fri, 15 Feb 2002 08:17:30 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="windows-1252"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

-> > I'm attempting to set up a "hot patcher" in an embedded 
-> >product. I'm
...
-> 
-> You shouldnt even need a driver if you are clever. The 
-> ptrace() functionality
-> for debuggers is sufficient to patch running code, and to do 
-> other interesting
-> things by adding new functions and calling them
-> 
Well, I never claimed to be terribly clever...
When I looked at the ptrace code it looked to me like it was intended for
inserting breakpoints for the most part. Are you saying that I can patch
into a process and have it vector off to executable code? At this point I've
identified at least three types of patches: a jump, a call, and simply
overwrite a few instructions (the easiest and common to all types). I'd love
to _not_ need a driver.

--------------------------------------
Keith Siders
Toshiba 
ATVTC
--------------------------------------
