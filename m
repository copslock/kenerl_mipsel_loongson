Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2014 17:22:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52648 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6901527AbaHNPWaFBSgZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Aug 2014 17:22:30 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7EFMSEA018082;
        Thu, 14 Aug 2014 17:22:28 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7EFMRJn018081;
        Thu, 14 Aug 2014 17:22:27 +0200
Date:   Thu, 14 Aug 2014 17:22:27 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Bug tracking system
Message-ID: <20140814152227.GB17617@linux-mips.org>
References: <20140814145558.GA17477@linux-mips.org>
 <53ECD126.7090103@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53ECD126.7090103@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42102
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

On Thu, Aug 14, 2014 at 04:09:26PM +0100, James Hogan wrote:

> On 14/08/14 15:55, Ralf Baechle wrote:
> > While I'm tinkering with the system - linux-mips.org still has no
> > bug tracking system to track bugs and so issues get forgotten also the
> > only system we have to track feature requests and other to-do items
> > currently is the to do page in the wiki.  But the wiki isn't the best
> > medium for this purpose.  So should we install something like bugzilla -
> > which I personally never liked - or other tracking system?  Suggestions?
> 
> If bugzilla is to be used, would it make sense to use the kernel.org
> bugzilla which already has a MIPS category, rather than setting up a new
> one?
> 
> https://bugzilla.kernel.org/buglist.cgi?product=Platform%20Specific%2FHardware&component=MIPS&resolution=---

Indeed why not.  Might even talk to the kernel.org admins to have it show
up as bugzilla.linux-mips.org or something like that.

I personally like the Debian bug tracking system but I'm not sure how
well it integrates with esotheric MTAs such as zmailer and how bad spam
issues would be.

  Ralf
