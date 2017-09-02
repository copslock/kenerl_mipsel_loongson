Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Sep 2017 00:22:08 +0200 (CEST)
Received: from gate.crashing.org ([63.228.1.57]:39926 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993359AbdIBWV4fbh4R (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Sep 2017 00:21:56 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id v82MKsW3017746;
        Sat, 2 Sep 2017 17:20:56 -0500
Message-ID: <1504390854.4974.108.camel@kernel.crashing.org>
Subject: Re: [PATCH] devicetree: Remove remaining references/tests for
 "chosen@0"
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        devicetree@vger.kernel.org
Cc:     linux-mips@linux-mips.org, monstr@monstr.eu,
        Linux PPC Mailing List <linuxppc-dev@lists.ozlabs.org>
Date:   Sun, 03 Sep 2017 08:20:54 +1000
In-Reply-To: <alpine.LFD.2.21.1709020416130.13598@localhost.localdomain>
References: <alpine.LFD.2.21.1709020416130.13598@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.5 (3.24.5-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <benh@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
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

On Sat, 2017-09-02 at 04:43 -0400, Robert P. J. Day wrote:
> Since, according to a recent devicetree ML posting by Rob Herring,
> the node "/chosen@0" is most likely for real Open Firmware and does
> not apply to DTSpec, remove all remaining tests and references for
> that node, of which there are very few left:

Technically that would break Open Firmware systems where the node is
really called chosen@0

Now I'm not sure such a thing actually exist however.

My collection of DTs don't seem to have one, except in the ancient html
variants that were extracted by the pengionppc folks for the original
PowerMac 8600 but I wonder if that's a bug in the extraction script
since they also have @0 on /packages etc...

Ben.
