Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FEg4K19084
	for linux-mips-outgoing; Fri, 15 Feb 2002 06:42:04 -0800
Received: from server3.toshibatv.com (mail.toshibatv.com [67.32.37.75])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FEg1919081
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 06:42:01 -0800
Received: by SERVER3 with Internet Mail Service (5.5.2653.19)
	id <ZNHAMHPW>; Fri, 15 Feb 2002 07:41:32 -0600
Message-ID: <7DF7BFDC95ECD411B4010090278A44CA1B7578@ATVX>
From: "Siders, Keith" <keith_siders@toshibatv.com>
To: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: hot patching
Date: Fri, 15 Feb 2002 07:39:49 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I posted a general question a couple months back about this. Now that I have
an approach in place, I wanted to see if the approach is workable before I
spend a bunch of time trying to debug an approach that absolutely won't work
for some fundamental reason. I am not yet a kernel guru (don't know that I
want to be) but this "feature" seems to require intimate knowledge of the
inner workings of the kernel's memory management.

I'm attempting to set up a "hot patcher" in an embedded product. I'm
attempting to use shared memory, however the "target" process is not aware
of the patch being applied to it. Can a pseudo-driver attach a shared memory
segment to a process which can then be executable by that process via a jump
or jump-and-link, or is shared memory only for passing data and messages
between collaborating processes? The references I've read only indicate the
RW permissions, no X permissions. Or should I have the pseudo-driver
actually allocate (by get_free_pages()) the memory required? And can it do
this on behalf of the target process?

If neither of these look workable, I've been thinking about the concept of
using software interrupts. Any thoughts? Any constructive comments and/or
insights greatly appreciated.

++++++++++++++++++++++++++++++++++++++++++++++++++
Keith Siders
Software Engineer
 Toshiba 
Advanced Television Technology Center
++++++++++++++++++++++++++++++++++++++++++++++++++
