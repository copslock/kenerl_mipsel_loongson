Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jan 2003 17:20:10 +0000 (GMT)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:57551 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8226352AbTAMRUJ>;
	Mon, 13 Jan 2003 17:20:09 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h0DHJm67017127;
	Mon, 13 Jan 2003 09:19:49 -0800 (PST)
Received: from uhler-linux.mips.com (uhler-linux [192.168.11.222])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id JAA10305;
	Mon, 13 Jan 2003 09:19:49 -0800 (PST)
Received: from uhler-linux.mips.com (uhler@localhost)
	by uhler-linux.mips.com (8.11.2/8.9.3) with ESMTP id h0DHJkG29389;
	Mon, 13 Jan 2003 09:19:46 -0800
Message-Id: <200301131719.h0DHJkG29389@uhler-linux.mips.com>
X-Authentication-Warning: uhler-linux.mips.com: uhler owned process doing -bs
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
cc: uhler@mips.com
Reply-To: uhler@mips.com
Subject: Re: unaligned load in branch delay slot 
In-reply-to: Your message of "Mon, 13 Jan 2003 17:13:17 +0100."
             <Pine.GSO.4.21.0301131704080.21279-100000@vervain.sonytel.be> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Jan 2003 09:19:45 -0800
From: "Mike Uhler" <uhler@mips.com>
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips


> If I print the parameters at label `sigill' in emulate_load_store_insn(), I
> get:
> 
>     pc 0x80346448 addr 0x83d9f81e ins 0x14600012
> 
> And emulate_load_store_insn() gets confused because 0x14600012 is not a
> load/store. 0x14600012 is the branch instruction before the load, not the load
> after the branch instruction! Note that bit 31 of cause (CAUSEF_BD) is not set.
> Some more investigations showed that the branch is indeed not taken.
> 
> Apparently if an unaligned access happens right after a branch which is not
> taking, epc points to the branch instruction, and CAUSEF_BD is not set
> (technically speaking, this is not a branch delay, since the branch is not
> taken :-). Is this expected behavior? The CPU is a VR4120A core.
> 
> As a workaround, I assume I can just test whether pc points to a branch
> instruction, and increment pc if that's the case?

Prior to the MIPS32/MIPS64 architecture definition, which requires that EPC
point at the branch and the Cause[BD] bit be set on any exception in the
branch delay slot, there were a few CPUs which interpreted the rules in the
manner that you describe.  I don't happen to have a VR4120A manual in front
of me, but the behavior you describe could easily be the case of this differnt
interpretation.

/gmu

-- 

  =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
  Michael Uhler, VP, Systems, Architecture, and Software Products 
  MIPS Technologies, Inc.   Email: uhler@mips.com   Pager: uhler_p@mips.com
  1225 Charleston Road      Voice:  (650)567-5025   FAX:   (650)567-5225
  Mountain View, CA 94043   Mobile: (650)868-6870   Admin: (650)567-5085
