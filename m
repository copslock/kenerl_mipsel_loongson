Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Aug 2012 07:52:40 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56643 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901166Ab2HLFwg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Aug 2012 07:52:36 +0200
Message-ID: <50274467.90509@phrozen.org>
Date:   Sun, 12 Aug 2012 07:51:35 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH V5 01/18] MIPS: Loongson: Add basic Loongson-3 definition.
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com> <1344677543-22591-2-git-send-email-chenhc@lemote.com>
In-Reply-To: <1344677543-22591-2-git-send-email-chenhc@lemote.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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
X-Status: A

On 11/08/12 11:32, Huacai Chen wrote:
>  #define PRID_IMP_LOONGSON2	0x6300
> +#define PRID_IMP_LOONGSON3	0x6300
>  

as PRID_IMP_LOONGSON2 and PRID_IMP_LOONGSON3 share the same value, its
not really a uniq ID anymore. Maybe change this to a common PRID ?

patch 2/18 does not even make use of this new symbol inside
arch/mips/kernel/cpu-probe.c

John
