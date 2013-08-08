Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 17:06:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:32832 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823002Ab3HHPGROkHiS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 17:06:17 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r78F6GbJ021530
        for <linux-mips@linux-mips.org>; Thu, 8 Aug 2013 17:06:16 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r78F6GsT021529
        for linux-mips@linux-mips.org; Thu, 8 Aug 2013 17:06:16 +0200
Date:   Thu, 8 Aug 2013 17:06:15 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: [ADMIN] spam filter of linux-mips
Message-ID: <20130808150615.GD2172@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37482
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

As you (hopefully have not) noticed the spam filter of the linux-mips
mailing list (and it appears also user accounts, depending on configuration)
has become a bit triggerhappy lately causing false positives - and the
recent update of that machine has changd that only marginally, if at all.

I feel that short of becoming a spamfilter developer I'm running out of
toggles and buttons to tune the filter to avoid false positives / negatives.
So if one your postings doesn't make it to the list contact me and I'll
approve the posting.

Loud rant at certain email providers, in particular Yahoo.  If your email
bounces during SMTP transfer there is no way for the list software to know
if that was because an email address got stale or because for some reason
the contest was inacceptable or maybe just too large.  Whatever the issue,
if the list robot sees more than a paricular number of bounces within a
certain time frame, it will unsubscribe users.  So for your spam filter
setup this just means if you don't like a posting, discard it locally,
don't bounce it.

  Ralf
