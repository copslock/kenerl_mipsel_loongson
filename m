Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Sep 2015 15:42:43 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:60084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008401AbbIUNmluBP8j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Sep 2015 15:42:41 +0200
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        by mx1.redhat.com (Postfix) with ESMTPS id EC8482F5165;
        Mon, 21 Sep 2015 13:42:34 +0000 (UTC)
Received: from warthog.procyon.org.uk ([10.3.112.5])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t8LDgQce016797;
        Mon, 21 Sep 2015 09:42:27 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
References: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-cachefs@redhat.com, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-omap@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, lustre-devel@lists.lustre.org
Subject: Re: [PATCH 00/38] Fixes related to incorrect usage of unsigned types
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17570.1442842945.1@warthog.procyon.org.uk>
Date:   Mon, 21 Sep 2015 14:42:25 +0100
Message-ID: <17571.1442842945@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Return-Path: <dhowells@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhowells@redhat.com
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

Andrzej Hajda <a.hajda@samsung.com> wrote:

> Semantic patch finds comparisons of types:
>     unsigned < 0
>     unsigned >= 0
> The former is always false, the latter is always true.
> Such comparisons are useless, so theoretically they could be
> safely removed, but their presence quite often indicates bugs.

Or someone has left them in because they don't matter and there's the
possibility that the type being tested might be or become signed under some
circumstances.  If the comparison is useless, I'd expect the compiler to just
discard it - for such cases your patch is pointless.

If I have, for example:

	unsigned x;

	if (x == 0 || x > 27)
		give_a_range_error();

I will write this as:

	unsigned x;

	if (x <= 0 || x > 27)
		give_a_range_error();

because it that gives a way to handle x being changed to signed at some point
in the future for no cost.  In which case, your changing the <= to an ==
"because the < part of the case is useless" is arguably wrong.

David
