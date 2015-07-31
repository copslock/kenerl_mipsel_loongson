Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Jul 2015 18:29:30 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35797 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011893AbbGaQ32NTeZV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Jul 2015 18:29:28 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2746C405;
        Fri, 31 Jul 2015 16:29:22 +0000 (UTC)
Date:   Fri, 31 Jul 2015 09:29:21 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     David Herrmann <dh.herrmann@gmail.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        David Herrmann <dh.herrmann@googlemail.com>,
        Daniel Mack <daniel@zonque.org>,
        Djalal Harouni <tixxdz@opendz.org>, linux-mips@linux-mips.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: samples/kdbus/kdbus-workers.c and cross compiling MIPS
Message-ID: <20150731162921.GA6335@kroah.com>
References: <20150729161912.GF18685@windriver.com>
 <CANq1E4TgWK-8JkUtOYfTOL9Dx=jWeVpA-h881TXSA3BNjp+MPw@mail.gmail.com>
 <55BA2B91.5070107@windriver.com>
 <CANq1E4S7awCfPaNduoG8ENHmnGhR7-VT-9LvGwREZs-h8zNmzQ@mail.gmail.com>
 <1438326061.29353.9.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438326061.29353.9.camel@ellerman.id.au>
User-Agent: Mutt/1.5.23+102 (2ca89bed6448) (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Fri, Jul 31, 2015 at 05:01:01PM +1000, Michael Ellerman wrote:
> It's obviously possible that some samples build with that configuration, but
> building against another arch'es kernel headers just seems like it's asking for
> trouble. Even if we can build the samples, they will never run correctly.
> 
> So I suggest we should just disable SAMPLES if we're cross compiling, full stop.

Yes, that seems like a much better solution overall.  Can you send a
patch for this?

thanks,

greg k-h
