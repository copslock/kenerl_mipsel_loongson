Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 18:45:31 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43404 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904267Ab1KIRp1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2011 18:45:27 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA9HjL9l004712;
        Wed, 9 Nov 2011 17:45:21 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA9HjKrL004710;
        Wed, 9 Nov 2011 17:45:20 GMT
Date:   Wed, 9 Nov 2011 17:45:20 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jian Peng <jipeng@broadcom.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: patch to support topdown mmap allocation in MIPS
Message-ID: <20111109174520.GA3857@linux-mips.org>
References: <E18F441196CA634DB8E1F1C56A50A8743242B54C8A@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4DD1BD72.2000408@caviumnetworks.com>
 <E18F441196CA634DB8E1F1C56A50A8743242B54D97@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4DD2A729.9090502@caviumnetworks.com>
 <E18F441196CA634DB8E1F1C56A50A8743242B54FA7@IRVEXCHCCR01.corp.ad.broadcom.com>
 <E18F441196CA634DB8E1F1C56A50A874572CCBB6B5@IRVEXCHCCR01.corp.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18F441196CA634DB8E1F1C56A50A874572CCBB6B5@IRVEXCHCCR01.corp.ad.broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7955

On Wed, May 25, 2011 at 10:47:04AM -0700, Jian Peng wrote:

> What else should I do to get this patch merged?

Since there *still* is confusion about the merge status of this patch:
I merged https://patchwork.linux-mips.org/patch/2389/ already for
Linux 3.0 as commit id d0be89f6c2570a63ac44ccdd12473a54243cd296.

https://patchwork.linux-mips.org/patch/2412/ is still marked as "new"
in patchwork and I'm going to drop it now.

  Ralf
