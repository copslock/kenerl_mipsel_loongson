Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAK1J2V17052
	for linux-mips-outgoing; Mon, 19 Nov 2001 17:19:02 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAK1IxW17034
	for <linux-mips@oss.sgi.com>; Mon, 19 Nov 2001 17:19:00 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA02253
	for <linux-mips@oss.sgi.com>; Mon, 19 Nov 2001 16:18:41 -0800 (PST)
	mail_from (kaos@melbourne.sgi.com)
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180])
	by nodin.corp.sgi.com (8.11.4/8.11.2/nodin-1.0) with ESMTP id fAK0FD413100982;
	Mon, 19 Nov 2001 16:15:14 -0800 (PST)
Received: by kao2.melbourne.sgi.com (Postfix, from userid 16331)
	id A3559300095; Tue, 20 Nov 2001 11:15:10 +1100 (EST)
Received: from kao2.melbourne.sgi.com (localhost [127.0.0.1])
	by kao2.melbourne.sgi.com (Postfix) with ESMTP
	id 438C796; Tue, 20 Nov 2001 11:15:10 +1100 (EST)
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@melbourne.sgi.com>
To: "Siders, Keith" <keith_siders@toshibatv.com>
Cc: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: Re: Memory mapping 
In-reply-to: Your message of "Mon, 19 Nov 2001 10:18:23 MDT."
             <7DF7BFDC95ECD411B4010090278A44CA1B743F@ATVX> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Nov 2001 11:15:04 +1100
Message-ID: <9740.1006215304@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 19 Nov 2001 10:18:23 -0600, 
"Siders, Keith" <keith_siders@toshibatv.com> wrote:
>OK, now that I've spent a couple weeks looking at Linux memory management,
>can someone please help me straighten this out. First, I have a requirement
>to "unobtrusively" hot-patch instruction code ( and probably data also )
>segments in memory.

At the risk of stating the obvious, have you looked at the ptrace code
in arch/$(ARCH)/kernel/ptrace.c?  That already does all the work for
reading and writing code and data.
