Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2008 15:42:09 +0100 (BST)
Received: from mms1.broadcom.com ([216.31.210.17]:30214 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20028965AbYHMOmC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 Aug 2008 15:42:02 +0100
Received: from [10.11.16.99] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Wed, 13 Aug 2008 07:41:45 -0700
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 7B7E72B1; Wed, 13 Aug 2008 07:41:45 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 64E212B0; Wed, 13 Aug
 2008 07:41:45 -0700 (PDT)
Received: from mail-irva-13.broadcom.com (mail-irva-13.broadcom.com
 [10.11.16.103]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id HBP38896; Wed, 13 Aug 2008 07:41:36 -0700 (PDT)
Received: from [10.28.6.13] (lab-mhtb-013.ne.broadcom.com [10.28.6.13])
 by mail-irva-13.broadcom.com (Postfix) with ESMTP id 616A374CFE; Wed,
 13 Aug 2008 07:41:35 -0700 (PDT)
Subject: Re: Debugging the MIPS processor using GDB
From:	"Jon Fraser" <jfraser@broadcom.com>
Reply-to: jfraser@broadcom.com
To:	"Brian Foster" <brian.foster@innova-card.com>
cc:	linux-mips@linux-mips.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	"Martin Gebert" <martin.gebert@alpha-bit.de>,
	TriKri <kristoferkrus@hotmail.com>
In-Reply-To: <200808130905.53671.brian.foster@innova-card.com>
References: <18944199.post@talk.nabble.com>
 <200808121637.42148.brian.foster@innova-card.com>
 <Pine.LNX.4.55.0808121720370.24222@cliff.in.clinika.pl>
 <200808130905.53671.brian.foster@innova-card.com>
Organization: Broadcom
Date:	Wed, 13 Aug 2008 10:41:34 -0400
Message-ID: <1218638494.21039.6.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-3.fc8)
X-WSS-ID: 64BC2D234E0115004117-01-01
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <jfraser@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jfraser@broadcom.com
Precedence: bulk
X-list: linux-mips



FYI,

      I use the FS2 probe with sde-gdb on a nearly daily basis.
Are you compiling your kernel with -g -O1 ?

You can also try 'hbreak' instead of 'break' in sde-gdb.

Jon


On Wed, 2008-08-13 at 09:05 +0200, Brian Foster wrote:
> On Tuesday 12 August 2008 18:27:42 Maciej W. Rozycki wrote:
> > On Tue, 12 Aug 2008, Brian Foster wrote:
> > >   I'm using the commercial FS² (First Silicon Systems, now owned
> > >  by MIPS) EJTAG probe.  [ ... ]  There is no ‘gdbserver’ in this
> > >  setup per se, albeit I suppose the protocol between ‘gdb’ and
> > >  the FS² software [ ... ] might be similar/identical[?]
> > 
> >  Not really -- it uses a C API called MDI -- the spec is available from
> > MIPS Technologies.  I am happy to read somebody finds it useful. :) 
> > Debugging the Linux kernel with GDB and this piece of hardware is
> > certainly a lot of fun.
> 
> Maciej,
> 
>   Thanks for the clarification.  I didn't know if MDI
>  was related to the remote-‘gdbserver’ stuff or not.
> 
>   Re the FS²:  When it works, my (somewhat limited)
>  experience to-date is it works Ok.  And the use of
>  TCL on the Host workstation side allows some neat
>  tricks.  However, at least one thing doesn't work
>  reliably for me, albeit I've never investigated:
>  Breakpoints in the Linux kernel.  They do detonate.
>  Then, sometimes, I can ‘c’(ontinue) or ‘s’(tep) Ok.
>  But other times, when I ‘c’ or ‘s’, the breakpoint
>  detonates again and I'm stuck.  I cannot proceed.
>  (The same breakpoint might even work once or twice
>  and then fail.)   Any ideas?   AFAICR, this can also
>  happen if I try to use the ‘sysnav’ console instead
>  of ‘gdb’.
> 
>   I understand my predecessor in my job I gave up on
>  the FS² (very possibly because of this breakpoint
>  issue?) and used a competing (E?)JTAG probe.
> 
>   Weirdly, I've only seen this effect with the Linux
>  kernel — other kernel-mode software (e.g., the trivial
>  custom bootloader) — doesn't seem to suffer from these
>  “flakey FS² breakpoints”?
> 
> cheers!
> 	-blf-
> 
