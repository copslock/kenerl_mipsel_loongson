Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Sep 2002 04:13:12 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:26633 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1121744AbSI2CNM>;
	Sun, 29 Sep 2002 04:13:12 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17vUVl-0002Rn-00; Sat, 28 Sep 2002 22:12:49 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17vTa9-0001kt-00; Sat, 28 Sep 2002 22:13:17 -0400
Date: Sat, 28 Sep 2002 22:13:17 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "H. J. Lu" <hjl@lucon.org>
Cc: binutils@sources.redhat.com, linux-mips@linux-mips.org
Subject: Re: The current binutils in CVS is broken on Linux/mips
Message-ID: <20020929021316.GA6731@nevyn.them.org>
Mail-Followup-To: "H. J. Lu" <hjl@lucon.org>, binutils@sources.redhat.com,
	linux-mips@linux-mips.org
References: <20020928161704.A9102@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020928161704.A9102@lucon.org>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Sat, Sep 28, 2002 at 04:17:04PM -0700, H. J. Lu wrote:
> I recompiled my mipsel kernel with binutils in CVS as of 20020928. The
>  resulting kernel doesn't work. I got
> 
> Unhandled kernel unaligned access in unaligned.c::emulate_load_store_insn,
> line:
> $0 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000    
> $8 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000    
> $16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000    
> $24: 00000000 00000000                   00000000 00000000 00000000 00000000    
> Hi : 00000000                                                                   
> Lo : 00000000                                                                   
> epc  : 00000000    Not tainted                                                  
> Status: 00000000                                                                
> Cause : 00000000                                                                
> Process sleep (pid: 16, stackpage=87e8c000)                                     

Could you try with the 2.13.1-branch - I believe it should be fine but
I haven't tested MIPS in a few merges.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
