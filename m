Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2015 13:39:27 +0100 (CET)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:53579 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008895AbbCWMjZMDxDl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Mar 2015 13:39:25 +0100
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 7A1D5460351
        for <linux-mips@linux-mips.org>; Mon, 23 Mar 2015 12:39:20 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AZcefs9X5-a8 for <linux-mips@linux-mips.org>;
        Mon, 23 Mar 2015 12:39:16 +0000 (GMT)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 98FE94606A4
        for <linux-mips@linux-mips.org>; Mon, 23 Mar 2015 12:39:16 +0000 (GMT)
Received: from localhost ([::1] helo=paulmartin.codethink.co.uk)
        by pm-laptop.codethink.co.uk with esmtp (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1Ya1dU-00055j-1H
        for linux-mips@linux-mips.org; Mon, 23 Mar 2015 12:39:16 +0000
Date:   Mon, 23 Mar 2015 12:39:16 +0000
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: OCTEON: Add mach-cavium-octeon/mangle-port.h
Message-ID: <20150323123914.GA19416@paulmartin.codethink.co.uk>
Mail-Followup-To: linux-mips@linux-mips.org
References: <1426867920-7907-1-git-send-email-aleksey.makarov@auriga.com>
 <1426867920-7907-3-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426867920-7907-3-git-send-email-aleksey.makarov@auriga.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.martin@codethink.co.uk
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

On Fri, Mar 20, 2015 at 07:11:57PM +0300, Aleksey Makarov wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Needed for little-endian ioport access.
> This fixes NOR flash in little-endian mode
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
> ---
>  .../include/asm/mach-cavium-octeon/mangle-port.h   | 74 ++++++++++++++++++++++

This seems to be a new header file that's not used anywhere else.

I get the feeling that there should be at least another three patches
in this series which have been omitted.

Certainly, the Octeon peripherals won't work with just the three part
patch set presented here.

Thanks for this patch (and the padding bugfix to the boot structure).

PS. Don't forget the missing htons() in drivers/staging/octeon/ethernet-tx.c

-- 
Paul Martin                                  http://www.codethink.co.uk/
Senior Software Developer, Codethink Ltd.
