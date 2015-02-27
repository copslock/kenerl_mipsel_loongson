Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 11:54:10 +0100 (CET)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:48730 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007566AbbB0KyIxQUv- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 11:54:08 +0100
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 6763E46053A
        for <linux-mips@linux-mips.org>; Fri, 27 Feb 2015 10:54:03 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kBcWSxFQ3NXj for <linux-mips@linux-mips.org>;
        Fri, 27 Feb 2015 10:54:00 +0000 (GMT)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 78929460056
        for <linux-mips@linux-mips.org>; Fri, 27 Feb 2015 10:54:00 +0000 (GMT)
Received: from [::1] (helo=paulmartin.codethink.co.uk)
        by pm-laptop.codethink.co.uk with esmtp (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1YRIYQ-0001KC-NK
        for linux-mips@linux-mips.org; Fri, 27 Feb 2015 10:53:58 +0000
Date:   Fri, 27 Feb 2015 10:53:58 +0000
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Subject: Re: 4.0-rc1 breakage in FPE?
Message-ID: <20150227105356.GA21678@paulmartin.codethink.co.uk>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20150225182048.GC31062@paulmartin.codethink.co.uk>
 <yw1xh9u97k5c.fsf@unicorn.mansr.com>
 <54EE4134.2050501@gmail.com>
 <yw1xsids6hcl.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xsids6hcl.fsf@unicorn.mansr.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46042
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

On Thu, Feb 26, 2015 at 11:29:46AM +0000, Måns Rullgård wrote:

> FYI, a fix (MIPS: asm: elf: Set O32 default FPU flags) has been posted
> to linux-mips.

I can confirm this fix does tame gawk.

-- 
Paul Martin                                  http://www.codethink.co.uk/
Senior Software Developer, Codethink Ltd.
