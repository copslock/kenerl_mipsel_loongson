Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5D8Q0nC024673
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 13 Jun 2002 01:26:00 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5D8Q0D9024672
	for linux-mips-outgoing; Thu, 13 Jun 2002 01:26:00 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from deliverator.sgi.com (deliverator.SGI.COM [204.94.214.10])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5D8PvnC024669
	for <linux-mips@oss.sgi.com>; Thu, 13 Jun 2002 01:25:57 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) 
	by deliverator.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA03216
	for <linux-mips@oss.sgi.com>; Thu, 13 Jun 2002 01:28:27 -0700 (PDT)
	mail_from (kaos@sgi.com)
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180])
	by nodin.corp.sgi.com (8.12.3/8.11.4/nodin-1.0) with ESMTP id g5D8RPEd9956954;
	Thu, 13 Jun 2002 01:27:26 -0700 (PDT)
Received: by kao2.melbourne.sgi.com (Postfix, from userid 16331)
	id 751673000BA; Thu, 13 Jun 2002 18:27:24 +1000 (EST)
Received: from kao2.melbourne.sgi.com (localhost [127.0.0.1])
	by kao2.melbourne.sgi.com (Postfix) with ESMTP
	id 6714D94; Thu, 13 Jun 2002 18:27:24 +1000 (EST)
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: "Sam" <iskoo@ms45.hinet.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: # ld.script syntax 
In-reply-to: Your message of "Thu, 13 Jun 2002 16:13:11 +0800."
             <004801c212b2$295c7900$780411ac@sam> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Jun 2002 18:27:19 +1000
Message-ID: <4102.1023956839@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 13 Jun 2002 16:13:11 +0800, 
"Sam" <iskoo@ms45.hinet.net> wrote:
>I try to find the relation about the setup of ramdisk initrd
>From the sample of Philp Nino, I found the ld.script.in on /arch/mips/
>But I do not understand the syntax of ld script,
>Does anybody tell me where to find the relevent document to understand the
>file,

info ld, option 'Scripts'.
