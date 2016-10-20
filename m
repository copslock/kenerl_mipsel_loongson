Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2016 19:53:36 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:37090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992279AbcJTRx3qjeDM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Oct 2016 19:53:29 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 527CCC056791;
        Thu, 20 Oct 2016 17:53:27 +0000 (UTC)
Received: from potion (dhcp-1-100.brq.redhat.com [10.34.1.100])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u9KHrOtC013969;
        Thu, 20 Oct 2016 13:53:24 -0400
Received: by potion (sSMTP sendmail emulation); Thu, 20 Oct 2016 19:53:23 +0200
Date:   Thu, 20 Oct 2016 19:53:23 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: MIPS: Add missing uaccess.h include
Message-ID: <20161020175323.GB8569@potion>
References: <d852b5f35e84e60c930589eeb14a6df21ea9b1cb.1476834183.git-series.james.hogan@imgtec.com>
 <20161020131054.GF8573@potion>
 <20161020131630.GL7370@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161020131630.GL7370@jhogan-linux.le.imgtec.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 20 Oct 2016 17:53:27 +0000 (UTC)
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55524
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

2016-10-20 14:16+0100, James Hogan:
> BTW, generally speaking do you always prefer pull requests to have the
> patches sent in reply to it, or only if they haven't already been posted
> for review?

I strongly prefer pull requests that include only patches that were
already posted on the list and slightly prefer to omit the patch
replies.

At least for me, a patch in a pull request has a FYI status instead of a
RFC status that a normal posting has.

[I'd like if all patches in pull requests were already (re)viewed by
 interested parties, so merge discussions could be high level or focus
 on things that we learned while/after applying the patches, hence there
 would be little benefit from reposting patches to the mailing list.]
