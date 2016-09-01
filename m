Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 17:24:43 +0200 (CEST)
Received: from smtprelay0095.hostedemail.com ([216.40.44.95]:34806 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992209AbcIAPYgKB4pN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 17:24:36 +0200
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id F17F112BA1C;
        Thu,  1 Sep 2016 15:24:32 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: badge72_4484ad1069214
X-Filterd-Recvd-Size: 2459
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (Authenticated sender: rostedt@goodmis.org)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Sep 2016 15:24:30 +0000 (UTC)
Date:   Thu, 1 Sep 2016 11:24:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] tracing/syscalls: allow multiple syscall numbers
 per syscall
Message-ID: <20160901112428.7c05dede@gandalf.local.home>
In-Reply-To: <5227283.eAVLXfitJh@wuerfel>
References: <1472463007-6469-1-git-send-email-marcin.nowakowski@imgtec.com>
        <20160830152955.17633511@gandalf.local.home>
        <CALCETrXA0XbYuqYzWMJA+KjFS31YL0cTVtrvCnmRY_GMK6oNpw@mail.gmail.com>
        <5227283.eAVLXfitJh@wuerfel>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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

On Wed, 31 Aug 2016 10:24:56 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday, August 30, 2016 12:53:53 PM CEST Andy Lutomirski wrote:
> > Egads!  OK, I see why this is a mess.
> > 
> > I guess we should be creating the metadata from the syscall tables
> > instead of from the syscall definitions, but I guess that's currently
> > a nasty per-arch mess.
> >   
> 
> I've been thinking for a while about how to improve the situation
> around adding new syscalls, which currently involves adding a number
> and an entry in a .S file on most architectures (some already have
> their own method to simplify it, and others using a shared table
> in asm-generic).
> 
> I was thinking of extending the x86 way of doing this to all
> architectures, and adding a way to have all future syscalls require
> only one addition in a single file that gets included by the
> architecture specific files for the existing syscalls.
> 
> Assuming we do this, would that work for generating the metadata
> from the same file like we do with
> arch/x86/entry/syscalls/syscall{tbl,hdr}.sh ?

I can't answer this because I'm not sure exactly how you would do this.
Perhaps you could give it a try and code will be the answer to all my
questions ;-)

-- Steve
