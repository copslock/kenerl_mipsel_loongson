Received:  by oss.sgi.com id <S305196AbQDYCEW>;
	Mon, 24 Apr 2000 19:04:22 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:56402 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305191AbQDYCEA>; Mon, 24 Apr 2000 19:04:00 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id TAA03550; Mon, 24 Apr 2000 19:08:08 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id TAA81499; Mon, 24 Apr 2000 19:03:30 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA17611
	for linux-list;
	Mon, 24 Apr 2000 18:47:10 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA66903;
	Mon, 24 Apr 2000 18:47:08 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from localhost (localhost [127.0.0.1])
	by calypso.engr.sgi.com (Postfix) with ESMTP
	id B34CAA7904; Mon, 24 Apr 2000 18:46:33 -0700 (PDT)
Date:   Mon, 24 Apr 2000 18:46:33 -0700 (PDT)
From:   Ulf Carlsson <ulfc@calypso.engr.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: failed to compile glibc 2.1.2 - BFD_RELOC_16_PCREL_S2 problem
In-Reply-To: <3904E464.4B779CB1@mvista.com>
Message-ID: <Pine.LNX.4.21.0004241837420.1735-100000@calypso.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, 24 Apr 2000, Jun Sun wrote:

> 
> I am having this problem while I am trying to build glibc v2.1.2.  Does
> anybody know about this problem?  Do I need some MIPS patch for building
> this?  Thanks.

You can't use glibc 2.1.2 on MIPS, try glibc 2.2 from the official cvs tree
instead.  Andreas Jaeger posted an announcement for glibc 2.2 on MIPS to this
list last Friday with build instructions.

> BFD_RELOC_16_PCREL_S2 relocation in this object file format
> make[2]: *** [/root/rpm/BUILD/glibc-obj/setjmp/setjmp.o] Error 1

This is because it's not compiling as PIC.

Ulf
