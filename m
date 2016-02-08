Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 18:02:38 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2785 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012049AbcBHRChHxzeP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 18:02:37 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 79740F61DE0BD;
        Mon,  8 Feb 2016 17:02:28 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Mon, 8 Feb 2016
 17:02:30 +0000
Date:   Mon, 8 Feb 2016 16:58:29 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Daniel Wagner <daniel.wagner@bmw-carit.de>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3 3/3] mips: Differentiate between 32 and 64 bit ELF
 header
In-Reply-To: <1454946278-13859-4-git-send-email-daniel.wagner@bmw-carit.de>
Message-ID: <alpine.DEB.2.00.1602081657000.15885@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1602061624460.15885@tp.orcam.me.uk> <1454946278-13859-1-git-send-email-daniel.wagner@bmw-carit.de> <1454946278-13859-4-git-send-email-daniel.wagner@bmw-carit.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Mon, 8 Feb 2016, Daniel Wagner wrote:

> Therefore, we rather define vmcore_elf{32|64}_check_arch() as a
> basic machine check and use it also in binfm_elf?32.c as well.
> 
> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
> Suggested-by: Maciej W. Rozycki <macro@imgtec.com>
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> ---

Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>

  Maciej
