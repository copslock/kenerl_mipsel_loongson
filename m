Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 20:54:44 +0100 (CET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:38852 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011763AbbJ1TymzO06t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2015 20:54:42 +0100
Received: from blackmetal.musicnaut.iki.fi (85-76-112-16-nat.elisa-mobile.fi [85.76.112.16])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 58BD09004D;
        Wed, 28 Oct 2015 21:54:42 +0200 (EET)
Date:   Wed, 28 Oct 2015 21:54:36 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@linux-mips.org
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Matthew Fortune <matthew.fortune@imgtec.com>
Subject: FYI: old OCTEON bootloaders and .MIPS.abiflags
Message-ID: <20151028195436.GB1838@blackmetal.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49738
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

Current binutils adds .MIPS.abiflags section to the kernel vmlinux.

This seems break the boot on some old (buggy) OCTEON bootloaders:

	ELF file is 64 bit
	Attempting to allocate memory for ELF segment: addr: 0xffffffff816e67f0 (adjusted to: 0x00000000016e67f0), size 0x18
	Allocated memory for ELF segment: addr: 0xffffffff816e67f0, size 0x18
	Attempting to allocate memory for ELF segment: addr: 0xffffffff81100000 (adjusted to: 0x0000000001100000), size 0x1b86360
	Error allocating memory for elf image!
	## ERROR loading File!

The workaround is to remove the .MIPS.abiflags with "strip" - I guess that
is safe for the kernel... Not sure if there is nothing much else to be
done, and already a similar hack needs to be done for the .notes section.

I just wanted to post this in case some else faces the same issue.

A.
