Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2005 06:05:15 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:14517 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225003AbVH3FFA>; Tue, 30 Aug 2005 06:05:00 +0100
Received: from localhost ([127.0.0.1])
	by real.realitydiluted.com with esmtp (Exim 4.50 #1 (Debian))
	id 1E9xT0-0002TS-Pl; Mon, 29 Aug 2005 23:11:22 -0500
Message-ID: <4313EA65.7090306@realitydiluted.com>
Date:	Tue, 30 Aug 2005 00:11:01 -0500
From:	"Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	uclibc@uclibc.org, linux-mips@linux-mips.org
Subject: NPTL uClibc status update...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Greetings.

Now that I have all my work up to date and checked in, I thought I would
give a brief status of NPTL. With the latest from 'uClibc-nptl' branch,
binutils-2.16.1 and gcc-4.1.0-20050604 a complete NPTL toolchain can be
built. This toolchain can also compile an entire buildroot. Granted, the
binaries will not run, but this means that the new NPTL libraries are
properly exporting all the symbols necessary for applications to build
and weak symbols interactions are doing what they should.

I am currently now building static test programs from glibc for uClibc to
get TLS binaries for MIPS working. Don't expect a lot of activity in the
upcoming days as I will be debugging all the problems with TLS on MIPS.
Thanks for your patience.

-Steve
