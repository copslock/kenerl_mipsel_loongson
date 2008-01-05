Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jan 2008 17:05:56 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:46722 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20025260AbYAERFr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 5 Jan 2008 17:05:47 +0000
Received: from lagash (88-106-143-223.dynamic.dsl.as9105.com [88.106.143.223])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id D6DC548905;
	Sat,  5 Jan 2008 18:05:41 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1JBCSw-0002Cj-8Q; Sat, 05 Jan 2008 17:05:46 +0000
Date:	Sat, 5 Jan 2008 17:05:46 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	KokHow.Teh@infineon.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Arch/mips/kernel/vpe.c
Message-ID: <20080105170546.GG22809@networkno.de>
References: <31E09F73562D7A4D82119D7F6C1729860320EADA@sinse303.ap.infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31E09F73562D7A4D82119D7F6C1729860320EADA@sinse303.ap.infineon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

KokHow.Teh@infineon.com wrote:
> Hi;
> 	I am working on MIPS34KC with APRP kernel and I use uclibc
> gccc-3.4.4 to build applications to run on VPE1. The present
> implementation of VPE loader is limited to a few relocation types which
> are used when mips_sde compiler is used. However, the relocatable binary
> churn out from my uclibc-gcc-3.4.4 has more other relocation types than
> the ones defined in arch/mips/kernel/vpe.c, especially those with GOT
> relocation types. I have taken a look at the System V ABI Third Edition
> but if anybody has any code reference and pointers to how each
> relocation types should be implemented in C-code, it would be very
> helpful.

The most likely place to look at would be the binutils source code. That
said, you can probably get away without enhancing the VPE loader by using
  a) fully linked (non-relocatable) executables, or
  b) non-PIC code, like SDE does

Regardless of your choice, you will have to make sure the uclibc toolchain
doesn't use any libraries which need Linux facilities, as the bare-metal
environment on VPE1 doesn't provide them. For that reason I believe you
are better of with SDE or a similiar mips*-elf configured toolchain.


Thiemo
