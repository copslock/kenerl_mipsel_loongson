Received:  by oss.sgi.com id <S553719AbQK1Us0>;
	Tue, 28 Nov 2000 12:48:26 -0800
Received: from runyon.cygnus.com ([205.180.230.5]:19612 "EHLO cygnus.com")
	by oss.sgi.com with ESMTP id <S553668AbQK1UsX>;
	Tue, 28 Nov 2000 12:48:23 -0800
Received: from elmo.cygnus.com (elmo.cygnus.com [205.180.230.137])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id MAA27049;
	Tue, 28 Nov 2000 12:48:20 -0800 (PST)
Received: (nickc@localhost) by elmo.cygnus.com (8.9.3/8.6.4) id MAA08884; Tue, 28 Nov 2000 12:48:20 -0800
Date:   Tue, 28 Nov 2000 12:48:20 -0800
Message-Id: <200011282048.MAA08884@elmo.cygnus.com>
X-Authentication-Warning: elmo.cygnus.com: nickc set sender to nickc@redhat.com using -f
From:   Nick Clifton <nickc@redhat.com>
To:     ralf@uni-koblenz.de
CC:     hjl@valinux.com, drepper@cygnus.com, binutils@sources.redhat.com,
        linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: Update readelf to know about the new ELF constants
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi Ralf,
 
: >      EM_MIPS_RS3_LE    10		MIPS RS3000 Little-endian
: 
: I don't know where you got this constant's name from, it's name is
: EM_MIPS_RS4_BE (MIPS R4000 big endian) in all literature and header files
: I've seen.  RS3000 series from MIPS was a workstation series of the former
: Mips Computer Systems, Inc.  not a processor.
: 
: The constant is probably no longer in use - if it ever has been. it's only
: use I've ever seen is in tools that read ELF but never in tools that write
: ELF or in existing ELF files.

Just to add a note that in the sources the entry actually looks like
this:

#define EM_MIPS_RS4_BE 10	/* MIPS R4000 big-endian */ /* Depreciated */
#define EM_MIPS_RS3_LE 10	/* MIPS R3000 little-endian (Oct 4 1999 Draft)*/ /* Depreciated */

Cheers
	Nick
