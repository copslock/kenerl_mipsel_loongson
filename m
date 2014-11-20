Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2014 12:48:38 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42760 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014086AbaKTLsfEHg8R (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Nov 2014 12:48:35 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAKBmWsg002781;
        Thu, 20 Nov 2014 12:48:32 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAKBmVNx002780;
        Thu, 20 Nov 2014 12:48:31 +0100
Date:   Thu, 20 Nov 2014 12:48:31 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: MIPS: Pull request
Message-ID: <20141120114831.GA21620@linux-mips.org>
References: <20141119192214.GH8625@linux-mips.org>
 <CAAhV-H7Rshve6S6Wz0B-MuSmLBbM7LKTOJN07i99wcq=VjDJfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H7Rshve6S6Wz0B-MuSmLBbM7LKTOJN07i99wcq=VjDJfA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44318
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

On Thu, Nov 20, 2014 at 09:15:36AM +0800, Huacai Chen wrote:

> Hi, Ralf,
> 
> It seems like this patch is missing during rebase:
>  MIPS: Fix a copy & paste error in unistd.h

I didn't rebase - I think I may have fallen victim to a stg bug a few days
ago.  Several other commits also got dropped as by the same incident.  I've
resurrected them but that's for another pull request.

  Ralf
