Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2015 11:24:45 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39554 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009322AbbJEJYnMGNhs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Oct 2015 11:24:43 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t959OfNV001538;
        Mon, 5 Oct 2015 11:24:41 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t959Ofnm001537;
        Mon, 5 Oct 2015 11:24:41 +0200
Date:   Mon, 5 Oct 2015 11:24:41 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] MIPS: BPF: Disable JIT on R3000 (MIPS-I)
Message-ID: <20151005092440.GA1389@linux-mips.org>
References: <1441481368.15927.0.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1441481368.15927.0.camel@decadent.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sat, Sep 05, 2015 at 08:29:28PM +0100, Ben Hutchings wrote:

> The JIT does not include the load delay slots required by MIPS-I
> processors.

See 0c5d187828588dd1b36cb93b4481a8db467ef3e8 (MIPS: BPF: Fix load delay
slots.) for a proper fix.

I'm wondering, how did you find this issue, are you scanning the code
for broken instruction sequences?

  Ralf
