Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2011 17:07:10 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:57319 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903731Ab1LIQHF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Dec 2011 17:07:05 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pB9G6i4Z008710;
        Fri, 9 Dec 2011 16:06:44 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pB9G6esI008708;
        Fri, 9 Dec 2011 16:06:40 GMT
Date:   Fri, 9 Dec 2011 16:06:40 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Cong Wang <amwang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Kosina <jkosina@suse.cz>,
        Kevin Cernekee <cernekee@gmail.com>,
        "Justin P. Mattock" <justinmattock@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 04/62] mips: remove the second argument of
 k[un]map_atomic()
Message-ID: <20111209160639.GA30988@linux-mips.org>
References: <1322371662-26166-1-git-send-email-amwang@redhat.com>
 <1322371662-26166-5-git-send-email-amwang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1322371662-26166-5-git-send-email-amwang@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7777

On Sun, Nov 27, 2011 at 01:26:44PM +0800, Cong Wang wrote:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

I assume you want to merge this patch as part of a single series?

  Ralf
