Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jun 2004 20:28:08 +0100 (BST)
Received: from mms2.broadcom.com ([IPv6:::ffff:63.70.210.59]:44817 "EHLO
	mms2.broadcom.com") by linux-mips.org with ESMTP
	id <S8225937AbUFKT2D>; Fri, 11 Jun 2004 20:28:03 +0100
Received: from 63.70.210.1 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.6.0)); Fri, 11 Jun 2004 12:27:41 -0700
X-Server-Uuid: 011F2A72-58F1-4BCE-832F-B0D661E896E8
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id MAA08073; Fri, 11 Jun 2004 12:27:05 -0700 (PDT)
Received: from ldt-sj3-010.sj.broadcom.com (ldt-sj3-010 [10.21.64.10])
 by mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 i5BJRbov003592; Fri, 11 Jun 2004 12:27:37 -0700 (PDT)
Received: (from cgd@localhost) by ldt-sj3-010.sj.broadcom.com (
 8.11.6/8.9.3) id i5BJRbm24661; Fri, 11 Jun 2004 12:27:37 -0700
X-Authentication-Warning: ldt-sj3-010.sj.broadcom.com: cgd set sender to
 cgd@broadcom.com using -f
To: macro@ds2.pg.gda.pl
cc: "David Daney" <ddaney@avtrex.com>,
	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: [Patch]  / 0 should send SIGFPE not SIGTRAP...
References: <40C9F5A4.2050606@avtrex.com> <40C9F5FE.8030607@avtrex.com>
 <40C9F7F0.50501@avtrex.com>
 <Pine.LNX.4.55.0406112039040.13062@jurand.ds.pg.gda.pl>
 <mailpost.1086981251.16853@news-sj1-1>
From: cgd@broadcom.com
Date: 11 Jun 2004 12:27:37 -0700
In-Reply-To: <mailpost.1086981251.16853@news-sj1-1>
Message-ID: <yov57juduc7q.fsf@ldt-sj3-010.sj.broadcom.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
X-WSS-ID: 6CD4D8261T08499415-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <cgd@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cgd@broadcom.com
Precedence: bulk
X-list: linux-mips

At Fri, 11 Jun 2004 19:14:11 +0000 (UTC), "Maciej W. Rozycki" wrote:
> 2. Gas should definitely use the codes consistently.  And it's a pity the
> ABI got broken -- I think another mnemonic should have been chosen for the
> correct implementation of "break", available to any ISA.

in retrospect, the 'B' variation probably wasn't the greatest idea.

If it were removed (leaving 'c' and 'c','q' variations), I don't know
that any real harm would occur.

It may be very confusing to people who expect that the break code will
translate into the instruction in an obvious way, and obviously it
would mess up use of 20-bit codes, but i don't know how prevalent that
is.

Unfortunately, at this point, Linux should probably accept the
divide-by-zero code in both locations.


(Really, from day one, assemblers probably should have accepted a
20-bit code.  I just checked my copy of the Kane r2000/r3000 book, and
it was 20-bit all the way back then.  If i had to guess, i'd guess
that gas was copying a non-gnu assembler's behaviour.  In any case,
water under the bridge.)



cgd
