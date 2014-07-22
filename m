Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 19:32:55 +0200 (CEST)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:51934 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6862842AbaGVPt0Yg2Cw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 17:49:26 +0200
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id AFF234633A2;
        Tue, 22 Jul 2014 16:49:20 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7SnpVA22le+k; Tue, 22 Jul 2014 16:49:18 +0100 (BST)
Received: from humdrum (unknown [10.24.1.221])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 34409464D33;
        Tue, 22 Jul 2014 16:49:18 +0100 (BST)
Date:   Tue, 22 Jul 2014 16:49:14 +0100
From:   Rob Kendrick <rob.kendrick@codethink.co.uk>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: EdgeRouter Pro supported?  Strange FP problems
Message-ID: <20140722154914.GL30723@humdrum>
References: <20140722130616.GJ30723@humdrum>
 <53CE736E.1060009@imgtec.com>
 <20140722143311.GK30723@humdrum>
 <53CE8570.8020404@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53CE8570.8020404@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <rob.kendrick@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41471
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

On Tue, Jul 22, 2014 at 04:38:24PM +0100, Markos Chandras wrote:
> there have been quite a few FPU changes in 3.16. I am able to reproduce
> the problem on EdgeRouter (non pro) but the result is not the same as
> yours. The output using the 'gawk' is:
> 
> prefix is ''
> suffix is 'baz'

This is still, of course, wrong ;)  I'm glad somebody's managed to
reproduce it and it's not just madness on my part.

> a quick bisect between v3.15 and v3.16-rc1, which is the first tag with
> all the new FPU changes, leads to the following bad commit:
> 
> 08a07904e182895e1205f399465a3d622c0115b8
> MIPS: math-emu: Remove most ifdefery.
> 
> Reverting the commit is not trivial unfortunately. Perhaps you could use
> a v3.15 kernel for now (assuming it boots on that board) or perhaps use
> an earlier revision before this bad commit (eg
> 9e8bad1f9c0370b2635175b34d6151b90a53da5c, which boots and your test
> works for me)

I'll give it a whirl; I don't think 3.15 will boot at all on this
hardware, though.

Thanks for your help!
-- 
Rob Kendrick, Senior Consulting Developer                Codethink Ltd.
Telephone: +44 7880 657 193              302 Ducie House, Ducie Street,
http://www.codethink.co.uk/         Manchester, M1 2JW, United Kingdom.
