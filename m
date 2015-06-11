Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jun 2015 15:17:57 +0200 (CEST)
Received: from tex.lwn.net ([70.33.254.29]:47710 "EHLO vena.lwn.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006777AbbFKNRziLDFq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Jun 2015 15:17:55 +0200
Received: from lwn.net (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by vena.lwn.net (Postfix) with ESMTP id 7EBE21540047;
        Thu, 11 Jun 2015 07:17:52 -0600 (MDT)
Date:   Thu, 11 Jun 2015 07:20:28 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Xose Vazquez Perez <xose.vazquez@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Generic kernel features that need architecture(mips) support
Message-ID: <20150611072028.7d0fe2d7@lwn.net>
In-Reply-To: <20150611062452.GB32133@gmail.com>
References: <55759543.1010408@gmail.com>
        <20150610145804.GG2753@linux-mips.org>
        <5578679D.2030307@gmail.com>
        <20150611062452.GB32133@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <corbet@lwn.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: corbet@lwn.net
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

On Thu, 11 Jun 2015 08:24:53 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> Jon: would you like to receive all patches to Documentation/features/ so you can 
> collect them in the documentation tree, or can maintainers patch it as part of any 
> feature work that affects the tables? I think it's all finegrained enough to not 
> create conflicts. That way they would become partly self-maintaining. (Or at least 
> one can always hope! ;-)

I sort of figured I'd handle it the way I do the rest of Documentation/ —
I'm happy to herd the patches, but I also have no problem staying out of
the way when other maintainers reach into it.

jon
