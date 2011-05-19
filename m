Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2011 17:15:20 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36381 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491053Ab1ESPPS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 May 2011 17:15:18 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4JFFGTg012394;
        Thu, 19 May 2011 16:15:16 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4JFFEmq012390;
        Thu, 19 May 2011 16:15:14 +0100
Date:   Thu, 19 May 2011 16:15:14 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     dediao@cisco.com, ddaney@caviumnetworks.com, dvomlehn@cisco.com,
        sshtylyov@mvista.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] MIPS: HIGHMEM DMA on noncoherent MIPS32 processors
Message-ID: <20110519151514.GA11887@linux-mips.org>
References: <002fbbeb01a5a51fff8015af85d5d101@localhost>
 <20110519110638.GA11371@linux-mips.org>
 <BANLkTikouHA-Owkqji5W4sYdZ2nFrT_==g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BANLkTikouHA-Owkqji5W4sYdZ2nFrT_==g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 19, 2011 at 08:05:24AM -0700, Kevin Cernekee wrote:

> On Thu, May 19, 2011 at 4:06 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Who is the author of this patch, you or Dezhong Diao?
> 
> The author is Dezhong... I should have added the extra "From:" header.

Thanks.  I fixed up the author attribution and queued the patch for 2.6.41.

  Ralf
