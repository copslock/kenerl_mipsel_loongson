Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 19:12:31 +0100 (CET)
Received: from smtp4-g21.free.fr ([212.27.42.4]:34451 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904132Ab1KRSMY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Nov 2011 19:12:24 +0100
Received: from [192.168.108.17] (unknown [213.36.7.13])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 4F7AF4C84C9;
        Fri, 18 Nov 2011 19:12:18 +0100 (CET)
Subject: Re: [PATCH v2 01/11] MIPS: BCM63XX: set default pci cache line
 size.
From:   Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
In-Reply-To: <20111115195438.GF26141@linux-mips.org>
References: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
         <1320430175-13725-2-git-send-email-mbizon@freebox.fr>
         <20111115195438.GF26141@linux-mips.org>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Organization: Freebox
Date:   Fri, 18 Nov 2011 19:12:16 +0100
Message-ID: <1321639936.32730.33.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 31801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15761

On Tue, 2011-11-15 at 19:54 +0000, Ralf Baechle wrote:
> 
> Presumably because the CPU cache line size is 16 bytes?  On MIPS we
> don't set pci_dfl_cache_line_size; a patch (only compile tested) to
> pick a sane default is below.
> 
> Does this work for you? 

[    0.192000] PCI: CLS 0 bytes, default 16

yes it does

-- 
Maxime
