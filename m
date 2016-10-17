Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 19:40:14 +0200 (CEST)
Received: from mail-out.m-online.net ([212.18.0.10]:51602 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992226AbcJQRkH0T42Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 19:40:07 +0200
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3syQSw5qhyz3hjkG;
        Mon, 17 Oct 2016 19:40:00 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 3syQSw2gKYzvkLT;
        Mon, 17 Oct 2016 19:40:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
        with ESMTP id iw2E5pLkhY5P; Mon, 17 Oct 2016 19:39:58 +0200 (CEST)
X-Auth-Info: sbDWcOEaFnTcl7aVMCAPGat6GJwzmKMGNOBt/kdg17iPwEJtLx4+Dox+P46lAwi3
Received: from igel.home (ppp-88-217-7-89.dynamic.mnet-online.de [88.217.7.89])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 17 Oct 2016 19:39:58 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id E08D72C4481; Mon, 17 Oct 2016 19:39:57 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Tejun Heo <tj@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Jiri Slaby" <jslaby@suse.cz>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Ivan Delalande" <colona@arista.com>,
        Thierry Reding <treding@nvidia.com>,
        "Borislav Petkov" <bp@suse.de>, Jan Kara <jack@suse.com>,
        Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] console: Don't prefer first registered if DT specifies stdout-path
References: <20160809125010.14150-1-paul.burton@imgtec.com>
        <20160809151937.26118-1-paul.burton@imgtec.com>
        <87bmyk88x5.fsf@linux-m68k.org> <4033254.tBrl4yKcsP@np-p-burton>
X-Yow:  I guess it was all a DREAM..  or an episode of HAWAII FIVE-O...
Date:   Mon, 17 Oct 2016 19:39:57 +0200
In-Reply-To: <4033254.tBrl4yKcsP@np-p-burton> (Paul Burton's message of "Mon,
        17 Oct 2016 11:33:55 +0100")
Message-ID: <87oa2ij2mq.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <whitebox@nefkom.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: schwab@linux-m68k.org
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

On Okt 17 2016, Paul Burton <paul.burton@imgtec.com> wrote:

> Could you share the device tree from your system?

This is the contents of chosen/linux,stdout-path on the systems I have:

chosen/linux,stdout-path
                 "/pci@f0000000/ATY,SnowyParent@10/ATY,Snowy_A@0"

chosen/linux,stdout-path                                                        
                 "/pci@0,f0000000/NVDA,Parent@10/NVDA,Display-B@1"

Is that what you need?  There is also chosen/stdout, but no
aliases/stdout.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
