Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2012 16:52:41 +0200 (CEST)
Received: from mail.skyhub.de ([78.46.96.112]:53236 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903530Ab2FROwb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Jun 2012 16:52:31 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTP id EF3421D996B;
        Mon, 18 Jun 2012 16:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alien8.de; s=alien8;
        t=1340031151; bh=4SQ8U94ruvR8F+CcCPi2T3fZBzySKZIfUG7cYQMz/iU=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To; b=ZdcjkjXI/vIsO4oPmyAEiwSuwLrvcMGOeHUwHV
        iVTi0NHtMdA5RokLfjuWku6FR2V1W3yKOLMEm+Ol6fQH6Bf9zCVC16X2P22IiooUmhW
        5HiKFHRYcxX7DVShExLsMB6QsdmFTzyaWNR5LBAgRMwyWb52ETwyn8Y454IVLmCu3g=
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (door.skyhub.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fbH8BO4IQNBm; Mon, 18 Jun 2012 16:52:30 +0200 (CEST)
Received: from x1.localdomain (unknown [217.9.48.20])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA;
        Mon, 18 Jun 2012 16:52:30 +0200 (CEST)
Received: by x1.localdomain (Postfix, from userid 1000)
        id 95E4EAA114; Mon, 18 Jun 2012 16:52:31 +0200 (CEST)
Date:   Mon, 18 Jun 2012 16:52:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH 09/14] ata: Use 32bit DMA in AHCI for Loongson 3.
Message-ID: <20120618145231.GA4377@x1.osrc.amd.com>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
 <1339747801-28691-10-git-send-email-chenhc@lemote.com>
 <4FDB08AC.8010208@mvista.com>
 <CAAhV-H6AKp+aGUozOxQoLgGYQ+GtHMbKKC4MVkFA570zodjgDA@mail.gmail.com>
 <20120617120557.GE31534@liondog.tnic>
 <CAAhV-H67M5xH+HMyVNopm=TPhei24NfnzNqiPMA+Ucz4Y7V3hg@mail.gmail.com>
 <20120618101030.GA24308@liondog.tnic>
 <CAAhV-H5g2Y81fr=yU76RHDfzDSxG_7GpTs=RZm8ha8JbzHnfzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAhV-H5g2Y81fr=yU76RHDfzDSxG_7GpTs=RZm8ha8JbzHnfzQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bp@alien8.de
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

On Mon, Jun 18, 2012 at 06:41:58PM +0800, Huacai Chen wrote:
> Ohh, this is because Loongson-3 has a hardware bug, when the HT
> controller receive a 64-bit DMA address, the high bits is lost. So set
> to 32-bit DMA is just a workaround.

Ok, this should definitely go into the commit message of your patch then
since it explains why you need that flag set.

Thanks.

-- 
Regards/Gruss,
Boris.
