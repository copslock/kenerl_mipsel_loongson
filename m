Received:  by oss.sgi.com id <S553711AbQK1Uh5>;
	Tue, 28 Nov 2000 12:37:57 -0800
Received: from u-77-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.77]:23045
        "EHLO u-77-18.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553668AbQK1Uho>; Tue, 28 Nov 2000 12:37:44 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S868984AbQK1MGT>;
	Tue, 28 Nov 2000 13:06:19 +0100
Date:	Tue, 28 Nov 2000 13:06:19 +0100
From:	Ralf Baechle <ralf@uni-koblenz.de>
To:	"H . J . Lu" <hjl@valinux.com>
Cc:	Nick Clifton <nickc@redhat.com>, drepper@cygnus.com,
        binutils@sources.redhat.com, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: Update readelf to know about the new ELF constants
Message-ID: <20001128130618.A27204@bacchus.dhis.org>
References: <200011271938.LAA19423@elmo.cygnus.com> <20001127122028.A20242@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001127122028.A20242@valinux.com>; from hjl@valinux.com on Mon, Nov 27, 2000 at 12:20:28PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Nov 27, 2000 at 12:20:28PM -0800, H . J . Lu wrote:

>      EM_MIPS_RS3_LE    10		MIPS RS3000 Little-endian

I don't know where you got this constant's name from, it's name is
EM_MIPS_RS4_BE (MIPS R4000 big endian) in all literature and header files
I've seen.  RS3000 series from MIPS was a workstation series of the former
Mips Computer Systems, Inc.  not a processor.

The constant is probably no longer in use - if it ever has been. it's only
use I've ever seen is in tools that read ELF but never in tools that write
ELF or in existing ELF files.

Cc'ed to the Linux/MIPS mailing lists; maybe the oldtimers there can comment.

  Ralf
