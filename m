Received:  by oss.sgi.com id <S305259AbQD3V16>;
	Sun, 30 Apr 2000 14:27:58 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:538 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305163AbQD3V1i>; Sun, 30 Apr 2000 14:27:38 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA05261; Sun, 30 Apr 2000 14:31:51 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA45306
	for linux-list;
	Sun, 30 Apr 2000 14:17:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA51020
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 30 Apr 2000 14:17:44 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA09770
	for <linux@cthulhu.engr.sgi.com>; Sun, 30 Apr 2000 14:17:44 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA28833;
	Sun, 30 Apr 2000 14:17:44 -0700 (PDT)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA14816;
	Sun, 30 Apr 2000 14:17:41 -0700 (PDT)
Message-ID: <002801bfb2e9$d0bec2f0$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     "Florian Lohoff" <flo@rfc822.org>, <linux@cthulhu.engr.sgi.com>
Subject: Re: VC exceptions
Date:   Sun, 30 Apr 2000 23:19:41 +0200
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

On Saturday, April 29, 2000 at 11:57PM, Ralf Baechle wrote:

>On Thu, Apr 27, 2000 at 08:12:14PM +0200, Kevin D. Kissell wrote:
>
>> It's a thing that can happen whenever caches are
>> virtually indexed (for speed) but physically tagged
>> (for correctness), and caches get large enough for
>> the algorithm to be wrong once in a while.  They can
>> be avoided with a little thought and overhead in the
>> assignment of physical pages to virtual addresses.
>> Gimme a day or so to look at the code, and I'll propose
>> a fix for Linux...

Sadly, I've been handed a more urgent (and more to the
point, paid) assignment, and won't be able to do anything
about this a quickly as I would like.  I note that you've posted
a patch, Ralf, so one can hope that it will deal with Florian's
problem.

>Apropriate placement of mappings in the address space isn't always possible.
>MAP_FIXED is one example.  Aliases in the page cache are harder to handle. 
>If one of the page cache mappings is writable then readers may even observe 
>stale data or in worst  case stale data being written to disk.

mmap() is allowed to fail.  I would think that,  if someone tries to force an 
unsafe mapping, one should give them EINVAL if one doesn't want to deal 
with the special case otherwise, or create a copy-on-write clone in a safe
physical page if one wants to be extra-specially nice...

            Kevin K.
