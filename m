Received: (from majordomo@localhost)
	by oss.sgi.com (8.9.3/8.9.3) id HAA08667
	for linuxmips-outgoing; Tue, 26 Oct 1999 07:35:56 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linuxmips@oss.sgi.com using -f
Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by oss.sgi.com (8.9.3/8.9.3) with ESMTP id HAA08664
	for <linuxmips@oss.sgi.com>; Tue, 26 Oct 1999 07:35:53 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id HAA07335
	for <linuxmips@oss.sgi.com>; Tue, 26 Oct 1999 07:40:35 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA92846
	for linux-list;
	Tue, 26 Oct 1999 07:21:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA16314
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 26 Oct 1999 07:21:17 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA4322056
	for <linux@cthulhu.engr.sgi.com>; Tue, 26 Oct 1999 07:21:12 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 55F097D9; Tue, 26 Oct 1999 16:21:08 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 5E0EF9011; Tue, 26 Oct 1999 16:17:49 +0200 (CEST)
Date: Tue, 26 Oct 1999 16:17:49 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Richard Hartensveld <richardh@penguin.nl>
Cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: crosscompilers
Message-ID: <19991026161749.H1207@paradigm.rfc822.org>
References: <3814EAA4.40A2E7B7@penguin.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3814EAA4.40A2E7B7@penguin.nl>; from Richard Hartensveld on Mon, Oct 25, 1999 at 11:41:24PM +0000
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk

On Mon, Oct 25, 1999 at 11:41:24PM +0000, Richard Hartensveld wrote:
> Hi,
> 
> Does anyone know where the mips crosscompilers have gone?.
> 
> Also, anyone intrested if I put an indy on a 2mbit backbone and make it
> 'public' for this list to do development
> on for people without an indy at home ?

This or next week there will be a public "mipsel" (Little Endian) 
machine up and running for gcc/binutils/glibc and debian package
building.

I finally managed to get a working libgmp2 for ssh ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
  ...  The failure can be random; however, when it does occur, it is
  catastrophic and is repeatable  ...             Cisco Field Notice
