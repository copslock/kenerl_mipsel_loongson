Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Feb 2003 08:33:30 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:16515
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224939AbTBYId3>; Tue, 25 Feb 2003 08:33:29 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 18naWf-001Tfh-00; Tue, 25 Feb 2003 09:33:21 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 18naWf-0000ub-00; Tue, 25 Feb 2003 09:33:21 +0100
Date: Tue, 25 Feb 2003 09:33:21 +0100
To: jeff <jeff_lee@coventive.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Kernel 2.4.20
Message-ID: <20030225083321.GD25303@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030225080327.GC25303@rembrandt.csv.ica.uni-stuttgart.de> <LPECIADMAHLPOFOIEEFNEEMACNAA.jeff_lee@coventive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LPECIADMAHLPOFOIEEFNEEMACNAA.jeff_lee@coventive.com>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

jeff wrote:
> Dear Thiemo,
>     Thanks for your quickly response.
> I try to modify the /arch/mips/ld.script.in or /arch/mips/kernel/head.S

This won't help. The entry address is where the linker happens to
place the entry function. It may vary even for slight differences
in Kernel compilation.

> but still can't work (entry is changed but kernel can't work).

What does "can't work" mean? What happens exactly?

What sort of bootloader are you using? Normally it is able to
handle ELF properly, which makes this thing work automatically.

> Do I make any mistake?

Sounds so.


Thiemo
