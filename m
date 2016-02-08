Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 18:05:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5507 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012028AbcBHRFog-QTP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 18:05:44 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 6F6448E43EDC3;
        Mon,  8 Feb 2016 17:05:35 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Mon, 8 Feb 2016
 17:05:38 +0000
Date:   Mon, 8 Feb 2016 17:05:37 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Daniel Wagner <daniel.wagner@bmw-carit.de>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3 2/3] crash_dump: Add vmcore_elf32_check_arch
In-Reply-To: <1454946278-13859-3-git-send-email-daniel.wagner@bmw-carit.de>
Message-ID: <alpine.DEB.2.00.1602081705150.15885@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1602061624460.15885@tp.orcam.me.uk> <1454946278-13859-1-git-send-email-daniel.wagner@bmw-carit.de> <1454946278-13859-3-git-send-email-daniel.wagner@bmw-carit.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51855
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

> parse_crash_elf{32|64}_headers will check the headers via the
> elf_check_arch respectively vmcore_elf64_check_arch macro.
> 
> The MIPS architecture implements those two macros differently.
> In order to make the differentiation more explicit, let's introduce
> an vmcore_elf32_check_arch to allow the archs to overwrite it.
> 
> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
> Suggested-by: Maciej W. Rozycki <macro@imgtec.com>
> ---

Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>

  Maciej
