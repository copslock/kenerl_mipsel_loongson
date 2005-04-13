Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2005 20:49:52 +0100 (BST)
Received: from bay101-f39.bay101.hotmail.com ([IPv6:::ffff:64.4.56.49]:35380
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225936AbVDMTta>; Wed, 13 Apr 2005 20:49:30 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Wed, 13 Apr 2005 12:49:21 -0700
Message-ID: <BAY101-F3978081BDE57937C67314CDC340@phx.gbl>
Received: from 64.4.56.200 by by101fd.bay101.hotmail.msn.com with HTTP;
	Wed, 13 Apr 2005 19:49:21 GMT
X-Originating-IP: [64.4.56.200]
X-Originating-Email: [danieljlaird@hotmail.com]
X-Sender: danieljlaird@hotmail.com
In-Reply-To: <Pine.LNX.4.61L.0504111659410.31547@blysk.ds.pg.gda.pl>
From:	"Daniel Laird" <danieljlaird@hotmail.com>
To:	macro@linux-mips.org
Cc:	libc-alpha@sources.redhat.com, linux-mips@linux-mips.org
Subject: Re: Building GLIBC 2.3.4 on MIPS
Date:	Wed, 13 Apr 2005 19:49:21 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 13 Apr 2005 19:49:21.0768 (UTC) FILETIME=[E332A680:01C54061]
Return-Path: <danieljlaird@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips

I have tried this with any number of patches you want to name

I can do the following combo
glibc-2.3.2
glibc-linuxthreads-2.3.4
kernel 2.6.11.6
binutils-2.15.96

It all works but glibc-2.3.3, 2.3.4, 2.3.5 all fail.  bits/syscalls.h is not 
even generated.  I do not have the problem where it generated wrongly it 
just does not get made on my system and also the wrong flags are passed to 
the HOST compiler which requires patching.

If anyone ever get glibc-2.3.4 and the rest working let me know (please 
check that bits/syscall.h exists)

cheers
Dan
