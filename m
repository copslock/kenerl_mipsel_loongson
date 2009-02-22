Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Feb 2009 20:11:10 +0000 (GMT)
Received: from ix.technologeek.org ([213.41.253.186]:14472 "EHLO
	sonic.technologeek.org") by ftp.linux-mips.org with ESMTP
	id S20807911AbZBVULI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Feb 2009 20:11:08 +0000
Received: by sonic.technologeek.org (Postfix, from userid 1000)
	id BBCA5185592E; Sun, 22 Feb 2009 21:11:08 +0100 (CET)
From:	Julien BLACHE <jb@jblache.org>
To:	linux-mips@linux-mips.org
Subject: Re: (Newport) console problems on IP22
References: <873ae6ck2h.fsf@sonic.technologeek.org>
Date:	Sun, 22 Feb 2009 21:11:08 +0100
In-Reply-To: <873ae6ck2h.fsf@sonic.technologeek.org> (Julien BLACHE's message
	of "Sun, 22 Feb 2009 21:07:02 +0100")
Message-ID: <87y6vyb5b7.fsf@sonic.technologeek.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.21 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <jb@jblache.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jb@jblache.org
Precedence: bulk
X-list: linux-mips

Julien BLACHE <jb@jblache.org> wrote:

>  - getty process stuck
>
>  root      1226 98.7  0.0      0     0 tty1     Rs+  19:48   9:22 [getty]
>
> gettys on tty[2-6] might also be stuck somewhere. Can't strace the
> getty on tty1 (operation not permitted) and strace on tty[2-6]
> attaches to the process but doesn't print anything and is stuck from
> here on. Cannot detach or anything. Processes are of course
> unkillable.

Looks like the strace on the getty process on tty2 led to something
hanging to the point my serial console on ttyS0 was hung after that.

But I could still log in via SSH, so the kernel keeps running fine
despite that.

JB.

-- 
Julien BLACHE                                   <http://www.jblache.org> 
<jb@jblache.org>                                  GPG KeyID 0xF5D65169
