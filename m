Received:  by oss.sgi.com id <S553828AbQKRNrF>;
	Sat, 18 Nov 2000 05:47:05 -0800
Received: from ppp0.ocs.com.au ([203.34.97.3]:53262 "HELO mail.ocs.com.au")
	by oss.sgi.com with SMTP id <S553826AbQKRNqh>;
	Sat, 18 Nov 2000 05:46:37 -0800
Received: (qmail 7608 invoked from network); 18 Nov 2000 13:46:20 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 18 Nov 2000 13:46:19 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: sysmips syscall 
In-reply-to: Your message of "Sat, 18 Nov 2000 11:59:09 BST."
             <20001118115909.D8672@bacchus.dhis.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sun, 19 Nov 2000 00:46:19 +1100
Message-ID: <23098.974555179@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 18 Nov 2000 11:59:09 +0100, 
Ralf Baechle <ralf@oss.sgi.com> wrote:
>You can base a spinlock implementation on the fact that the register k0
>will be left at a value != zero after any exception, also including context
>switches.
>
>Problem: this solution breaks silently on multiproessor systems.

Use Dekker's algorithm between systems.  It requires cache coherent
memory but does not need any inter cpu locking mechanisms.

http://www.cs.wvu.edu/~jdm/classes/cs356/notes/mutex/Dekker.html
describes the algorithm for the two cpu case.  It assumes no preemption
on each cpu so it has to be modified to handle interrupts.  Add a local
lock so you are the only code on this processor trying to use Dekker
between processors.
