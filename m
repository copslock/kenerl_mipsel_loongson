Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2003 23:01:45 +0000 (GMT)
Received: from p508B7DF8.dip.t-dialin.net ([IPv6:::ffff:80.139.125.248]:27597
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225391AbTJ0XBl>; Mon, 27 Oct 2003 23:01:41 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h9RN1cNK005555;
	Tue, 28 Oct 2003 00:01:38 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h9RN1aSr005554;
	Tue, 28 Oct 2003 00:01:36 +0100
Date: Tue, 28 Oct 2003 00:01:36 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Wolfgang Denk <wd@denx.de>
Cc: linux-mips@linux-mips.org
Subject: Re: question regarding bss section
Message-ID: <20031027230136.GA27764@linux-mips.org>
References: <20031027190829.GB24946@linux-mips.org> <20031027194920.8D301C59E4@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027194920.8D301C59E4@atlas.denx.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 27, 2003 at 08:49:15PM +0100, Wolfgang Denk wrote:

> In most implementations of ANSI C that I am aware of (including GCC /
> glibc), the BSS segment will be used for uninitialized variables with
> "static" storage  class.  Also,  I've  seen  some  compilers  to  put
> variables eplicitly initialized to zero into the BSS segment, too. To
> quote the C FAQ:
> 
>     Uninitialized variables with "static" duration (that is, those
>     declared outside of functions, and those declared with the
>     storage class static), are guaranteed to start out as zero, as if
>     the programmer had typed "= 0". Therefore, such variables

C doesn't know about .bss at all - no single mentioning in the ISO C
standard.  But .bss is a section name used in the ELF binary format which
most Linux systems are using.  The gABI says defines .bss:

.bss	This section holds uninitialized data that contribute to the
	program s memory image. By definition, the system initializes
	the data with zeros when the program begins to run. The section
	occupies no file space, as indicated by the section type,
	SHT_NOBITS.

Certainly the term ``uninitialized'' isn't as precise as desirable but
that's the wording used in the relevant standard.

  Ralf
