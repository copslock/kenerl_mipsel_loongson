Received:  by oss.sgi.com id <S42458AbQIGACx>;
	Wed, 6 Sep 2000 17:02:53 -0700
Received: from u-48.karlsruhe.ipdial.viaginterkom.de ([62.180.20.48]:47620
        "EHLO u-48.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42230AbQIGACw>; Wed, 6 Sep 2000 17:02:52 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868990AbQIGACh>;
        Thu, 7 Sep 2000 02:02:37 +0200
Date:   Thu, 7 Sep 2000 02:02:37 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Kanoj Sarcar <kanoj@google.engr.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20000907020237.B20605@bacchus.dhis.org>
References: <20000907014521.A20605@bacchus.dhis.org> <200009062351.QAA14035@google.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200009062351.QAA14035@google.engr.sgi.com>; from kanoj@google.engr.sgi.com on Wed, Sep 06, 2000 at 04:51:19PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Sep 06, 2000 at 04:51:19PM -0700, Kanoj Sarcar wrote:

> The act of flushing the L2 cache, should include flushing the L1
> cache, whether done by software or processor provided primitives, 
> to guarantee the inclusion principle.

The inclusion principle is not true for all processor types.

> Notwithstanding, feel free to add in a call to flush_cache_l1()
> (and I don't know whether you want to flush the i and d caches
> both, or just one), making sure there are no compile breakages.
> (the breakage that I fixed was due to the fact that there is no
> __flush_cache_all for mips64).

Sorry, that line leaked in from my private tree.

  Ralf
