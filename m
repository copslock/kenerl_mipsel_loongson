Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2011 10:26:19 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:30845 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S2097159Ab1F1I0K (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Jun 2011 10:26:10 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 28 Jun 2011 01:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,436,1304319600"; 
   d="scan'208";a="19149638"
Received: from unknown (HELO bob.linux.org.uk) ([10.255.13.97])
  by orsmga002.jf.intel.com with ESMTP; 28 Jun 2011 01:26:01 -0700
Date:   Tue, 28 Jun 2011 09:25:40 +0100
From:   Alan Cox <alan@linux.intel.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 10/12] SERIAL: SC26xx: Fix link error.
Message-ID: <20110628092540.61c94bf9@bob.linux.org.uk>
In-Reply-To: <f0b3d9a91be8dba5c45c14efebaa9c7800694f15.1309182743.git.ralf@linux-mips.org>
References: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
        <f0b3d9a91be8dba5c45c14efebaa9c7800694f15.1309182743.git.ralf@linux-mips.org>
Organization: Intel
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Organisation: Intel Corporation UK Ltd, registered no. 1134945 (England),
 Registered office Pipers Way, Swindon, SN3 1RJ
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 30537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@linux.intel.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 22636

On Mon, 27 Jun 2011 14:26:56 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> Kconfig allows enabling console support for the SC26xx driver even
> when it's configured as a module resulting in a:
> 
> ERROR: "uart_console_device" [drivers/tty/serial/sc26xx.ko] undefined!
> 
> modpost error since the driver was merged in
> eea63e0e8a60d00485b47fb6e75d9aa2566b989b [SC26XX: New serial driver
> for SC2681 uarts] in 2.6.25.  Fixed by only allowing console support
> to be enabled if the driver is builtin.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Acked-by: Alan Cox <alan@linux.intel.com>
