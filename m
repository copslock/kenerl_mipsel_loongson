Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Aug 2003 15:36:58 +0100 (BST)
Received: from frank.harvard.edu ([IPv6:::ffff:140.247.122.99]:12169 "EHLO
	frank.harvard.edu") by linux-mips.org with ESMTP
	id <S8224821AbTHJOgy>; Sun, 10 Aug 2003 15:36:54 +0100
Received: from frank.harvard.edu (frank.harvard.edu [140.247.122.99])
	by frank.harvard.edu (8.11.6/8.11.6) with ESMTP id h7AEapN16709;
	Sun, 10 Aug 2003 10:36:51 -0400
Date: Sun, 10 Aug 2003 10:36:51 -0400 (EDT)
From: Chip Coldwell <coldwell@frank.harvard.edu>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@linux-mips.org
Subject: Re: load/store address overflow on binutils 2.14
In-Reply-To: <20030810120844.GB22977@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.LNX.4.44.0308101032240.16702-100000@frank.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <coldwell@frank.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: coldwell@frank.harvard.edu
Precedence: bulk
X-list: linux-mips

On Sun, 10 Aug 2003, Thiemo Seufer wrote:

> Atsushi Nemoto wrote:
> > >>>>> On Fri, 8 Aug 2003 05:07:05 +0200, Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> said:
> > >> The b.S is just one line "lw $2, 0x80000000".
> > Thiemo> Using 0xffffffff80000000 is a really ugly workaround for it.
> > Thiemo> Seems like the constant isn't properly sign-extended inernally
> > Thiemo> by the assembler.
> > 
> > Yes the workaround works.  But I modified binutils (just remove the
> > checking code) instead of changing many constant definitions in my
> > programs.  For now it is enough for me.  Thank you.
> 
> It is probably not a real binutils bug, but related to gcc mishandling
> 'unsigned long long'. The simple testcase
> 
> int main(void)
> {
>         unsigned long long a = 0;
> 
>         printf("%016x\n", ~a);
> 
>         return 0;
> }
> 
> outputs
> 
> 00000000ffffffff
> 
> on my i386-linux system.

Strangely, this is actually "correct" behavior.  Arguments on
variable-length argument lists are implicitly "promoted" to unsigned
int at the widest.  See K&R 2nd ed. A6.1 and A7.3.2.  Things may have
changed with C99, but this would have been expected behavior for ANSI
C, and strange results were to be had when "long int" was wider than
"int" and was passed on a variable-length argument list.

Chip

-- 
Charles  M. "Chip" Coldwell      __o
"Turn on, log in, tune out"      \<
                              (@)/(@) 
-------------------------------------
