Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2017 18:03:21 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:38126 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993934AbdAXRDKivA3T (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jan 2017 18:03:10 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v0OH36x8026981;
        Tue, 24 Jan 2017 18:03:06 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v0OH35Kd026980;
        Tue, 24 Jan 2017 18:03:05 +0100
Date:   Tue, 24 Jan 2017 18:03:05 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sebastien Decourriere <sebtx452@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] mtd: maps: lantiq-flash: Check if the EBU endianness
 swap is enabled
Message-ID: <20170124170305.GA26937@linux-mips.org>
References: <1484904834-14980-1-git-send-email-sebtx452@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484904834-14980-1-git-send-email-sebtx452@gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Jan 20, 2017 at 10:33:54AM +0100, Sebastien Decourriere wrote:

> The purpose of this patch is to enable the software address endianness
> swapping only when the in SoC EBU endianness swapping is disabled.
> To perform this check, I look at Bit 30 of the EBU_CON_0 register.
> Actually, the driver expects that the in SoC swapping is disabled.
> This is the case with current bootloaders shuch as U-boot.
> 
> This applies only to vr9 (xrx200) rev 1.2 and ar10 (xrx300).
> 
> I have a router which uses a proprietary bootloader which keeps
> the in SoC swapping enabled. The SoC in this router is a vrx200 v1.2.
> In this SoC version, I can keep the in SoC swapping without any problem.
> 
> This patch replaces my previous broken patch.
> 
> Signed-off-by: Sebastien Decourriere <sebtx452@gmail.com>
>  .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |  1 +
>  drivers/mtd/maps/lantiq-flash.c                    | 29 +++++++++++++++++++---

Acked-by: Ralf Baechle <ralf@linux-mips.org>

for the trivial MIPS bit.

  Ralf
