Received:  by oss.sgi.com id <S305263AbQEAIxe>;
	Mon, 1 May 2000 01:53:34 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:35892 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQEAIxF>;
	Mon, 1 May 2000 01:53:05 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA21573; Mon, 1 May 2000 01:48:18 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id BAA56591; Mon, 1 May 2000 01:52:34 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA90838
	for linux-list;
	Mon, 1 May 2000 01:41:34 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA95175
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 1 May 2000 01:41:33 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA08789
	for <linux@cthulhu.engr.sgi.com>; Mon, 1 May 2000 01:41:32 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA08728;
	Mon, 1 May 2000 01:41:34 -0700 (PDT)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA27099;
	Mon, 1 May 2000 01:41:29 -0700 (PDT)
Message-ID: <001a01bfb349$59f95440$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     "Florian Lohoff" <flo@rfc822.org>, <linux@cthulhu.engr.sgi.com>
Subject: Re: VC exceptions
Date:   Mon, 1 May 2000 10:43:34 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>> >Apropriate placement of mappings in the address space isn't always possible.
>> >MAP_FIXED is one example.  Aliases in the page cache are harder to handle.
>> >If one of the page cache mappings is writable then readers may even observe
>> >stale data or in worst  case stale data being written to disk.
>>
>> mmap() is allowed to fail.  I would think that,  if someone tries to force an
>> unsafe mapping, one should give them EINVAL if one doesn't want to deal
>> with the special case otherwise, or create a copy-on-write clone in a safe
>> physical page if one wants to be extra-specially nice...
>
>I'm only worried because I don't know how much software such a change
>would break.

But it's already broken - it just doesn't know it.  The difference is that
now the software will fail in a systematic and recoverable way, whereas
before it would simply be randomly corrupt.  I agree that it's regrettable,
but the job of the OS (IMHO) is to provide a known-reliable access
to the underlying hardware, and to refuse accesses that compromise
the integrity of the system and the application.

>IRIX uses something they call page ownership switching.  Essentially they
>ensure that only mappings of one colour are accessible at any time.
>Accessing a page's mapping of a different colour will make the mm flush
>caches, make the old colour inaccessible and the new colour accessible
>in the page tables.  That requires a reverse mapping of physical to virtual
>addresses, something that Linus so far has always refused to accept.

Just what has he refused to accept, and what was his rationale?

            Kevin K.
