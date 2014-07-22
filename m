Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 18:09:03 +0200 (CEST)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:48882 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6862848AbaGVOdXaDbHf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 16:33:23 +0200
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id EDA4E462A92;
        Tue, 22 Jul 2014 15:33:17 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l3Kl7h5TzFNW; Tue, 22 Jul 2014 15:33:15 +0100 (BST)
Received: from humdrum (unknown [10.24.1.221])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 34ABA462677;
        Tue, 22 Jul 2014 15:33:15 +0100 (BST)
Date:   Tue, 22 Jul 2014 15:33:12 +0100
From:   Rob Kendrick <rob.kendrick@codethink.co.uk>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: EdgeRouter Pro supported?  Strange FP problems
Message-ID: <20140722143311.GK30723@humdrum>
References: <20140722130616.GJ30723@humdrum>
 <53CE736E.1060009@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53CE736E.1060009@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <rob.kendrick@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob.kendrick@codethink.co.uk
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

On Tue, Jul 22, 2014 at 03:21:34PM +0100, Markos Chandras wrote:
> On 07/22/2014 02:06 PM, Rob Kendrick wrote:
> 
> When you say "master from linux-mti" I presume you mean this tree:
> 
> http://git.linux-mips.org/?p=linux-mti.git;a=shortlog;h=refs/heads/master
> 
> right?

Correct.

> What FPU problem are you seeing exactly? Could you show us a log for the
> failure? Can you post a simple test case which will allow someone to
> reproduce it?

A strange problem with awk (substr() doesn't work in either gawk or
mawk).  I've tried binaries of awk that I've built myself, and binaries
from Debian.  They all fail with my kernel, work fine with the 3.4
kernel (with a load of Cavium patches) that ship with the EdgeRouter
Pro.

I can see it with this awk script:

{
  line = $ 0
  prefix = substr(line, 1, 3)
  suffix = substr(line, 9)
  print "prefix is '" prefix "'"
  print "suffix is '" suffix "'"
}

execute with `echo "foo bar baz" | awk -f test.awk`.  With gawk, I get
both outputs being "foo bar baz" and with mawk "".  Correct answers
occur when using the shipped 3.4.

When you run gawk in linting mode, you get amusing errors like:
	warning: substr: length 3 too big for string indexing,
	truncating to 1.84467e+19

(Both are using doubles as internal representations, AFAICT.)

> (I am also surprised you have ethernet support since the ethernet
> support has not reached the mainline tree yet as far as I know
> https://git.kernel.org/cgit/linux/kernel/git/gregkh/staging.git/commit/?id=ec3a2207c322e518f7f42c80e54b8ecaf8a6f03e).

I was happily NFS-booting.  The activity LEDs don't work, the two
banks of four ports are identified in a different order, and it
complains about the board type being unknown, but otherwise it works.

-- 
Rob Kendrick, Senior Consulting Developer                Codethink Ltd.
Telephone: +44 7880 657 193              302 Ducie House, Ducie Street,
http://www.codethink.co.uk/         Manchester, M1 2JW, United Kingdom.
