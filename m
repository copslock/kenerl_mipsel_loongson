Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2008 21:46:32 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:54231 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20027200AbYFIUqa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jun 2008 21:46:30 +0100
Received: from lagash (88-106-136-149.dynamic.dsl.as9105.com [88.106.136.149])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id A715648916;
	Mon,  9 Jun 2008 22:46:28 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1K5oG3-0000HB-MP; Mon, 09 Jun 2008 21:46:27 +0100
Date:	Mon, 9 Jun 2008 21:46:27 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	"Kevin D. Kissell" <KevinK@paralogos.com>
Cc:	Brian Foster <brian.foster@innova-card.com>,
	linux-mips@linux-mips.org, Andrew Dyer <adyer@righthandtech.com>
Subject: Re: Adding(?) XI support to MIPS-Linux?
Message-ID: <20080609204627.GE11233@networkno.de>
References: <200806091658.10937.brian.foster@innova-card.com> <a537dd660806090837i5ef6c1e2k167aeb97785a136d@mail.gmail.com> <484D856B.5030306@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <484D856B.5030306@paralogos.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:
[snip]
>>  Broadly, what I'm trying to say is I don't want to touch gcc
>>  (and/or binutils) and am unconvinced I have to.  But I'm very
>>  much open to correction here!
>>
>>  The x86 (including amd64) and, AFAIK, SuperH (sh) Linux kernels
>>  now support NX or equivalent; indeed, a test on my 2.6.22(-ish)
>>  amd64 workstation (Kubuntu 7.10) has a non-executable stack.
>>  As such, those could be a model worth studying/following, but
>>  I understand they have support for specially-marked binaries to
>>  have executable stacks (i.e., binutils/gcc mods, which I want to
>>  avoid).
> Well, strictly speaking, you wouldn't actually *need* to modify binutils
> to make specially tagged binaries.  You could borrow an unused bit in
> the ELF header somewhere, have the kernel recognize it, and write your
> own little tool that only turns that bit on/off in an ELF file.

This exists already in ld's -z execstack/noexecstack feature. It is
not used by default because too many things depend on executable
stacks on MIPS.


Thiemo
