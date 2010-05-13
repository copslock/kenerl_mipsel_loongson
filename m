Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 May 2010 18:14:06 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47986 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491947Ab0EMQOD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 May 2010 18:14:03 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4DGDwlM010491;
        Thu, 13 May 2010 17:14:00 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4DGDv9a010488;
        Thu, 13 May 2010 17:13:57 +0100
Date:   Thu, 13 May 2010 17:13:57 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.s.daney@gmail.com>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 9/9] tracing: MIPS: cleanup of the address space checking
Message-ID: <20100513161357.GA5810@linux-mips.org>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
 <86404e31ca5c4c33b785bad7f6223ac775f4f879.1273669419.git.wuzhangjin@gmail.com>
 <4BEAE19D.40502@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BEAE19D.40502@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 12, 2010 at 10:13:01AM -0700, David Daney wrote:

> The kernel is always compiled with -msym32, so the patch is a bit pointless.

Not quite true.  Some systems only have enough memory for the exception
vectors in the low 512MB of physical address space, so these can't use
an -msym32 kernel.

My general impression is that hardware designers "design" address maps by
throwing darts over their shoulder after a few pints ;-)

  Ralf
