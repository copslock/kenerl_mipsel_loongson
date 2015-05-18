Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2015 14:01:19 +0200 (CEST)
Received: from resqmta-po-04v.sys.comcast.net ([96.114.154.163]:51870 "EHLO
        resqmta-po-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012399AbbERMBRdA0K8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 May 2015 14:01:17 +0200
Received: from resomta-po-11v.sys.comcast.net ([96.114.154.235])
        by resqmta-po-04v.sys.comcast.net with comcast
        id VQ171q00D54zqzk01Q1D0w; Mon, 18 May 2015 12:01:13 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-po-11v.sys.comcast.net with comcast
        id VQ1B1q00M42s2jH01Q1CvF; Mon, 18 May 2015 12:01:13 +0000
Message-ID: <5559D483.905@gentoo.org>
Date:   Mon, 18 May 2015 08:01:07 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: IP30: SMP, Almost there?
References: <55597B21.4010704@gentoo.org>
In-Reply-To: <55597B21.4010704@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1431950473;
        bh=qWUjR++pdQNI5xUh/Z98SjtIGDwNYhaM4yzcei5EDY0=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=RwHmU3MssnRZVC5irjX2G8bD4O79XA4TdZOPOz1iTyrrTvdDpoveZiImRBBl5iyjK
         lsfJXDLuytYhS8fYPuUuZ3pFUUo9b/FuB1IXwP+xAw2ftD9iV5xCO4dOf65biHqdtI
         d9H4MrFs64OA9UlxSc3g+a/RYSJoAj+cr9zrvAa8aFfh5QAmnUNk6V3vYPUnTI0A6V
         AAgXb+lBBaLURPN13d0DuN89EdkSx6o0FB9SafiMdwTTVQJ/HrUkDZWEhCbECIiBdp
         a2+NrbAHDoPxui3bl8MOzLZodO+SuVd9w6qQSIhKGUIRDPSEGQVmrkCvMVxr6hnNOi
         01mV+/58Ucn1A==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 05/18/2015 01:39, Joshua Kinard wrote:
> So I've gotten the second CPU in Octane to "tick" again...somehow.  I am
> certain someone's cat went missing in the process...
> 
> Anyways, it's booting into an initramfs and dying almost immediately with
> errors from do_page_fault:
> 
> [   15.631359] do_page_fault(): sending SIGSEGV to init for invalid write
> access to 0000000000000338
> [   15.631395] epc = 0000000000478474 in busybox[400000+110000]
> [   15.631408] ra  = 000000000047843c in busybox[400000+110000]
> 
> Segmentation fau[   17.399304] Instruction bus error, epc == 000000000041c000,
> ra == 000000000041c5c8
> lt
> [   17.442702] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000a
> [   17.442702]
> [   17.470272] ---[ end Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000a
> 
> 
> So after some digging around, I found this thread from way back in 2006 that
> seems almost identical:
> http://www.linux-mips.org/archives/linux-mips/2006-09/msg00169.html
> 
> However, none of the stuff regarding flush_icache_range seems to be around nor
> relevant anymore.  But I did comment out one of the #if 0's in
> arch/mips/mm/fault.c and got this output:
> [   16.755572] Cpu0[init:1:0000000000520378:1:a800000020360bfc]
> [   16.772869] Cpu0[init:1:000000007ff45fb0:1:a80000002001cec4]
> [   16.790102] Cpu0[init:1:0000000000400160:0:0000000000400160]
> [   16.807563] Cpu0[init:1:000000000041c000:0:000000000041c000]
> [   16.825027] Cpu0[init:1:0000000000521ff8:1:0000000000402380]
> [   16.842141] Cpu0[init:1:0000000000522010:1:00000000004023d8]
> [   16.859289] Cpu0[init:1:0000000000422a6c:0:0000000000422a6c]
> [   16.876768] Cpu0[init:1:000000000051fffc:0:0000000000400320]
> [   16.893915] Cpu0[init:1:00000000004ddaf4:0:00000000004ddaf4]
> [   16.911389] Cpu0[init:1:000000000094d008:1:000000000040519c]
> [   16.928527] Cpu0[init:1:00000000004e7d9b:0:0000000000404aec]
> [   16.946000] Cpu0[init:1:0000000000503cde:0:0000000000428994]
> [   16.963441] Cpu0[init:1:000000000047f2d4:0:000000000047f2d4]
> [   16.980945] Cpu0[init:1:00000000004f76e8:0:000000000047f380]
> [   16.998410] Cpu0[init:1:000000000094eff8:1:00000000004051a0]
> [   17.015596] Cpu0[init:1:000000007ff449c8:0:a80000002001d668]
> [   17.032716] Cpu0[init:1:000000007ff449d0:1:a800000020360a48]
> [   17.050655] Cpu0[init:1:000000000094fff8:1:00000000004051a0]
> [   17.068127] Cpu0[init:1:0000000000950ff8:1:00000000004051a0]
> [   17.085615] Cpu0[init:1:0000000000952ff8:1:00000000004051a0]
> [   17.102741] Cpu0[init:1:0000000000951000:1:0000000000472fc8]
> [   17.121391] Cpu0[init:1:0000000000953ff8:1:00000000004051a0]
> [   17.138756] Cpu0[init:1:0000000000954ff8:1:00000000004051a0]
> [   17.156542] Cpu0[init:1:000000007ff44de8:1:0000000000403398]
> [   15.613954] Cpu1[init:75:000000000040c1a0:0:000000000040c1a0]
> [   15.614065] Cpu1[init:75:000000007ff44de8:1:0000000000403398]
> [   15.631203] Cpu1[init:75:0000000000413b58:0:0000000000413b58]
> [   15.631276] Cpu1[init:75:000000000047843c:0:000000000047843c]
> [   15.631336] Cpu1[init:75:0000000000000338:1:0000000000478474]
> 
> The invalid address (I believe what is effectively a NULL) of
> 0x0000000000000338 is pretty consistent with the netboot.  Sometimes I get a
> panic in a mutex*slowpath function (I forget which one).  But it's way more
> predictable with this netboot than with the disks inserted.

Apparently, setting cca=5 on the kernel command line improves things.  The
netboot can load busybox ash and move around.  But booting the real userland is
still very problematic (XFS filesystem pretty much blows up on mounting root).

What is the relationship between the cache-coherency algorithm and SMP?  IP30
hardware is supposed to be cache-coherent.  A value of '5' sets the processors
to "cacheable coherent exclusive on write" (per the R10K manual).  But I am not
sure why things are still flakey.

--J
