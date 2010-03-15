Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Mar 2010 19:50:51 +0100 (CET)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36884 "EHLO
        smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492530Ab0COSup (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Mar 2010 19:50:45 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
        by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2FIo5PO006541
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 15 Mar 2010 11:50:06 -0700
Received: from localhost (localhost [127.0.0.1])
        by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2FIo2N4016455;
        Mon, 15 Mar 2010 11:50:02 -0700
Date:   Mon, 15 Mar 2010 11:47:53 -0700 (PDT)
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Jiri Kosina <jkosina@suse.cz>
cc:     Wolfram Sang <w.sang@pengutronix.de>, linux-kernel@vger.kernel.org,
        Grant Likely <grant.likely@secretlab.ca>,
        kernel-janitors@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Gortmaker <p_gortmaker@yahoo.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-mips@linux-mips.org, rtc-linux@googlegroups.com
Subject: Re: [PATCH] init dynamic bin_attribute structures
In-Reply-To: <alpine.LRH.2.00.1003151055060.26353@twin.jikos.cz>
Message-ID: <alpine.LFD.2.00.1003151144550.18017@i5.linux-foundation.org>
References: <alpine.LFD.2.00.1003141054050.3719@i5.linux-foundation.org> <1268612981-9009-1-git-send-email-w.sang@pengutronix.de> <alpine.LRH.2.00.1003151055060.26353@twin.jikos.cz>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <torvalds@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
Precedence: bulk
X-list: linux-mips



On Mon, 15 Mar 2010, Jiri Kosina wrote:
> 
> I don't understand how cocinelle works, but the resulting patch seems to 
> be incomplete.
> 
> The fix is needed at least in firmware loader (for which Greg has already 
> queued patch), in ACPI thermal driver [1], etc).

The firmware loader should be done differently:

	http://patchwork.kernel.org/patch/84814/

and I suspect that Wolfram may have skipped the thermal one as having been 
done by another patch (that I didn't merge, due to having questions about 
the whole issue, but that I don't have any objections to)

But maybe there is also some limitation to the coccinelle rule too.

		Linus
