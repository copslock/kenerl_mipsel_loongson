Received:  by oss.sgi.com id <S553698AbQK1UrG>;
	Tue, 28 Nov 2000 12:47:06 -0800
Received: from runyon.cygnus.com ([205.180.230.5]:12188 "EHLO cygnus.com")
	by oss.sgi.com with ESMTP id <S553660AbQK1Uqz>;
	Tue, 28 Nov 2000 12:46:55 -0800
Received: from otr.mynet (dialin-sv-02.cygnus.com [205.180.231.52])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id MAA26695;
	Tue, 28 Nov 2000 12:46:16 -0800 (PST)
Received: by otr.mynet (Postfix, from userid 500)
	id F0F8A30BD; Tue, 28 Nov 2000 12:46:08 -0800 (PST)
To:     Ralf Baechle <ralf@uni-koblenz.de>
Cc:     "H . J . Lu" <hjl@valinux.com>, Nick Clifton <nickc@redhat.com>,
        binutils@sources.redhat.com, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: Update readelf to know about the new ELF constants
References: <200011271938.LAA19423@elmo.cygnus.com>
	<20001127122028.A20242@valinux.com>
	<20001128130618.A27204@bacchus.dhis.org>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
From:   Ulrich Drepper <drepper@redhat.com>
Date:   28 Nov 2000 12:46:08 -0800
In-Reply-To: Ralf Baechle's message of "Tue, 28 Nov 2000 13:06:19 +0100"
Message-ID: <m3wvdnsu3z.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle <ralf@uni-koblenz.de> writes:

> >      EM_MIPS_RS3_LE    10		MIPS RS3000 Little-endian
> 
> I don't know where you got this constant's name from, it's name is
> EM_MIPS_RS4_BE (MIPS R4000 big endian) in all literature and header files
> I've seen.  RS3000 series from MIPS was a workstation series of the former
> Mips Computer Systems, Inc.  not a processor.

This is the name in the current ABI specs.  If it's changed then on
request of somebody who registered it.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
