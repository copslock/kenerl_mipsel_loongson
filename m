Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4UIeYnC026499
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 11:40:34 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4UIeYU3026498
	for linux-mips-outgoing; Thu, 30 May 2002 11:40:34 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms1.broadcom.com (mms1.broadcom.com [63.70.210.58])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4UIeTnC026494
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 11:40:29 -0700
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 MMS-1 SMTP Relay (MMS v4.7)); Thu, 30 May 2002 11:41:34 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from ldt-sj3-022.sj.broadcom.com (ldt-sj3-022 [10.21.64.22])
 by mail-sj1-5.sj.broadcom.com (8.12.2/8.12.2) with ESMTP id
 g4UIg11S015644; Thu, 30 May 2002 11:42:01 -0700 (PDT)
Received: (from carlson@localhost) by ldt-sj3-022.sj.broadcom.com (
 8.11.6/8.9.3) id g4UIg1F12762; Thu, 30 May 2002 11:42:01 -0700
X-Authentication-Warning: ldt-sj3-022.sj.broadcom.com: carlson set
 sender to justinca@cs.cmu.edu using -f
Subject: Re: system() function
From: "Justin Carlson" <justinca@cs.cmu.edu>
To: "Siders, Keith" <keith_siders@toshibatv.com>
cc: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
In-Reply-To: <7DF7BFDC95ECD411B4010090278A44CA379B17@ATVX>
References: <7DF7BFDC95ECD411B4010090278A44CA379B17@ATVX>
X-Mailer: Ximian Evolution 1.0.5
Date: 30 May 2002 11:42:01 -0700
Message-ID: <1022784121.7643.457.camel@ldt-sj3-022.sj.broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 10E8ADD448107-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Thu, 2002-05-30 at 09:01, Siders, Keith wrote:
> I was planning to use system() to invoke a shell and launch a script.
> However it appears that this causes the parent process to terminate. A note
> in Linux Programming Bible (Goerzen, 2000) says to never invoke a shell or
> use the system() function. Having looked at fork() and exec(), these will
> require obscene amounts of memory and overhead (for an embedded box).

I'm not sure that fork() qualifies as an "obscene amount of overhead". 
That may have been true before copy-on-write, but the only thing vfork()
saves you with respect to fork() is page table construction, which is
not particularly memory or processor intensive.

> I've
> also looked at vfork() and execve(), which looks like it will do what I
> want. So do I do the vfork()/execve() pair, or is there a better way? And
> would sigaction() handling be the way to pass progress information from the
> child back to the parent process?

As a personal preference, I dislike vfork() since it's pretty
nonstandard in its behaviour on linux.  Generally, though, it sounds
like maybe you'd benefit from a copy  of Kernighan & Pike's _The Unix
Programming Environment_.  There are more ways to do interprocess
communication than you can shake a stick at, and which one is "right"
for you depends largely on your specific application.  Signals is a
reasonable way (though if you vfork() you won't be able to handle
signals in your parent concurrent with the child running...).  There are
also named pipes, shared memory, SysV messaging...

-Justin
