Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Oct 2002 20:56:01 +0100 (CET)
Received: from mailhost.taec.com ([209.243.128.33]:39296 "EHLO
	mailhost.taec.toshiba.com") by linux-mips.org with ESMTP
	id <S1122121AbSJaT4A>; Thu, 31 Oct 2002 20:56:00 +0100
Received: from hdqmta.taec.com (hdqmta.taec.com [209.243.180.59])
	by mailhost.taec.toshiba.com (8.8.8+Sun/8.8.8) with ESMTP id LAA17639;
	Thu, 31 Oct 2002 11:55:46 -0800 (PST)
Subject: Re: NFS Root broken in 2.4.18?  Anyone successfully booted?
To: "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>,
	linux-mips-bounce@linux-mips.org
X-Mailer: Lotus Notes Release 5.0.10  March 22, 2002
Message-ID: <OFEE55B060.FA262D5E-ON88256C63.006BFD0A-88256C63.006D747E@taec.com>
From: Saugata.Chatterjee@taec.toshiba.com
Date: Thu, 31 Oct 2002 11:57:03 -0800
X-MIMETrack: Serialize by Router on HDQMTA/TOSHIBA_TAEC(Release 5.0.8 |June 18, 2001) at
 10/31/2002 11:54:58 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Return-Path: <Saugata.Chatterjee@taec.toshiba.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Saugata.Chatterjee@taec.toshiba.com
Precedence: bulk
X-list: linux-mips


Roger,

   We do nfsroot mounts with 2.4.18 on our boards here, and it works fine.
I have used a TC35815 Ethernet chip and a RealTek 8139 card and both are
okay.

 So your problem is probably something else...

Regards,

-Saugata Chatterjee



                                                                                                                      
                    "TWEDE,ROGER                                                                                      
                    (HP-Boise,ex1)"              To:     "'Ralf Baechle'" <ralf@linux-mips.org>, "TWEDE,ROGER         
                    <roger_twede@hp.com>          (HP-Boise,ex1)" <roger_twede@hp.com>                                
                    Sent by:                     cc:     "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>    
                    linux-mips-bounce@linu       Subject:     NFS Root broken in 2.4.18?  Anyone successfully booted? 
                    x-mips.org                                                                                        
                                                                                                                      
                                                                                                                      
                    10/31/2002 10:28 AM                                                                               
                                                                                                                      
                                                                                                                      




Ralf et al,

I found that the 2.4.18 system boots fine when booting from standard
devices
(IDE disks etc.).

Init fails to execute successfully when booting from NFS.  The NFS booting
success appears to have died with 2.4.18.

The NFS boot completes fine in 2.4.17 but in 2.4.18 the NFS root is mounted
and /sbin/init and the ld.so.1 are at least accessed, but the system never
executes far enough in user space to even print a message to the console.

I've tried two different network card types just to be sure it wasn't a
single driver issue.

Has anyone noticed this or does anyone know what changes may have caused
this in 2.4.18?
I'm curious whether anyone has successfully booted 2.4.18 over NFS.

Thanks,

Roger Twede
Hewlett Packard

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org]
Sent: Wednesday, October 30, 2002 8:06 AM
To: TWEDE,ROGER (HP-Boise,ex1)
Cc: 'linux-mips@linux-mips.org'
Subject: Re: Recent Kernel Page Fault Problems Spawning Init?


On Tue, Oct 29, 2002 at 05:53:15PM -0500, TWEDE,ROGER (HP-Boise,ex1) wrote:

> I would be appreciative of any advice anyone can offer in this regard.
>
> Were any fundamental kernel changes made in the 2.4.17 through 2.4.19
> timeframe which could explain why the spawning of init would hang?
>
> After mounting a root filesystem and attempting to spawn init, 3 or 4
page
> faults occur.  The entry point of init, its bss section and an elf loader
> .text section get hit, etc.  followed by an endless series of page faults
to
> a bad address which just faults repeatedly, never allowing init or the
elf
> loader to proceed.
>
> I've tried a RM 7000A and 20KC based boards so far with apparently
identical
> behavior on both.

Various people have reported this kind of problem in past but so far all of
them turned out some local problem.  20kc and RM7000 are both supposed to
be
working fine.

  Ralf
