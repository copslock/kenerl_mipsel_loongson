Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4ULvLnC003618
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 14:57:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4ULvL1m003617
	for linux-mips-outgoing; Thu, 30 May 2002 14:57:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from irongate.swansea.linux.org.uk (pc2-cwma1-5-cust12.swa.cable.ntl.com [80.5.121.12])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4ULvFnC003614
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 14:57:16 -0700
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.2/8.11.6) with ESMTP id g4UN2lZ1017552;
	Fri, 31 May 2002 00:02:48 +0100
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.2/8.12.2/Submit) id g4UN2jmc017550;
	Fri, 31 May 2002 00:02:45 +0100
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: system() function
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Siders, Keith" <keith_siders@toshibatv.com>
Cc: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
In-Reply-To: <7DF7BFDC95ECD411B4010090278A44CA379B17@ATVX>
References: <7DF7BFDC95ECD411B4010090278A44CA379B17@ATVX>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 31 May 2002 00:02:45 +0100
Message-Id: <1022799765.9255.400.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 2002-05-30 at 17:01, Siders, Keith wrote:
> I was planning to use system() to invoke a shell and launch a script.

You can do that yes

> However it appears that this causes the parent process to terminate. A note

No it doesn't

> in Linux Programming Bible (Goerzen, 2000) says to never invoke a shell or
> use the system() function. Having looked at fork() and exec(), these will
> require obscene amounts of memory and overhead (for an embedded box). I've

Nope.

> also looked at vfork() and execve(), which looks like it will do what I
> want. So do I do the vfork()/execve() pair, or is there a better way? And
> would sigaction() handling be the way to pass progress information from the
> child back to the parent process?

system is actually implemented using either vfork/execve or fork/execve
to run your command through the shell. It works great but you do need to
remember its going via the shell so things like "*" will be expanded.

fork creates a copy on write clone of the process (ie the program data
is not actually copied unless either task writes to it), so it generally
uses very little ram indeed, especially when one of them exec's
something
