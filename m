Received:  by oss.sgi.com id <S305166AbQCTTGP>;
	Mon, 20 Mar 2000 11:06:15 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:27478 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCTTFz>; Mon, 20 Mar 2000 11:05:55 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA05145; Mon, 20 Mar 2000 11:09:24 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA72564
	for linux-list;
	Mon, 20 Mar 2000 10:18:17 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA60802;
	Mon, 20 Mar 2000 10:18:13 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id KAA15500;
	Mon, 20 Mar 2000 10:18:13 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14550.27493.513601.286883@liveoak.engr.sgi.com>
Date:   Mon, 20 Mar 2000 10:18:13 -0800 (PST)
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     "Florian Lohoff" <flo@rfc822.org>, <linux@cthulhu.engr.sgi.com>
Subject: Re: header files state
In-Reply-To: <000601bf9243$ba783f10$0ceca8c0@satanas.mips.com>
References: <000601bf9243$ba783f10$0ceca8c0@satanas.mips.com>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Kevin D. Kissell writes:
...
 > And I note with some concernt that, while in the PC Linux
 > universe, asm/socket.h, linux/socket.h, and bits/socket.h
 > all have the same definitions for the socket types
 > (SOCK_STREAM = 1, for example), in the MIPS/LINUX
 > kernel, SOCK_STREAM = 2, though there is still the
 > definition, conditional on
 > #if !defined(__KERNEL__) && (!defined(__GLIBC__) || (__GLIBC__ < 2))
 > that defines SOCK_STREAM to be 1.  Fortunately, the
 > probability of someone using non-glibc or glibc < 2 in
 > a MIPS/Linux universe seems to be essentially zero.
...

     SOCK_STREAM == 2 is correct for the MIPS ABI (which has to do with
some unfortunate choices made by AT&T in SVR4, and consequent binary-compatibility
issues for various of the MIPS ABI participants).
