Received:  by oss.sgi.com id <S554276AbRBZXlM>;
	Mon, 26 Feb 2001 15:41:12 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:34395 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S553847AbRBZXlA>;
	Mon, 26 Feb 2001 15:41:00 -0800
Received: from sydney.sydney.sgi.com (sydney.sydney.sgi.com [134.14.48.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id PAA11895
	for <linux-mips@oss.sgi.com>; Mon, 26 Feb 2001 15:39:55 -0800 (PST)
	mail_from (kaos@melbourne.sgi.com)
Received: from kao2.melbourne.sgi.com by sydney.sydney.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	 id KAA08771; Tue, 27 Feb 2001 10:39:32 +1100
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     michaels@jungo.com
cc:     linux-mips@oss.sgi.com
Subject: Re: ELF header kernel module wrong? 
In-reply-to: Your message of "Mon, 26 Feb 2001 13:17:42 +0200."
             <3A9A3B56.B0141D21@jungo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 27 Feb 2001 10:39:39 +1100
Message-ID: <23954.983230779@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 26 Feb 2001 13:17:42 +0200, 
michaels@jungo.com wrote:
>If what you say is correct, then any module created by this toolchain
>would be impossible to 'insmod'

Not impossible, just silently corrupted if the symbol numbers were
wrong.  modutils 2.3.11 added a sanity check on the number of local
symbols, a version before 2.3.11 would accept any local symbol number
and overrun the allocated table if the number was out of bounds.

Sometimes the toolchain creates valid symbol numbers, sometimes an
invalid number will not cause any problems.  It is pure luck if it
works.
