Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2KD0BU27681
	for linux-mips-outgoing; Wed, 20 Mar 2002 05:00:11 -0800
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2KD08927678
	for <linux-mips@oss.sgi.com>; Wed, 20 Mar 2002 05:00:09 -0800
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 16nfiS-0002ib-00; Wed, 20 Mar 2002 14:01:20 +0100
Date: Wed, 20 Mar 2002 14:01:20 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Krishna Kondaka <krishna@Sanera.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: Application stack trace facility
Message-ID: <20020320130120.GA9983@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Krishna Kondaka <krishna@Sanera.net>, linux-mips@oss.sgi.com
References: <200203192013.g2JKDsD02409@icarus.sanera.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203192013.g2JKDsD02409@icarus.sanera.net>
User-Agent: Mutt/1.3.27i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Mar 19, 2002 at 12:13:54PM -0800, Krishna Kondaka wrote:
> 	I would like to know if there is a system call/library function 
> 	available in linux which prints the current stack trace of the 
> 	application.

The Glib has a function g_on_error_stack_trace() which does this
in a slightly hackish way by attaching gdb to the crashed program
(to be called from a SIGSEGV handler).
Look at gbacktrace.c there:
http://cvs.gnome.org/bonsai/rview.cgi?cvsroot=/cvs/gnome&dir=glib/glib&module=.

HTH,
Johannes
