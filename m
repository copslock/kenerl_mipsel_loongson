Received:  by oss.sgi.com id <S42415AbQIFXpw>;
	Wed, 6 Sep 2000 16:45:52 -0700
Received: from u-48.karlsruhe.ipdial.viaginterkom.de ([62.180.20.48]:47364
        "EHLO u-48.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42230AbQIFXpk>; Wed, 6 Sep 2000 16:45:40 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868990AbQIFXpV>;
        Thu, 7 Sep 2000 01:45:21 +0200
Date:   Thu, 7 Sep 2000 01:45:21 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Kanoj Sarcar <kanoj@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20000907014521.A20605@bacchus.dhis.org>
References: <20000906233636Z42230-31375+649@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000906233636Z42230-31375+649@oss.sgi.com>; from kanoj@oss.sgi.com on Wed, Sep 06, 2000 at 04:36:29PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Sep 06, 2000 at 04:36:29PM -0700, Kanoj Sarcar wrote:

> 	Compile fix: flush only L2 cache.

That's wrong, sysmips(FLUSH_CACHE) is supposed to flush all caches.

  Ralf
