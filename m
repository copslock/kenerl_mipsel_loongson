Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2014 00:15:58 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:36786 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821116AbaABXPz0nLHc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jan 2014 00:15:55 +0100
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.95])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 46D58896;
        Thu,  2 Jan 2014 23:15:48 +0000 (UTC)
Date:   Thu, 2 Jan 2014 15:15:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Psychedelic Squid <psquid@psquid.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>, x86@kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ingo Molnar <mingo@redhat.com>, linux-mips@linux-mips.org,
        Hirokazu Takata <takata@linux-m32r.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-am33-list@redhat.com,
        linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-s390@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-m32r@ml.linux-m32r.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Paul Mundt <lethal@linux-sh.org>,
        linux-arm-kernel@lists.infradead.org,
        Matt Turner <mattst88@gmail.com>, linux390@de.ibm.com,
        Russell King <linux@arm.linux.org.uk>,
        linux-m32r-ja@ml.linux-m32r.org
Subject: Re: [PATCH] Slightly outdated CONFIG_SMP documentation fix
Message-Id: <20140102151547.fde4aa5855cc75e91fea95e5@linux-foundation.org>
In-Reply-To: <CAAJfVc7vK9W9Zy0LvGWSTWMSEb_JEx7FbLECy44QEwj+CWgSGg@mail.gmail.com>
References: <20131231225921.GA1624@sylph>
        <23596.1388674589@warthog.procyon.org.uk>
        <20140102150219.3df32a23cf7dbe9618ea118e@linux-foundation.org>
        <CAAJfVc7vK9W9Zy0LvGWSTWMSEb_JEx7FbLECy44QEwj+CWgSGg@mail.gmail.com>
X-Mailer: Sylpheed 3.2.0beta5 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38854
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

On Thu, 2 Jan 2014 23:08:43 +0000 Psychedelic Squid <psquid@psquid.net> wrote:

> On 2 Jan 2014 23:02, "Andrew Morton" <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 02 Jan 2014 14:56:29 +0000 David Howells <dhowells@redhat.com>
> wrote:
> >
> > > Robert Graffham <psquid@psquid.net> wrote:
> > >
> > > > +     singleprocessor machines. On a singleprocessor machine, the
> kernel
> > >
> > > "singleprocessor" looks wrong without a hyphen.  How about
> "uniprocessor"?
> > >
> >
> > Yes please.
> >
> > Also the patch should have a signed-off-by:, as per
> > Documentation/SubmittingPatches section 12, please.
> >
> 
> The signed-off-by: is already there.

ah, it was appended after the patch.  Don't do that ;)

> I'll get the other changes for the
> revised patch ready shortly, thanks. Also, newbie submitter and l couldn't
> find this in the documentation at a quick glance: should I submit it as a
> new thread, or a continuation of this?

Either is OK.  I tend to prefer continuation-of-this, mainly because it
prevents people from forgetting to cc people who were involved in
earlier discussion.

(Of course, if the discussion graph was complex, no reply-to-all will
capture all participants.  Nobody bothers to go through the discussion
gathering the names of all participants so I often end up doing this
when putting the final patch together)
