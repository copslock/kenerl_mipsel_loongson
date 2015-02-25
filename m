Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 19:20:58 +0100 (CET)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:50745 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007272AbbBYSU5MydnO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Feb 2015 19:20:57 +0100
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 618A6460887
        for <linux-mips@linux-mips.org>; Wed, 25 Feb 2015 18:20:51 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EyzJ-oYgSsA4 for <linux-mips@linux-mips.org>;
        Wed, 25 Feb 2015 18:20:49 +0000 (GMT)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 14E5046018F
        for <linux-mips@linux-mips.org>; Wed, 25 Feb 2015 18:20:49 +0000 (GMT)
Received: from [::1] (helo=paulmartin.codethink.co.uk)
        by pm-laptop.codethink.co.uk with esmtp (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1YQgZk-0007HC-GN
        for linux-mips@linux-mips.org; Wed, 25 Feb 2015 18:20:48 +0000
Date:   Wed, 25 Feb 2015 18:20:48 +0000
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Subject: 4.0-rc1 breakage in FPE?
Message-ID: <20150225182048.GC31062@paulmartin.codethink.co.uk>
Mail-Followup-To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.martin@codethink.co.uk
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

Some change between 3.19 and 4.0-rc1 has broken the FPE such that some
code running on an Octeon II is subtly not working.

eg.

  $ echo "1 2" | gawk '{ print $1 }'
  1 2

which should output (and does output on 3.19)

  $ echo "1 2" | gawk '{ print $1 }'
  1

I'm going to try bisecting this over the next few days.

We've been here before...

cf.  http://www.linux-mips.org/archives/linux-mips/2014-07/msg00431.html

-- 
Paul Martin                                  http://www.codethink.co.uk/
Senior Software Developer, Codethink Ltd.
