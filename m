Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 06:58:40 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:53358 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007986AbbHCE6ixNrKo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Aug 2015 06:58:38 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 5B2DF1402CD;
        Mon,  3 Aug 2015 14:58:34 +1000 (AEST)
Message-ID: <1438577914.17319.3.camel@ellerman.id.au>
Subject: Re: samples/kdbus/kdbus-workers.c and cross compiling MIPS
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Herrmann <dh.herrmann@gmail.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        David Herrmann <dh.herrmann@googlemail.com>,
        Daniel Mack <daniel@zonque.org>,
        Djalal Harouni <tixxdz@opendz.org>, linux-mips@linux-mips.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Date:   Mon, 03 Aug 2015 14:58:34 +1000
In-Reply-To: <20150731162921.GA6335@kroah.com>
References: <20150729161912.GF18685@windriver.com>
         <CANq1E4TgWK-8JkUtOYfTOL9Dx=jWeVpA-h881TXSA3BNjp+MPw@mail.gmail.com>
         <55BA2B91.5070107@windriver.com>
         <CANq1E4S7awCfPaNduoG8ENHmnGhR7-VT-9LvGwREZs-h8zNmzQ@mail.gmail.com>
         <1438326061.29353.9.camel@ellerman.id.au> <20150731162921.GA6335@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

On Fri, 2015-07-31 at 09:29 -0700, Greg Kroah-Hartman wrote:
> On Fri, Jul 31, 2015 at 05:01:01PM +1000, Michael Ellerman wrote:
> > It's obviously possible that some samples build with that configuration, but
> > building against another arch'es kernel headers just seems like it's asking for
> > trouble. Even if we can build the samples, they will never run correctly.
> > 
> > So I suggest we should just disable SAMPLES if we're cross compiling, full stop.
> 
> Yes, that seems like a much better solution overall.  Can you send a
> patch for this?

Yep, will do.

cheers
