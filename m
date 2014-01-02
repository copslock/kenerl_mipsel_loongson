Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2014 00:04:10 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:36677 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825722AbaABXCtpYQEp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jan 2014 00:02:49 +0100
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.95])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 59B01523;
        Thu,  2 Jan 2014 23:02:20 +0000 (UTC)
Date:   Thu, 2 Jan 2014 15:02:19 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Robert Graffham <psquid@psquid.net>, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@arm.linux.org.uk>,
        Hirokazu Takata <takata@linux-m32r.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-m32r@ml.linux-m32r.org,
        linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
        linux-am33-list@redhat.com, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH] Slightly outdated CONFIG_SMP documentation fix
Message-Id: <20140102150219.3df32a23cf7dbe9618ea118e@linux-foundation.org>
In-Reply-To: <23596.1388674589@warthog.procyon.org.uk>
References: <20131231225921.GA1624@sylph>
        <23596.1388674589@warthog.procyon.org.uk>
X-Mailer: Sylpheed 3.2.0beta5 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Thu, 02 Jan 2014 14:56:29 +0000 David Howells <dhowells@redhat.com> wrote:

> Robert Graffham <psquid@psquid.net> wrote:
> 
> > +	  singleprocessor machines. On a singleprocessor machine, the kernel
> 
> "singleprocessor" looks wrong without a hyphen.  How about "uniprocessor"?
> 

Yes please.

Also the patch should have a signed-off-by:, as per
Documentation/SubmittingPatches section 12, please.
