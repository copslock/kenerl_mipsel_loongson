Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2CLjZL24940
	for linux-mips-outgoing; Tue, 12 Mar 2002 13:45:35 -0800
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2CLjW924937
	for <linux-mips@oss.sgi.com>; Tue, 12 Mar 2002 13:45:32 -0800
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 16kt94-0002F8-00; Tue, 12 Mar 2002 21:45:18 +0100
Date: Tue, 12 Mar 2002 21:45:18 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Lanny DeVaney <ldevaney@redhat.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: gdbserver
Message-ID: <20020312204518.GA8593@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Lanny DeVaney <ldevaney@redhat.com>, linux-mips@oss.sgi.com
References: <3C8E5560.2090907@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C8E5560.2090907@redhat.com>
User-Agent: Mutt/1.3.27i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Mar 12, 2002 at 01:22:08PM -0600, Lanny DeVaney wrote:
> I've looked back through the archives and find some references to 
> problems configuring and/or building gdbserver for mips-linux.
> 
> I'm attempting to build gdb/gdbserver with --target=mips-linux as well, 
> using gdb-5.1.1.  Have the earlier issues (they looked to be 1-2 years 
> old) been resolved or am I still looking at a "manual build" process? 
> I'm getting lots of errors with the build, although the configure seems 
> to go OK.  x86 host, linux-mips target.

I tried the gdb+dejagnu-20020305 snapshot recently and
both gdb and gdbserver built without problems. IIRC
gdbserver was still broken in gdb-5.1.1.
I haven't used the newly built gdbserver yet, though.

Regards,
Johannes
