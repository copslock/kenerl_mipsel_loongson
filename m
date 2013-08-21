Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 14:07:24 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42458 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6832092Ab3HULNP2toIy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Aug 2013 13:13:15 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r7LBD9uU032193;
        Wed, 21 Aug 2013 13:13:09 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r7LBCqT8032154;
        Wed, 21 Aug 2013 13:12:52 +0200
Date:   Wed, 21 Aug 2013 13:12:51 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: [ADMIN] Gmail mail issue
Message-ID: <20130821111251.GB5399@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37618
X-Approved-By: ralf@linux-mips.org
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

Recently Google rolled out an update to the SMTP software which due to a
bug, was not able to correctly interoperat with Zmailer, the mailer daemon
being used on linux-mips.org.  Due to the resulting bounces all users of
gmail (including other domains that funnel their email through Google's
SMTP servers) got unsubscribed on Saturday, August 17.

To give you an idea of the order of issue, about 44% of the subscribers
of the linux-mips mailing list got unsubscribed.

I've resubscribed all users based on log files.  There were a bunch of
postings between the 17th and now but those got archived in the linux-mips
mailing list's archive.

The only thing I was able to restore is the subscription status but not
the Ecartis password or any options.  If you need the password, please
follow the "lost password" procedure, that is go to

  http://www.linux-mips.org/ecartis

enter your email address, leave the password empty and click on the
"click here to Log in" button and follow the instructions in the email
that will be mailed to you.

  Ralf
