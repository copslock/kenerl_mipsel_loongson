Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA83295 for <linux-archive@neteng.engr.sgi.com>; Tue, 22 Sep 1998 14:13:32 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA01793
	for linux-list;
	Tue, 22 Sep 1998 14:12:37 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (ripple.nashua.sgi.com [169.238.59.194])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA66457;
	Tue, 22 Sep 1998 14:12:35 -0700 (PDT)
	mail_from (lembree@sgi.com)
Message-ID: <3608103B.6F2844E2@sgi.com>
Date: Tue, 22 Sep 1998 17:01:47 -0400
From: Rob Lembree <lembree@sgi.com>
Organization: Silicon Graphics, Inc.
X-Mailer: Mozilla 4.5b1C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Hartensveld <richardh@infopact.nl>, linux@cthulhu.engr.sgi.com
Subject: Re: challenge s boots linux
References: <36081277.17A50BC9@infopact.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

hmm, I had the same problem on my Indy.  I found that 
IRIX had stripped the major and minor numbers from the
device files in the tar distribution -- the answer was to
untar using Linux, not IRIX (gtar doesn't help), or to 
manually recreate the dev files.

Try that, and I bet it fixes it.

-- 

Rob Lembree                Strategic Software Organization

Silicon Graphics, Inc.                  http://www.sgi.com
One Cabot Road                             rob@lembree.com
Hudson, MA 01749                           lembree@sgi.com
Phone: 978-567-2141                      FAX: 978-567-2341

PGP: 1F EE F8 58 30 F1 B1 20  C5 4F 12 21 AD 0D 6B 29
