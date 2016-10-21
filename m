Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2016 20:52:46 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:33010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992544AbcJUSwj7UDtp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Oct 2016 20:52:39 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9B174A54D;
        Fri, 21 Oct 2016 18:52:32 +0000 (UTC)
Received: from potion (dhcp-1-100.brq.redhat.com [10.34.1.100])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u9LIqTPV021277;
        Fri, 21 Oct 2016 14:52:30 -0400
Received: by potion (sSMTP sendmail emulation); Fri, 21 Oct 2016 20:52:29 +0200
Date:   Fri, 21 Oct 2016 20:52:29 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: Re: [GIT PULL] MIPS KVM fix for v4.9-rc2
Message-ID: <20161021185228.GA25783@potion>
References: <1476971554-1215-1-git-send-email-james.hogan@imgtec.com>
 <20161020180449.GC8569@potion>
 <20161020192657.GN7370@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161020192657.GN7370@jhogan-linux.le.imgtec.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 21 Oct 2016 18:52:32 +0000 (UTC)
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkrcmar@redhat.com
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

2016-10-20 20:26+0100, James Hogan:
> What is the queue branch for?

It is a staging branch.  All patches applied by Paolo or me usually
start in kvm/queue.
Applying to kvm/queue means that we think that the patch is ok, but it
is by no means final -- the on-list review continues and we add r-b
tags, do minimal changes, or even drop patches according to feedback.
Patches are tested in kvm/queue before being included in a permanent
branch.
