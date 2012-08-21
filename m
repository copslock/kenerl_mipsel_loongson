Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 15:44:55 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60952 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903498Ab2HUNov (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Aug 2012 15:44:51 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q7LCqMO5009068;
        Tue, 21 Aug 2012 14:52:22 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q7LCqLTU009067;
        Tue, 21 Aug 2012 14:52:21 +0200
Date:   Tue, 21 Aug 2012 14:52:21 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jayachandran C <jayachandranc@netlogicmicro.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 12/12] MIPS: Netlogic: XLP defconfig update
Message-ID: <20120821125221.GC2550@linux-mips.org>
References: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
 <1342196605-4260-13-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1342196605-4260-13-git-send-email-jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34301
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Jul 13, 2012 at 09:53:25PM +0530, Jayachandran C wrote:

> +CONFIG_PARTITION_ADVANCED=y
> +CONFIG_ACORN_PARTITION=y
> +CONFIG_ACORN_PARTITION_ICS=y
> +CONFIG_ACORN_PARTITION_RISCIX=y
> +CONFIG_OSF_PARTITION=y
> +CONFIG_AMIGA_PARTITION=y
> +CONFIG_ATARI_PARTITION=y
> +CONFIG_MAC_PARTITION=y
> +CONFIG_BSD_DISKLABEL=y
> +CONFIG_MINIX_SUBPARTITION=y
> +CONFIG_SOLARIS_X86_PARTITION=y
> +CONFIG_UNIXWARE_DISKLABEL=y
> +CONFIG_LDM_PARTITION=y
> +CONFIG_SGI_PARTITION=y
> +CONFIG_ULTRIX_PARTITION=y
> +CONFIG_SUN_PARTITION=y
> +CONFIG_KARMA_PARTITION=y
> +CONFIG_EFI_PARTITION=y
> +CONFIG_SYSV68_PARTITION=y

Plenty of weird partition types enabled in this config update; you may
want to review the config file for a future version.  Unless you really
want to be able to deal with 1980's partitioning schemes, of course.

  Ralf
