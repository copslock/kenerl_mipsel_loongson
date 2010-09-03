Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Sep 2010 10:53:06 +0200 (CEST)
Received: from mx1.moondrake.net ([212.85.150.166]:55787 "EHLO
        mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1491068Ab0ICIxD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Sep 2010 10:53:03 +0200
Received: by mx1.mandriva.com (Postfix, from userid 501)
        id 1E5B7274128; Fri,  3 Sep 2010 10:53:01 +0200 (CEST)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.mandriva.com (Postfix) with ESMTP id 5DCF2274005;
        Fri,  3 Sep 2010 10:53:00 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
        by office-abk.mandriva.com (Postfix) with ESMTP id 9E43985701;
        Fri,  3 Sep 2010 11:14:17 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
        by anduin.mandriva.com (Postfix) with ESMTP id 678CEFF855;
        Fri,  3 Sep 2010 10:53:31 +0200 (CEST)
From:   Arnaud Patard <apatard@mandriva.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bernhard Walle <walle@corscience.de>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, ddaney@caviumnetworks.com,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: N32: Fix getdents64 syscall for n32
References: <1283501734-6532-1-git-send-email-walle@corscience.de>
        <20100903084213.GA32339@lst.de>
Organization: Mandriva
Date:   Fri, 03 Sep 2010 10:53:31 +0200
In-Reply-To: <20100903084213.GA32339@lst.de> (Christoph Hellwig's message of "Fri, 3 Sep 2010 10:42:13 +0200")
Message-ID: <m3pqwvb438.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-archive-position: 27713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2408

Christoph Hellwig <hch@lst.de> writes:

Hi,

> I'm not sure why people suddenly started Ccing me on utterly random
> patches, but could you guys please bloody stop it?  Thanks!

I guess the explanation is the one below :

$ ./scripts/get_maintainer.pl -f arch/mips/kernel/scall64-n32.S
Ralf Baechle <ralf@linux-mips.org>
David Daney <ddaney@caviumnetworks.com>
Andrew Morton <akpm@linux-foundation.org>
"Eric W. Biederman" <ebiederm@xmission.com>
Christoph Hellwig <hch@lst.de>
linux-mips@linux-mips.org
linux-kernel@vger.kernel.org


Arnaud
