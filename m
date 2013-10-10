Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Oct 2013 01:16:28 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:40489 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868768Ab3JJXQ0wnnpo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Oct 2013 01:16:26 +0200
Received: from localhost (c-76-28-172-123.hsd1.wa.comcast.net [76.28.172.123])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CEB9098E;
        Thu, 10 Oct 2013 23:16:18 +0000 (UTC)
Date:   Thu, 10 Oct 2013 16:16:17 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: stack protector: Fix per-task canary switch
Message-ID: <20131010231617.GI4301@kroah.com>
References: <1381144466-19736-1-git-send-email-james.hogan@imgtec.com>
 <20131007124859.GF3098@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131007124859.GF3098@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Mon, Oct 07, 2013 at 02:48:59PM +0200, Ralf Baechle wrote:
> On Mon, Oct 07, 2013 at 12:14:26PM +0100, James Hogan wrote:
> 
> > Ralf: This is a regression in v3.11, so please consider for v3.12.
> 
> Applied, will send to Linus with the next pull request.

Which would be in time for 3.12-final, right?

> stable folks - please apply to 3.12-stable.

There is no 3.12-stable yet, as 3.12-final isn't out yet.

Confused,

greg k-h
