Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Mar 2015 17:12:10 +0100 (CET)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:53495 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008633AbbC0QMIjm0DQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Mar 2015 17:12:08 +0100
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id EF86E460B21
        for <linux-mips@linux-mips.org>; Fri, 27 Mar 2015 16:12:03 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Bn5pIzSSdBN6 for <linux-mips@linux-mips.org>;
        Fri, 27 Mar 2015 16:12:01 +0000 (GMT)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id B66CA460A7F
        for <linux-mips@linux-mips.org>; Fri, 27 Mar 2015 16:12:01 +0000 (GMT)
Received: from localhost ([::1] helo=paulmartin.codethink.co.uk)
        by pm-laptop.codethink.co.uk with esmtp (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1YbWrZ-0001cT-6B
        for linux-mips@linux-mips.org; Fri, 27 Mar 2015 16:12:01 +0000
Date:   Fri, 27 Mar 2015 16:12:01 +0000
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/7] MIPS: OCTEON: Ensure CPUs come up little endian
Message-ID: <20150327161200.GB13870@paulmartin.codethink.co.uk>
Mail-Followup-To: linux-mips@linux-mips.org
References: <1426529923-13340-1-git-send-email-paul.martin@codethink.co.uk>
 <1426529923-13340-2-git-send-email-paul.martin@codethink.co.uk>
 <55073059.80505@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55073059.80505@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46569
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

On Mon, Mar 16, 2015 at 12:34:49PM -0700, David Daney wrote:
> On 03/16/2015 11:18 AM, Paul Martin wrote:

> >+#ifdef CONFIG_CPU_LITTLE_ENDIAN
> >+	.set push
> >+	.set noreorder
> >+	/* Hotplugged CPUs enter in Big-Endian mode, switch here to LE */
> >+	dmfc0   v0, CP0_CVMCTL_REG
> >+	nop
> >+	ori     v0, v0, 2
> >+	nop
> >+	dmtc0   v0, CP0_CVMCTL_REG	/* little-endian */
> >+	nop
> >+	synci	0($0)
> >+	.set pop
> >+#endif /* CONFIG_CPU_LITTLE_ENDIAN */
> 
> ... This code in the #ifdef CONFIG_CPU_LITTLE_ENDIAN block is useless and
> should be removed.

Can you confirm that the bootloader always sets all the Octeon's cores
to little-endian mode, and not just the first one?

I assume that by "useless" you meant that the above code is a null
operation as the bootloader has already set the cores up correctly.

I can now confirm that the Octeon's USB and Ethernet interfaces need
changes above and beyond the three patch set that was posted here
earlier this week.

-- 
Paul Martin                                  http://www.codethink.co.uk/
Senior Software Developer, Codethink Ltd.
