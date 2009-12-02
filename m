Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 14:22:05 +0100 (CET)
Received: from sorrow.cyrius.com ([65.19.161.204]:46443 "EHLO
        sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492718AbZLBNWB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2009 14:22:01 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
        id DE73ED8C7; Wed,  2 Dec 2009 13:21:58 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
        id 90EF61501AB; Wed,  2 Dec 2009 13:21:48 +0000 (GMT)
Date:   Wed, 2 Dec 2009 13:21:47 +0000
From:   Martin Michlmayr <tbm@cyrius.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dave Airlie <airlied@linux.ie>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] DRM: Fix build error in include/drm/ttm/ttm_memory.h
Message-ID: <20091202132147.GM18101@deprecation.cyrius.com>
References: <20091202125651.GA19748@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091202125651.GA19748@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2009-12-02 12:56]:
> include/drm/ttm/ttm_memory.h uses struct page * without having included
> the required headers or a forward declaration resulting in the following
> build error for mtx1_defconfig on Linus' master branch, possibly others:

I sent such a patch several weeks ago but unfortunately it hasn't been
applied yet:
http://www.mail-archive.com/dri-devel@lists.sourceforge.net/msg44711.html

-- 
Martin Michlmayr
http://www.cyrius.com/
