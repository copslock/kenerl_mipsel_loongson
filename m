Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 13:13:11 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:60632 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990397AbeBQMNE4r3Fl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2018 13:13:04 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sat, 17 Feb 2018 12:12:57 +0000
Received: from [10.20.78.31] (10.20.78.31) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Sat, 17 Feb 2018 04:07:28 -0800
Date:   Sat, 17 Feb 2018 11:57:05 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>,
        <linux-mips@linux-mips.org>
Subject: Re: [RFC v2] MIPS: R5900: Workaround exception NOP execution bug
 (FLX05)
In-Reply-To: <20180217111644.GA2496@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1802171141260.3553@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk> <20171029172016.GA2600@localhost.localdomain> <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk> <20171111160422.GA2332@localhost.localdomain> <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk> <20180211075608.GC2222@localhost.localdomain> <alpine.DEB.2.00.1802111239380.3553@tp.orcam.me.uk> <20180215191502.GA2736@localhost.localdomain> <alpine.DEB.2.00.1802151934180.3553@tp.orcam.me.uk>
 <20180217111644.GA2496@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1518869576-452060-19043-53687-7
X-BESS-VER: 2018.2.1-r1802152107
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190123
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

Hi Fredrik,

> This was an interesting exercise. I suspect GDB runs out of memory since
> 
> 	# gdb -q -c /proc/kcore
> 	[New process 1]
> 	Segmentation fault
> 
> with
> 
> 	# dmesg | tail -n3
> 	do_page_fault(): sending SIGSEGV to gdb for invalid read access from 000000a8
> 	epc = 00953910 in gdb[400000+6d1000]
> 	ra  = 009538b8 in gdb[400000+6d1000]
> 
> to me looks like GDB does a NULL pointer deference (the PS2 has 32 MiB of
> RAM, of which 16 MiB is used for a ramdisk in my setup). GDB once could
> handle core files remotely, but this capability is apparently now lost:
> 
> https://www.redhat.com/archives/crash-utility/2011-December/msg00019.html

 If you can't access /proc/kcore with GDB locally, for whatever reason, 
then `dd' it (or a part of it); to a regular file and copy it to another 
machine.  Use cross-GDB if necessary.  With 16 MiB of RAM available only 
it can be getting really tight; the kernel itself takes half of it too I 
suppose.

> In this case I'm wondering whether kcore contains proper ELF headers. What
> is the output of readelf for your kcore? I have this:

 Looks reasonable to me.

> Returning to the more awkward /dev/mem device, the "bad address" error with
> for example
> 
> 	# xxd -s $(( 0x80000000 )) -l 256 /dev/mem
> 	xxd: /dev/mem: Bad address

 You need to use bus (physical) rather than virtual addresses with 
/dev/mem, so:

# xxd -s 0 -l 256 /dev/mem

or suchlike.

 HTH,

  Maciej
