Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2009 15:24:03 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:55677 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493097AbZH1NX4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Aug 2009 15:23:56 +0200
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id A37604B00BE;
	Fri, 28 Aug 2009 15:23:52 +0200 (CEST)
Received: from bobafett.staff.proxad.net (bobafett.staff.proxad.net [213.228.1.121])
	by smtp2-g21.free.fr (Postfix) with ESMTP id BB63F4B0121;
	Fri, 28 Aug 2009 15:23:49 +0200 (CEST)
Received: from daria.localnet (unknown [172.18.3.120])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id A1B9F18003C;
	Fri, 28 Aug 2009 15:23:49 +0200 (CEST)
From:	Nicolas Schichan <nschichan@freebox.fr>
Organization: Freebox
To:	Florian Fainelli <florian@openwrt.org>
Subject: Re: kexec on mips failed
Date:	Fri, 28 Aug 2009 15:23:47 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.28-14-generic; KDE/4.2.2; x86_64; ; )
Cc:	"wilbur.chan" <wilbur512@gmail.com>, linux-mips@linux-mips.org
References: <e997b7420908160920y14d8ea95v5fb25eba67e7b6db@mail.gmail.com> <200908281109.52499.florian@openwrt.org>
In-Reply-To: <200908281109.52499.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908281523.48697.nschichan@freebox.fr>
Return-Path: <nschichan@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nschichan@freebox.fr
Precedence: bulk
X-list: linux-mips

On Friday 28 August 2009 11:09:51 am Florian Fainelli wrote:
> Hi,

Hi,

> > However, whether I changed kexec_start_address to 0x802b0000 or
> > 0x2b0000 , the  'j  s1'  seemed taking no effect?
> 
> Should not you add a nop right after the j s1 in order to fill in the branch 
> delay slot with an instruction which does nothing ?

This should not be needed since  have no ".set noreorder" in the file,
so the  assembler should add a nop  in the delay slot,  after "jr s1".

I have this  on an objdumped relocate_kernel.o, so  the assembler does
add the nop:

[...]
000000a4 <done>:
  a4:	02200008 	jr	s1
  a8:	00000000 	nop
[...]

Regards,

-- 
Nicolas Schichan
