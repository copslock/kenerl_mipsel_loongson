Received:  by oss.sgi.com id <S42281AbQEXLwD>;
	Wed, 24 May 2000 04:52:03 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:23670 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42277AbQEXLvp>;
	Wed, 24 May 2000 04:51:45 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id EAA14351; Wed, 24 May 2000 04:46:53 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA59853
	for linux-list;
	Wed, 24 May 2000 04:44:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA17197
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 24 May 2000 04:44:44 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA00527
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 May 2000 04:44:42 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from bert.physik.uni-konstanz.de [134.34.144.20] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 12uZag-0007pq-00; Wed, 24 May 2000 13:44:46 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Wed, 24 May 2000 13:43:33 +0200
Date:   Wed, 24 May 2000 13:42:15 +0200
From:   Guido Guenther <agx@bert.physik.uni-konstanz.de>
To:     Mitja Bezget <gw@sers.s-sers.mb.edus.si>
Subject: Re: newport driver for XFree
Message-ID: <20000524134215.A3748@bert.physik.uni-konstanz.de>
References: <Pine.LNX.3.95.1000524093350.6454A-200000@sers.s-sers.mb.edus.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
In-Reply-To: <Pine.LNX.3.95.1000524093350.6454A-200000@sers.s-sers.mb.edus.si>; from gw@sers.s-sers.mb.edus.si on Wed, May 24, 2000 at 12:31:49PM +0200
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, May 24, 2000 at 12:31:49PM +0200, Mitja Bezget wrote:
> hi!
> 
> I'm having problems running xfree on an old Indy
> so i tought i should report&ask for help..
> 
> First I applyed the patch (is it recent??):
There's a newer patch available on that site but this one should work
also.

> 
> # tar -xzvf X400src.tgz
> # cd xc
> # patch -p0 <newport_000514.diff
> (files are from a webpage previously posted)
> 
> and it didn't create drivers/newport/ directory.. (it exited
> cleanly!)
> should i have done something else before that?
> Anyway.. i created the missing files by hand..
> afterwards it failed again while making World
> 
> newport.c:136: `MGA' undeclared (first use of this function)
This comes from the NewPortSetup function which should only be compiled
if the server supports loadable modules. We currently don't do this on
mips. Add a "#define DoLoadableServer NO" to your host.def and recompile. 
This will probably also fix the problem below:

> newport.c:774: `caddr_t' undeclared (first use of this function)
> + some other errors originating from here..
> 
> i fixed the caddr_t (missing #include <sys/types.h>)
> i changed  MDA to NEWPORT and it compiled ok!  and i was happy!
> 
> But now it just wont run.. error message is attached..
> I think it has something to do with socketbits.h and declaration
> of enum __socket_type.. Namely i added this enum because i couldn't
> find #define for socket types in any of system installed header
> files.. (The very first reason server didn't compile) 
Why did the compile break?
> 
> i'm running glibc-2.0.6-4 (+devel) and egcs-1.0.2-9..
> 
> Thank you!
> 
> cya 
> Mitja
> 	
> ps. for Guido (or who coded that part):
> i went thru newport_regs.h and i noticed your comment in line 153
> /* This causes a warning. Why??? */
> I believe it was just a simple innocent typo.. you pressed
> the semi-colon twice. ;)) 
I'm aware of that. It's just a reminder for me to check the c-specs why a 
"useless" semicolon causes a compiler warning at all.

[..snip..] 
-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
