Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Dec 2014 00:21:21 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:38278 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009720AbaLWXVT3IekC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Dec 2014 00:21:19 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 727F856F535;
        Wed, 24 Dec 2014 01:21:18 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id 7NrH5HhgFXZ7; Wed, 24 Dec 2014 01:21:11 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id CFB5F5BC004;
        Wed, 24 Dec 2014 01:21:11 +0200 (EET)
Date:   Wed, 24 Dec 2014 01:21:11 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] MIPS: support for hybrid FPRs
Message-ID: <20141223232111.GA593@fuloong-minipc.musicnaut.iki.fi>
References: <1410420623-11691-1-git-send-email-paul.burton@imgtec.com>
 <1410420623-11691-8-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1410420623-11691-8-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Thu, Sep 11, 2014 at 08:30:20AM +0100, Paul Burton wrote:
> Hybrid FPRs is a scheme where scalar FP registers are 64b wide, but
> accesses to odd indexed single registers use bits 63:32 of the
> preceeding even indexed 64b register. In this mode all FP code
> except that built for the plain FP64 ABI can execute correctly. Most
> notably a combination of FP64A & FP32 code can execute correctly,
> allowing for existing FP32 binaries to be linked with new FP64A binaries
> that can make use of 64 bit FP & MSA.

This commit (4227a2d4efc9c84f35826dc4d1e6dc183f6c1c05, bisected)
in 3.19-rc1 breaks my Loongson-2F system. I get endless amount
of "Reserved instruction in kernel code" exceptions when booting.
See some examples below. Nothing crashes, and there is some forward
progress, but obviously it's completely unusable.

Any ideas?

[    2.872000] Reserved instruction in kernel code[#1]:
[    2.872000] CPU: 0 PID: 231 Comm: hotplug Not tainted 3.18.0-lemote-los_7f08-09423-g988adfd #1
[    2.872000] task: 980000009f1c7480 ti: 980000009a2e8000 task.ti: 980000009a2e8000
[    2.872000] $ 0   : 0000000000000000 0000000077d32c14 0000000000000000 0000000000000001
[    2.872000] $ 4   : 0000000000000000 000000001000802c 980000009a2ebeb0 0000000000000002
[    2.872000] $ 8   : 0000000000000010 000000007efefeff 0000000024242424 ffffffff81010100
[    2.872000] $12   : 00000000100044e1 000000001000001f 0000000000000000 0000000000000000
[    2.872000] $16   : 0000000000400164 000000007fdb3ee0 0000000077d62cf8 0000000000000000
[    2.872000] $20   : 0000000000000000 0000000077d61ed0 0000000077d61ed0 00000000004022d8
[    2.872000] $24   : 0000000000000005 0000000077d4ba80                                  
[    2.872000] $28   : 980000009a2e8000 980000009a2ebe70 000000007fdb3ee8 ffffffff802077e0
[    2.872000] Hi    : 000000000000002c
[    2.872000] Lo    : 000000000000000b
[    2.872000] epc   : ffffffff8020e8d4 do_cpu+0x304/0x4f0
[    2.872000]     Not tainted
[    2.872000] ra    : ffffffff802077e0 ret_from_exception+0x0/0x1c
[    2.872000] Status: 100044e3	KX SX UX KERNEL EXL IE 
[    2.872000] Cause : 10008028
[    2.872000] PrId  : 00006303 (ICT Loongson-2)
[    2.872000] Modules linked in:
[    2.872000] Process hotplug (pid: 231, threadinfo=980000009a2e8000, task=980000009f1c7480, tls=0000000000000000)
[    2.872000] Stack : 0000000077d50000 0000000077d62c10 ffffffffffffc000 0000000077d61ed0
	  0000000077d622d8 0000000000400164 000000007fdb3ee0 ffffffff802077e0
	  0000000000000000 0000000077d32c14 000000007fdb3da8 0000000077d62bf0
	  000000007fdb3db8 0000000000000000 000000007fdb3d90 000000007fdb3ee8
	  ffffffffbba0ffce 000000007efefeff 0000000024242424 ffffffff81010100
	  0000000000000000 0000000000000fc1 0000000000000000 0000000000000000
	  0000000000400164 000000007fdb3ee0 0000000077d62cf8 0000000000000000
	  0000000000000000 0000000077d61ed0 0000000077d61ed0 00000000004022d8
	  0000000000000005 0000000077d4ba80 000000006474e552 0000000000000000
	  0000000077d6a000 000000007fdb3d90 000000007fdb3ee8 0000000077d41038
	  ...
[    2.872000] Call Trace:
[    2.872000] [<ffffffff8020e8d4>] do_cpu+0x304/0x4f0
[    2.872000] [<ffffffff802077e0>] ret_from_exception+0x0/0x1c
[    2.872000] 
[    2.872000] 
Code: 30420001  2c420001  0040202d <40038005> 2405feff  00651824  40838005  3c032000  3c052400 
[    2.876000] ---[ end trace 71c7b14ce7da936f ]---
[    2.880000] Reserved instruction in kernel code[#2]:
[    2.880000] CPU: 0 PID: 232 Comm: hotplug Tainted: G      D        3.18.0-lemote-los_7f08-09423-g988adfd #1
[    2.880000] task: 980000009f1c5ea8 ti: 980000009a2e4000 task.ti: 980000009a2e4000
[    2.880000] $ 0   : 0000000000000000 0000000077832c14 0000000000000000 0000000000000001
[    2.880000] $ 4   : 0000000000000000 000000001000802c 980000009a2e7eb0 0000000000000002
[    2.880000] $ 8   : 0000000000000010 000000007efefeff 0000000024242424 ffffffff81010100
[    2.880000] $12   : 00000000100044e1 000000001000001f 0000000000000000 0000000000000000
[    2.880000] $16   : 0000000000400164 000000007fd876e0 0000000077862cf8 0000000000000000
[    2.880000] $20   : 0000000000000000 0000000077861ed0 0000000077861ed0 00000000004022d8
[    2.880000] $24   : 0000000000000005 000000007784ba80                                  
[    2.880000] $28   : 980000009a2e4000 980000009a2e7e70 000000007fd876e8 ffffffff802077e0
[    2.880000] Hi    : 000000000000002c
[    2.880000] Lo    : 000000000000000b
[    2.880000] epc   : ffffffff8020e8d4 do_cpu+0x304/0x4f0
[    2.880000]     Tainted: G      D       
[    2.880000] ra    : ffffffff802077e0 ret_from_exception+0x0/0x1c
[    2.880000] Status: 100044e3	KX SX UX KERNEL EXL IE 
[    2.880000] Cause : 10008028
[    2.880000] PrId  : 00006303 (ICT Loongson-2)
[    2.880000] Modules linked in:
[    2.880000] Process hotplug (pid: 232, threadinfo=980000009a2e4000, task=980000009f1c5ea8, tls=0000000000000000)
[    2.880000] Stack : 0000000077850000 0000000077862c10 ffffffffffffc000 0000000077861ed0
	  00000000778622d8 0000000000400164 000000007fd876e0 ffffffff802077e0
	  0000000000000000 0000000077832c14 000000007fd875a8 0000000077862bf0
	  000000007fd875b8 0000000000000000 000000007fd87590 000000007fd876e8
	  ffffffffbba0ffce 000000007efefeff 0000000024242424 ffffffff81010100
	  0000000000000000 0000000000000fc1 0000000000000000 0000000000000000
	  0000000000400164 000000007fd876e0 0000000077862cf8 0000000000000000
	  0000000000000000 0000000077861ed0 0000000077861ed0 00000000004022d8
	  0000000000000005 000000007784ba80 000000006474e552 0000000000000000
	  000000007786a000 000000007fd87590 000000007fd876e8 0000000077841038
	  ...
[    2.880000] Call Trace:
[    2.880000] [<ffffffff8020e8d4>] do_cpu+0x304/0x4f0
[    2.880000] [<ffffffff802077e0>] ret_from_exception+0x0/0x1c
[    2.880000] 
[    2.880000] 
Code: 30420001  2c420001  0040202d <40038005> 2405feff  00651824  40838005  3c032000  3c052400 
[    2.884000] ---[ end trace 71c7b14ce7da9370 ]---
[    2.888000] Reserved instruction in kernel code[#3]:
[    2.888000] CPU: 0 PID: 233 Comm: hotplug Tainted: G      D        3.18.0-lemote-los_7f08-09423-g988adfd #1
[    2.888000] task: 980000009f1c48d0 ti: 980000009a2e0000 task.ti: 980000009a2e0000
[    2.888000] $ 0   : 0000000000000000 0000000077d5ec14 0000000000000000 0000000000000001
[    2.888000] $ 4   : 0000000000000000 000000001000802c 980000009a2e3eb0 0000000000000002
[    2.888000] $ 8   : 0000000000000010 000000007efefeff 0000000024242424 ffffffff81010100
[    2.888000] $12   : 00000000100044e1 000000001000001f 0000000000000000 0000000000000000
[    2.888000] $16   : 0000000000400164 000000007f9b0ad0 0000000077d8ecf8 0000000000000000
[    2.888000] $20   : 0000000000000000 0000000077d8ded0 0000000077d8ded0 00000000004022d8
[    2.888000] $24   : 0000000000000005 0000000077d77a80                                  
[    2.888000] $28   : 980000009a2e0000 980000009a2e3e70 000000007f9b0ad8 ffffffff802077e0
[    2.888000] Hi    : 000000000000002c
[    2.888000] Lo    : 000000000000000b
[    2.888000] epc   : ffffffff8020e8d4 do_cpu+0x304/0x4f0
[    2.888000]     Tainted: G      D       
[    2.888000] ra    : ffffffff802077e0 ret_from_exception+0x0/0x1c
[    2.888000] Status: 100044e3	KX SX UX KERNEL EXL IE 
[    2.888000] Cause : 10008028
[    2.888000] PrId  : 00006303 (ICT Loongson-2)
[    2.888000] Modules linked in:
[    2.888000] Process hotplug (pid: 233, threadinfo=980000009a2e0000, task=980000009f1c48d0, tls=0000000000000000)
[    2.888000] Stack : 0000000077d7c000 0000000077d8ec10 ffffffffffffc000 0000000077d8ded0
	  0000000077d8e2d8 0000000000400164 000000007f9b0ad0 ffffffff802077e0
	  0000000000000000 0000000077d5ec14 000000007f9b0998 0000000077d8ebf0
	  000000007f9b09a8 0000000000000000 000000007f9b0980 000000007f9b0ad8
	  ffffffffbba0ffce 000000007efefeff 0000000024242424 ffffffff81010100
	  0000000000000000 0000000000000fc1 0000000000000000 0000000000000000
	  0000000000400164 000000007f9b0ad0 0000000077d8ecf8 0000000000000000
	  0000000000000000 0000000077d8ded0 0000000077d8ded0 00000000004022d8
	  0000000000000005 0000000077d77a80 000000006474e552 0000000000000000
	  0000000077d96000 000000007f9b0980 000000007f9b0ad8 0000000077d6d038
	  ...
[    2.888000] Call Trace:
[    2.888000] [<ffffffff8020e8d4>] do_cpu+0x304/0x4f0
[    2.888000] [<ffffffff802077e0>] ret_from_exception+0x0/0x1c
[    2.888000] 
[    2.888000] 
Code: 30420001  2c420001  0040202d <40038005> 2405feff  00651824  40838005  3c032000  3c052400 
[    2.892000] ---[ end trace 71c7b14ce7da9371 ]---

A.
