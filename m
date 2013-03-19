Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Mar 2013 19:19:37 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50819 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6834890Ab3CSSTcGqUxJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Mar 2013 19:19:32 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r2JIJUv5010666;
        Tue, 19 Mar 2013 19:19:31 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r2JIJRlS010659;
        Tue, 19 Mar 2013 19:19:27 +0100
Date:   Tue, 19 Mar 2013 19:19:27 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix breakage in MIPS siginfo handling
Message-ID: <20130319181927.GA10535@linux-mips.org>
References: <20130319150053.32135.61438.stgit@warthog.procyon.org.uk>
 <20130319150530.GH21522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130319150530.GH21522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35914
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Mar 19, 2013 at 03:05:30PM +0000, Al Viro wrote:

> ACKed-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> but I think it should go via mips tree (or straight to Linus, for that
> matter).  I can apply it in signal.git and push it to Linus today, though...

I've applied it to my tree.  Since I applied a number of other 3.9 fixes
I'm going to wait for another day before sending out a pull request to
Linus.

Thanks,

  Ralf
