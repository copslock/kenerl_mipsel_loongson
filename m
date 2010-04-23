Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2010 12:08:27 +0200 (CEST)
Received: from lo.gmane.org ([80.91.229.12]:44514 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492321Ab0DWKIX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Apr 2010 12:08:23 +0200
Received: from list by lo.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1O5Fo0-0004Ms-7u
        for linux-mips@linux-mips.org; Fri, 23 Apr 2010 12:08:16 +0200
Received: from chipmunk.wormnet.eu ([195.195.131.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Fri, 23 Apr 2010 12:08:16 +0200
Received: from alex by chipmunk.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Fri, 23 Apr 2010 12:08:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
connect(): No such file or directory
From:   Alexander Clouter <alex@digriz.org.uk>
Subject: Re: Ask help:why my 64-bit ELF file could not run at the 64-bit mips         cpu
Date:   Fri, 23 Apr 2010 10:34:23 +0100
Message-ID: <v568a7-oj5.ln1@chipmunk.wormnet.eu>
References: <j2sdf5e30c51004172251z9fd01867h562b99c1f1044c26@mail.gmail.com>         <q2odf5e30c51004220901l8bfa979ftc9c6a7b633569460@mail.gmail.com>         <4BD08329.80804@adax.com> <h2hdf5e30c51004230142q21184429pffcaa9351510bc2d@mail.gmail.com>
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: chipmunk.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-2-sparc64-smp (sparc64))
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

Dominic <dominicwj@gmail.com> wrote:
> 
> Thanks a lot for your precious reply! I try to use -static to compile
> the program, then the 64-bit program can run, so it should be the
> library related other than 64-bit instruction or addressing related.
> Then I stored the 64-bit libraries in nfs, and mount it on the target
> board, after adding the path to ld.so.conf and 'ldconfig', the program
> compiled without -static still does not run. Shall I miss something?
> 
On your host, you can type something like:
----
alex@berk:/usr/src/wag54g$ readelf -d buildroot/output/target/usr/sbin/ip6tables-multi  | grep Shared
 0x00000001 (NEEDED)                     Shared library: [libip6tc.so.0]
 0x00000001 (NEEDED)                     Shared library: [libxtables.so.4]
 0x00000001 (NEEDED)                     Shared library: [libdl.so.0]
 0x00000001 (NEEDED)                     Shared library: [libm.so.0]
 0x00000001 (NEEDED)                     Shared library: [libc.so.0]
----

This will list all the libraries that you need installed[1], I'm guessin 
you have missed one.

You can look at the output of 'readelf -a' to try to see what might be 
missing.

Cheers

[1] in addition to the interpreter required (for example 'ld-uClibc') 
	and the main C library being used:
	readelf -l buildroot/output/target/usr/sbin/ip6tables-multi

-- 
Alexander Clouter
.sigmonster says: "Ninety percent of baseball is half mental."
                  		-- Yogi Berra
