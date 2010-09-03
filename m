Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Sep 2010 11:14:14 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.17.10]:52346 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491084Ab0ICJOK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Sep 2010 11:14:10 +0200
Received: from corscience.de (DSL01.212.114.252.242.ip-pool.NEFkom.net [212.114.252.242])
        by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
        id 0MXCef-1PNdvi2qJR-00WFTx; Fri, 03 Sep 2010 11:13:32 +0200
Received: from [192.168.102.58] (unknown [192.168.102.58])
        by corscience.de (Postfix) with ESMTP id 31FF051FA1;
        Fri,  3 Sep 2010 11:13:31 +0200 (CEST)
Message-ID: <4C80BC3A.7010406@corscience.de>
Date:   Fri, 03 Sep 2010 11:13:30 +0200
From:   Bernhard Walle <walle@corscience.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100713 Thunderbird/3.0.6
MIME-Version: 1.0
To:     Arnaud Patard <apatard@mandriva.com>
CC:     Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, ddaney@caviumnetworks.com,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: N32: Fix getdents64 syscall for n32
References: <1283501734-6532-1-git-send-email-walle@corscience.de>      <20100903084213.GA32339@lst.de> <m3pqwvb438.fsf@anduin.mandriva.com>
In-Reply-To: <m3pqwvb438.fsf@anduin.mandriva.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V02:K0:R8n2dqZbSo1xc86ONWX6R7PJJuLEVGlBZwPViS+/OGh
 523htMkIdbHbIkOqda0TIPPN4JyDI7383qOLwUNK342kBNRpba
 RlUPBnCwU53qneUJtvpdL95qE1sZPDzHzHOzY1T/UQOsCqb0VX
 2oVyEQidoZ1JfsIgMa1TUkVIy3E89nZKOwwcxBggcZMXo/cqiz
 LXrzoU8SA2i88F6SXPI1A==
X-archive-position: 27715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: walle@corscience.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2430

Am 03.09.2010 10:53, schrieb Arnaud Patard:
>
> I guess the explanation is the one below :
>
> $ ./scripts/get_maintainer.pl -f arch/mips/kernel/scall64-n32.S
> Ralf Baechle<ralf@linux-mips.org>
> David Daney<ddaney@caviumnetworks.com>
> Andrew Morton<akpm@linux-foundation.org>
> "Eric W. Biederman"<ebiederm@xmission.com>
> Christoph Hellwig<hch@lst.de>
> linux-mips@linux-mips.org
> linux-kernel@vger.kernel.org

Yes, I just used that script and trusted the results. Sorry for that.


Regards,
Bernhard
