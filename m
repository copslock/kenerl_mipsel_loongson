Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2018 09:44:08 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:33302 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990768AbeKNImrBozpz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Nov 2018 09:42:47 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3AA01AD7E;
        Wed, 14 Nov 2018 08:42:46 +0000 (UTC)
Date:   Wed, 14 Nov 2018 09:42:44 +0100
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        Huacai Chen <chenhc@lemote.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] MIPS: Loongson3,SGI-IP27: Simplify max_low_pfn
 calculation
Message-Id: <20181114094244.d762f99410334174ca5ba851@suse.de>
In-Reply-To: <20181112221742.4900-1-paul.burton@mips.com>
References: <20181112221742.4900-1-paul.burton@mips.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <tbogendoerfer@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbogendoerfer@suse.de
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

On Mon, 12 Nov 2018 22:18:01 +0000
Paul Burton <paul.burton@mips.com> wrote:

> Both the Loongson3 & SGI-IP27 platforms set max_low_pfn to the last
> available PFN describing memory. They both do it in paging_init() which
> is later than ideal since max_low_pfn is used before that function is
> called. Simplify both platforms to trivially initialize max_low_pfn
> using the end address of DRAM, and do it earlier in prom_meminit().
> []

Ok, I was wrong, the patch works as it is.

Tested-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
