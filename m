Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2004 04:14:19 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:10688 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8224896AbUBEEOT>;
	Thu, 5 Feb 2004 04:14:19 +0000
Received: from drow by nevyn.them.org with local (Exim 4.30 #1 (Debian))
	id 1AoatB-0001Fq-W2; Wed, 04 Feb 2004 23:13:17 -0500
Date: Wed, 4 Feb 2004 23:13:17 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Nathan Field <ndf@ghs.com>
Cc: linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: GNU gcc ld script problem
Message-ID: <20040205041317.GA4767@nevyn.them.org>
Mail-Followup-To: Nathan Field <ndf@ghs.com>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
References: <Pine.LNX.4.44.0402041636370.7920-100000@zcar.ghs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402041636370.7920-100000@zcar.ghs.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 04, 2004 at 05:24:13PM -0800, Nathan Field wrote:
> 	This seems like a problem specific to the linker, but it's also so
> specific to linux and MIPS that I decided to send it here first. If I was
> wrong to do that let me know and I'll send it to bug-binutils@gnu.org 
> instead.

binutils@sources.redhat.com is probably most appropriate.

> 
> 	Anyway, I think I've found a problem in the ld scripts for MIPS.
> Basically the built in script don't seem to fill in a .plt section. So if
> I do this:
> 
> mips-linux-gcc prog.c
> mips-linux-objdump -h a.out | grep plt
> 
> I get no output, but if I use my modified linker script I get this:
> 
> mips-linux-gcc -T tmp.ld prog.c
> mips-linux-objdump -h a.out | grep plt
>  10 .plt          00000030  0040052c  0040052c  0000052c  2**2
> 
> which I believe is the correct output. The change that I made was to move
> .stub sections into the .plt from the .text section. So this:

Well, of course if you move a section with contents you'll suddenly get
a PLT... the .stub is not a PLT in the normal sense, so why does it
matter whether it's placed in the .plt or .text section in the binary?

The fundamental effect of your change is that .stub sections will no
longer be interleaved with .text based on the object they are attached
to.  Instead they will all be collated before any .text or
.gnu.linkonce.t* sections.  That could be a problem, I don't know for
sure.

> 
>   .plt            : { *(.plt) }
>   .text           :
>   {
>     _ftext = . ;
>     *(.text .stub .text.* .gnu.linkonce.t.*)
>     /* .gnu.warning sections are handled specially by elf32.em.  */
>     *(.gnu.warning)
>     *(.mips16.fn.*) *(.mips16.call.*)
>   } =0
> 
> became this:
> 
>   .plt            : { *(.plt .stub) }
>   .text           :
>   {
>     _ftext = . ;
>     *(.text .text.* .gnu.linkonce.t.*)
>     /* .gnu.warning sections are handled specially by elf32.em.  */
>     *(.gnu.warning)
>     *(.mips16.fn.*) *(.mips16.call.*)
>   } =0
> 
> If anyone needs more information on this issue just let me know. It has
> been in the MIPS tools for a while. I have been working from a recent 
> snapshot:
> 
> 59) ./mips-linux-ld -v
> GNU ld version 040121 20040121
> 
> but the same issue was around way back when (MontaVista preview kit 2.1):
> 
> 61) /opt/hardhat/previewkit/mips/fp_be/bin/mips_fp_be-ld -v
> GNU ld version 2.10.91 (with BFD 2.10.91.0.2)
> 
> Does anyone here have the knowledge to confirm that my changes are correct 
> and commit privileges to the binutils tree?
> 
> 	nathan
> 
> -- 
> Nathan Field (ndf@ghs.com)			          All gone.
> 
> But the trouble with analogies is that analogies are like goldfish:
> sometimes they have nothing to do with the topic at hand.
>         -- Crispin (from a posting to the Bugtraq mailing list)
> 
> 
> 

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
