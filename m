Received:  by oss.sgi.com id <S305167AbQCTTg0>;
	Mon, 20 Mar 2000 11:36:26 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:8509 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQCTTgS>;
	Mon, 20 Mar 2000 11:36:18 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA23259; Mon, 20 Mar 2000 11:31:39 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA37713
	for linux-list;
	Mon, 20 Mar 2000 10:52:14 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA09259;
	Mon, 20 Mar 2000 10:22:30 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id KAA15792;
	Mon, 20 Mar 2000 10:22:30 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14550.27750.579401.146127@liveoak.engr.sgi.com>
Date:   Mon, 20 Mar 2000 10:22:30 -0800 (PST)
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     "Andreas Jaeger" <aj@suse.de>, "Florian Lohoff" <flo@rfc822.org>,
        <linux@cthulhu.engr.sgi.com>
Subject: Re: header files state
In-Reply-To: <004401bf924e$f0c526e0$0ceca8c0@satanas.mips.com>
References: <004401bf924e$f0c526e0$0ceca8c0@satanas.mips.com>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Kevin D. Kissell writes:
 > >Linus has stated quite violantly that glibc should not include any
 > >kernel headers at all - and we're now including less and less
 > >headers.  But this process needs time and occasionally breaks older
 > >glibc's.
 > 
 > What is Linus' rationale for his position?   It's true that 
 > having includes "reaching in" from libc imposes constraints
 > on kernel designers, but failure to do so is guaranteed
 > to induce error - as we have seen.

     In this particular case (MIPS-based systems), both glibc and the kernel 
attempt to be MIPS ABI compliant, so there is no real issue in having the
various definitions in two places, since there is an external reference,
just as there is for the processor itself.

     More generally, having a real ABI definition for the key system libraries,
such as libc, is a virtue; it reduces gratuitous "innovation".  Many architectures
have an ABI definition, at least for the basics.  
