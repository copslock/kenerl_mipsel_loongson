Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Feb 2015 23:26:37 +0100 (CET)
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:44551 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006732AbbBUW0gDz1Rf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Feb 2015 23:26:36 +0100
Received: from resomta-ch2-10v.sys.comcast.net ([69.252.207.106])
        by resqmta-ch2-02v.sys.comcast.net with comcast
        id vARf1p0052JGN3p01ASUba; Sat, 21 Feb 2015 22:26:28 +0000
Received: from [192.168.1.13] ([69.250.160.75])
        by resomta-ch2-10v.sys.comcast.net with comcast
        id vASS1p00c1duFqV01ASTEX; Sat, 21 Feb 2015 22:26:28 +0000
Message-ID: <54E905FF.8080007@gentoo.org>
Date:   Sat, 21 Feb 2015 17:26:07 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: IP27: BUG() in mm/vmscan.c, isolate_lru_pages
References: <54D6D0D5.8020704@gentoo.org> <alpine.LFD.2.11.1502081003060.22715@eddie.linux-mips.org> <54D80515.3040208@gentoo.org> <54D874BF.3040003@gentoo.org> <54D8C53C.6020708@gentoo.org>
In-Reply-To: <54D8C53C.6020708@gentoo.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1424557588;
        bh=xk4TLBA/bSemdKnYIP3KZ8SAeOKCD2WDW5M2ya/flWs=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=HhqHbRhGeleobbV9u5kn9dkyy9m9TCDW5WJxoGSh4Ayd3PYjKMSA76vfMsTw/sBoa
         +gdqW9d5mAS465jF33Wp84KfxarT1P4/2Mj9D11TFsXXgi3m+hGxtrmJQRQuLf+ko+
         oWxXOSS6Q7XZI6Bb5GYT8fDDCYUAL1ZwiJYCO8nyJHOAX50Fl5gmFIjZ8w39nZ2RU8
         EikPNC2LlbekXs4Ccy1Wf7JFsdg3rp9BUdtXs9odSBVrIoUaxaBA96gBUBHdI5gLOh
         FjovvpAml1NB/7gVjFLv017D3aqucYJ2m4VA52f/+HTspVi71i7FV8cnF3F0346/15
         9KCI7HS3pH9DA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45881
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

On 02/09/2015 09:33, Joshua Kinard wrote:
> On 02/09/2015 03:50, Joshua Kinard wrote:
>
> For the Onyx2, I was able to use bonnie++ to trigger the oops, and it seems
> I've tripped up a BUG() in mm/vmscan.c:
> 
> command line:
> # bonnie++ -d /usr/space/bonnie/ -s 16g -f -b -u root
> 
> [  741.690000] Kernel bug detected[#1]:
> [  741.690000] CPU: 2 PID: 42 Comm: kswapd1 Not tainted 3.19.0-rc7-mipsgit-20150207 #7
> [  741.690000] task: a8000000ffff0008 ti: a8000000ff524000 task.ti: a8000000ff524000
> [  741.690000] $ 0   : 0000000000000000 ffffffff94001ce0 0000000000000000 0000000000000000
> [  741.690000] $ 4   : a800000002957d40 0000000000000000 a8000000ff527b00 a8000000ff527b38
> [  741.690000] $ 8   : 0000000000000000 0000000000000020 000000000000039b 0000000000000003
> [  741.690000] $12   : fffffffffffffff8 0000000000100000 0000000000000000 0000000000000000
> [  741.690000] $16   : 0000000000000000 0000000000000020 0000000000000000 a8000000ff527b00
> [  741.690000] $20   : fffffffffffffff0 a8000000ffc9d800 0000000000000002 a800000002957d60
> [  741.690000] $24   : 0000000000000000 a800000000083140
> [  741.690000] $28   : a8000000ff524000 a8000000ff527a90 a8000000ffc9d820 a8000000000f68d0
> [  741.690000] Hi    : 0000000000000000
> [  741.690000] Lo    : 0000000000000000
> [  741.690000] epc   : a8000000000f69b0 isolate_lru_pages.isra.27+0x170/0x188
> [  741.690000]     Not tainted
> [  741.690000] ra    : a8000000000f68d0 isolate_lru_pages.isra.27+0x90/0x188
> [  741.690000] Status: 94001ce2 KX SX UX KERNEL EXL
> [  741.690000] Cause : 00008024
> [  741.690000] PrId  : 00000f14 (R14000)
> [  741.690000] Process kswapd1 (pid: 42, threadinfo=a8000000ff524000, task=a8000000ffff0008, tls=0000000000000000)
> [  741.690000] Stack : 0000000000000000 a8000000ff527b38 a800000100025000 a8000000ff527d30
>           0000000000000002 a8000000ffc9d800 0000000000000000 0000000000000020
>           0000000000000001 a800000100025600 0000000000000000 a8000000000f8868
>           a8000000ff527b10 0000000000000000 a8000000ff527b00 a8000000ff527b00
>           0000000000000000 0000000000000000 0000000000000000 0000000000000000
>           0000000000000000 a8000000050332f0 0000000000000001 a8000000ffeb1760
>           a8000000ffc9d800 a8000000ff527d30 a8000000ff527c08 0000000000000002
>           0000000000000001 0000000000000020 0000000000000003 0000000000000004
>           0000000000000000 a8000000000f8ff8 a8000000ff527ba0 a8000000ff527ba0
>           a8000000ff527bb0 a8000000ff527bb0 a8000000ff527bc0 a8000000ff527bc0
>           ...
> [  741.690000] Call Trace:
> [  741.690000] [<a8000000000f69b0>] isolate_lru_pages.isra.27+0x170/0x188
> [  741.690000] [<a8000000000f8868>] shrink_inactive_list+0xf0/0x638
> [  741.690000] [<a8000000000f8ff8>] shrink_lruvec+0x248/0x718
> [  744.230000] [<a8000000000f956c>] shrink_zone+0xa4/0x2c8
> [  744.230000] [<a8000000000f9e54>] kswapd+0x6c4/0xab0
> [  744.230000] [<a80000000006f16c>] kthread+0x10c/0x128
> [  744.230000] [<a800000000025b88>] ret_from_kernel_thread+0x14/0x1c
> [  744.230000]
> [  744.230000]
> Code: 0803da48  ffd70000  00000000 <000c000d> 00000000  0000802d  0803da4f  ffa00000  00000000
> [  744.660000] ---[ end trace 2796f87304e1e281 ]---
> [  744.660000] Fatal exception: panic in 5 seconds
> [  744.660000] sched: RT throttling activated
> [  749.670000] Kernel panic - not syncing: Fatal exception
> [  749.730000] ---[ end Kernel panic - not syncing: Fatal exception
> 
> 
[snip]

Got another one today on the Onyx2.  Managed to get >2 days of uptime, though.

[255349.410000] Kernel bug detected[#1]:
[255349.450000] CPU: 2 PID: 42 Comm: kswapd1 Not tainted 3.19.0-mipsgit-20150215 #2
[255349.470000] task: a8000000ffff0008 ti: a8000000ff524000 task.ti: a8000000ff524000
[255349.470000] $ 0   : 0000000000000000 ffffffffffffffdf 0000000000000001 000000000085b218
[255349.470000] $ 4   : a800000004e53000 0000000000000000 0000000000002587 a8000000ff527c98
[255349.470000] $ 8   : 0000000000000000 0000000000000010 fffffffffffffffc a800000005030fa0
[255349.470000] $12   : a8000000ff527fe0 0000000000001c00 0000000000000020 a8000000006d05b8
[255349.470000] $16   : 0000000000000001 0000000000000020 0000000000000000 a8000000ff527c80
[255349.470000] $20   : fffffffffffffff0 a8000000ffc9d800 0000000000000001 a800000004e53020
[255349.470000] $24   : 0000000000000005 0000000000000001
[255349.470000] $28   : a8000000ff524000 a8000000ff527c00 a8000000ffc9d810 a8000000000f6840
[255349.470000] Hi    : 0000000000000000
[255349.470000] Lo    : 0000000000000042
[255349.470000] epc   : a8000000000f6920 isolate_lru_pages.isra.27+0x170/0x188
[255349.470000]     Not tainted
[255349.470000] ra    : a8000000000f6840 isolate_lru_pages.isra.27+0x90/0x188
[255349.470000] Status: 94001ce2        KX SX UX KERNEL EXL
[255349.470000] Cause : 00008024
[255349.470000] PrId  : 00000f14 (R14000)
[255349.470000] Process kswapd1 (pid: 42, threadinfo=a8000000ff524000, task=a8000000ffff0008, tls=0000000000000000)
[255349.470000] Stack : 0000000000000001 a8000000ff527c98 a8000000ff527c80 a8000000ff527d30
          0000000000000000 0000000000000020 ffffffffffffffff 000000000000000c
          a800000100025000 a8000000ffc9d800 a8000000ffc9f800 a8000000000f70dc
          a8000000ff527c60 a8000000ff527c60 a8000000ff527c70 a8000000ff527c70
          a800000004e508e0 a800000004e508e0 a800000005030f80 a800000000869de0
          a8000000ffc9d800 0000000000000001 0000000000000000 a8000000ffc9f800
          a800000100025600 a8000000001466c8 00000000ffff8b73 a8000000ffdc0000
          0000000000000000 a800000100025000 0000000000000000 a800000100025000
          ffffffffffffffff 000000000000000c a800000000940000 a8000000ffc9d800
          a8000000ffc9f800 a8000000000f9b00 0000000000000000 000000d000000000
          ...
[255349.470000] Call Trace:
[255349.470000] [<a8000000000f6920>] isolate_lru_pages.isra.27+0x170/0x188
[255349.470000] [<a8000000000f70dc>] shrink_active_list+0xcc/0x478
[255349.470000] [<a8000000000f9b00>] kswapd+0x400/0xab0
[255349.470000] [<a80000000006f17c>] kthread+0x10c/0x128
[255349.470000] [<a800000000025b88>] ret_from_kernel_thread+0x14/0x1c
[255349.470000]
[255349.470000]
Code: 0803da24  ffd70000  00000000 <000c000d> 00000000  0000802d  0803da2b  ffa00000  00000000
[255352.230000] sched: RT throttling activated
[255352.230000] ---[ end trace 4b44ace0cfc15c3d ]---
[255352.280000] Fatal exception: panic in 5 seconds
[255357.290000] Kernel panic - not syncing: Fatal exception
[255357.350000] ---[ end Kernel panic - not syncing: Fatal exception


Interesting note, though, is the same process (kswapd1), same PID (42 --
HHGTTG?), same CPU (#2), as the oops I forced via bonnie++ almost two weeks
ago.  For a memory-related oops, that seems a bit uncanny.  That BUG() has been
there for the longest of time.  I managed to trace down the initial commit,
21eac81f252f "[PATCH] Swap Migration V5: LRU operations", which says this:

"Swap migration allows the moving of the physical location of pages between
nodes in a numa system while the process is running. This means that the
virtual addresses that the process sees do not change. However, the system
rearranges the physical location of those pages."

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/mm/vmscan.c?id=21eac81f252fe31c3cf64b805a1e8652192f3a3b

NUMA system and signed off by an SGI person back then...  So I turned on 
CONFIG_NUMA, against the advice of the help entry (2-node Onyx2), and the 
problem appears to go away.

Is CONFIG_NUMA a problem for a 2-node IP27 machine?  These machines basically
invented the concept.  I'm not familiar with how enabling that option changes
things to apparently avoid tripping the BUG() up.

--J
