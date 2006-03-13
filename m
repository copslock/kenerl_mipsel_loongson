Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2006 20:31:12 +0000 (GMT)
Received: from fw-ca-1-hme0.vitesse.com ([64.215.88.90]:64321 "EHLO
	email.vitesse.com") by ftp.linux-mips.org with ESMTP
	id S8133791AbWCMUbD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2006 20:31:03 +0000
Received: from wilson.vitesse.com (wilson [10.9.72.71])
	by email.vitesse.com (8.11.0/8.11.0) with ESMTP id k2DKdr309004;
	Mon, 13 Mar 2006 12:39:54 -0800 (PST)
Received: from MX-COS.vsc.vitesse.com (mx-cs1 [10.9.72.41])
	by wilson.vitesse.com (8.11.6/8.11.6) with ESMTP id k2DKeJb21296;
	Mon, 13 Mar 2006 13:40:19 -0700 (MST)
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Cross compile kernel w/ buildroot toolchain
Date:	Mon, 13 Mar 2006 13:39:53 -0700
Message-ID: <389E6A416914954182ECDFCD844D8269434FBF@MX-COS.vsc.vitesse.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Cross compile kernel w/ buildroot toolchain
Thread-Index: AcZG3W4scpogvdgGT82HegZ9qgvaXwAAF9vg
From:	"Kurt Schwemmer" <kurts@vitesse.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <kurts@vitesse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kurts@vitesse.com
Precedence: bulk
X-list: linux-mips

I got 2.6.15 "a while back" (>1 month). 

I'll try getting the most recent source. Sorry, I avoided this due to my
company blocking rsync and thus making it a pain to get the sources... 

Thanks,
Kurt

> -----Original Message-----
> From: Ralf Baechle [mailto:ralf@linux-mips.org] 
> Sent: Monday, March 13, 2006 1:33 PM
> To: Kurt Schwemmer
> Cc: linux-mips@linux-mips.org
> Subject: Re: Cross compile kernel w/ buildroot toolchain
> 
> On Mon, Mar 13, 2006 at 01:17:09PM -0700, Kurt Schwemmer wrote:
> 
> > I'm trying to figure out a toolchain to use for my system. I can 
> > compile the kernel just fine using the MIPS SDE based distribution, 
> > but you can't cross compile apps with that. I downloaded and built 
> > buildroot and I'm trying to (cross) compile the kernel with it too 
> > (I'd like to just use one compiler for everything). I had 
> it use gcc 
> > 3.4.5. When I try to compile the kernel with:
> > 
> > make
> > CROSS_COMPILE=~/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-
> > 
> > I eventually get an error while assembling entry.o:
> >   AS      arch/mips/kernel/entry.o
> > arch/mips/kernel/entry.S: Assembler messages:
> > arch/mips/kernel/entry.S:157: Error: opcode not supported on this
> > processor: mips32 (mips32) `jr.hb $31'
> > make[1]: *** [arch/mips/kernel/entry.o] Error 1
> > make: *** [arch/mips/kernel] Error 2
> > 
> > I guess this is a "hazard barrier" instruction. Why doesn't 
> gcc 3.4.5 
> > know about it? What do I need to do to get this to work?
> 
> I'm looking at the latest kernel sources and can't see how 
> this could be happening.  Which version of the kernel are you 
> trying to build?
> 
>   Ralf
> 
