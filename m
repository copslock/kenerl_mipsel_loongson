Received:  by oss.sgi.com id <S305163AbQBRVoE>;
	Fri, 18 Feb 2000 13:44:04 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:5642 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305167AbQBRVnr>;
	Fri, 18 Feb 2000 13:43:47 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA18566; Fri, 18 Feb 2000 13:39:16 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA53601
	for linux-list;
	Fri, 18 Feb 2000 13:29:24 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA16719
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 18 Feb 2000 13:29:22 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA09379
	for <linux@cthulhu.engr.sgi.com>; Fri, 18 Feb 2000 13:29:25 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-2.uni-koblenz.de (cacc-2.uni-koblenz.de [141.26.131.2])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id WAA01861;
	Fri, 18 Feb 2000 22:29:17 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407898AbQBRLT5>;
	Fri, 18 Feb 2000 12:19:57 +0100
Date:   Fri, 18 Feb 2000 12:19:57 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Hiroyuki Machida <machida@sm.sony.co.jp>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Question about copy_from_user()
Message-ID: <20000218121957.G5234@uni-koblenz.de>
References: <20000216183429L.machida@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20000216183429L.machida@sm.sony.co.jp>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Feb 16, 2000 at 06:34:29PM +0900, Hiroyuki Machida wrote:

> I think I found a redundant code in copy_from_user() and
> __copy_from_user() at current CVS asm-mips/uaccess.h.
> 
> I think '*'-marked part in the definiton is obsolete and
> redundant. It had to used in the exception fixup routine as
> commented at arch/mips/lib/memcpy.S. (Of course the comment is also
> obsolete, I think.)

As you say $at is being used for the exception handling, so it obviously
isn't redundant as you say.  Or do I missunderstand what you were trying
to express?

You however made me stump over another bug, the definition of __MODULE_JAL
in <asm/uaccess.h> is wrong when compiling a module.  In that case the
generated code will clobber $at which actually should stay unchanged
for the exception handling.

  Ralf
