Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2003 19:50:05 +0000 (GMT)
Received: from mailout08.sul.t-online.com ([IPv6:::ffff:194.25.134.20]:22665
	"EHLO mailout08.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225344AbTJ0Ttd>; Mon, 27 Oct 2003 19:49:33 +0000
Received: from fwd06.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1AEDMp-0000mB-0L; Mon, 27 Oct 2003 20:49:31 +0100
Received: from denx.de (Gh9zDeZAreZ7n2a78InzEhClROio2DUbbhHVCTdVMXQ65HMzsyALkM@[217.235.255.254]) by fmrl06.sul.t-online.com
	with esmtp id 1AEDMh-0vYAca0; Mon, 27 Oct 2003 20:49:23 +0100
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 5D71B42E25; Mon, 27 Oct 2003 20:49:21 +0100 (MET)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 8D301C59E4; Mon, 27 Oct 2003 20:49:20 +0100 (MET)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 89791C545E; Mon, 27 Oct 2003 20:49:20 +0100 (MET)
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: question regarding bss section 
X-Mailer: exmh version 1.6.4 10/10/1995
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Mon, 27 Oct 2003 20:08:29 +0100."
             <20031027190829.GB24946@linux-mips.org> 
Date: Mon, 27 Oct 2003 20:49:15 +0100
Message-Id: <20031027194920.8D301C59E4@atlas.denx.de>
X-Seen: false
X-ID: Gh9zDeZAreZ7n2a78InzEhClROio2DUbbhHVCTdVMXQ65HMzsyALkM@t-dialin.net
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <20031027190829.GB24946@linux-mips.org> you wrote:
> 
> > > .bss is uninitialized.  Initialized data can't be in .bss.
> > 
> > No. BSS is initialized as zero.
> 
> RTFM.  It's unitialized because not contained in the binaries.

When an application runs it will see the BSS space as initialized  as
zero.

In most implementations of ANSI C that I am aware of (including GCC /
glibc), the BSS segment will be used for uninitialized variables with
"static" storage  class.  Also,  I've  seen  some  compilers  to  put
variables eplicitly initialized to zero into the BSS segment, too. To
quote the C FAQ:

    Uninitialized variables with "static" duration (that is, those
    declared outside of functions, and those declared with the
    storage class static), are guaranteed to start out as zero, as if
    the programmer had typed "= 0". Therefore, such variables


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Quantum particles: The dreams that stuff is made of.
