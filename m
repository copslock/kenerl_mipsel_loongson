Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Nov 2004 22:42:54 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:34488 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225298AbUK3Wmu>; Tue, 30 Nov 2004 22:42:50 +0000
Received: from localhost ([127.0.0.1])
	by real.realitydiluted.com with esmtp (Exim 4.34 #1 (Debian))
	id 1CZGhs-0003Af-BR; Tue, 30 Nov 2004 16:42:48 -0600
Message-ID: <41ACF88D.3090300@realitydiluted.com>
Date: Tue, 30 Nov 2004 16:47:41 -0600
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org, mlachwani@prometheus.mvista.com
Subject: Re: [PATCH] Broadcom SWARM IDE in 2.6.10
References: <20041130205651.GA17104@prometheus.mvista.com>
In-Reply-To: <20041130205651.GA17104@prometheus.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------030402060407010507030103"
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------030402060407010507030103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hey Manish.

Your patch still does not work for me. My swarm board has a
B0/B1 revision CPU running in big endian. Below is the crash
report. I will play a bit with this as well. My gcc is 3.1.1
and binutils of 2.12.1.

-Steve

--------------030402060407010507030103
Content-Type: text/plain;
 name="ide-swarm-crash.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-swarm-crash.txt"

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
DBE physical address: 00dc0001e0
Data bus error, epc == 802955bc, ra == 802955bc
Oops in arch/mips/kernel/traps.c::do_be, line 330[#1]:
Cpu 1

[SNIP]

Call Trace:
 [<80296e20>] wait_hwif_ready+0x28/0x140
 [<80296e54>] wait_hwif_ready+0x5c/0x140
 [<80297124>] probe_hwif+0x100/0x564
 [<801adc7c>] get_inode_number+0x4c/0x9c
 [<801ae2b8>] proc_create+0x7c/0xe0
 [<80298624>] ideprobe_init+0x1bc/0x1c8
 [<801ae4f0>] create_proc_entry+0x74/0xd8

--------------030402060407010507030103--
