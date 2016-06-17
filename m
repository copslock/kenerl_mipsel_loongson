Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 17:36:04 +0200 (CEST)
Received: from smtprelay0040.hostedemail.com ([216.40.44.40]:36876 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27042843AbcFQPgDCmVOf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jun 2016 17:36:03 +0200
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id CB7CB9EA14;
        Fri, 17 Jun 2016 15:36:01 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: power38_6eb21a0d6d739
X-Filterd-Recvd-Size: 1712
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (Authenticated sender: rostedt@goodmis.org)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Jun 2016 15:36:00 +0000 (UTC)
Date:   Fri, 17 Jun 2016 11:35:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 5/8] MIPS: KVM: Add guest mode switch trace events
Message-ID: <20160617113559.74f8146e@gandalf.local.home>
In-Reply-To: <20160617145819.GN30921@jhogan-linux.le.imgtec.org>
References: <1465893617-5774-1-git-send-email-james.hogan@imgtec.com>
        <1465893617-5774-6-git-send-email-james.hogan@imgtec.com>
        <20160617100848.4a91b313@gandalf.local.home>
        <1b6e9e4e-3cbb-9c6e-bfa7-390f8a4f8d24@redhat.com>
        <20160617145819.GN30921@jhogan-linux.le.imgtec.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54103
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

On Fri, 17 Jun 2016 15:58:19 +0100
James Hogan <james.hogan@imgtec.com> wrote:


> > > Please combine the above TRACE_EVENT()s to use a single
> > > DECLARE_EVENT_CLASS() and three DEFINE_EVENT()s.  
> 
> Oh, neat. I did wonder if there was a nicer way to do that. Thanks!

It also saves on duplicate code, and keeps the bloat down a bit.

> 
> > 
> > James,
> > 
> > I've committed the patch already, so please send a follow up.  
> 
> Will do,
> 

Great.

Thanks,

-- Steve
