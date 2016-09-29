Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Sep 2016 16:47:29 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:52188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991344AbcI2OrXAPmLf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Sep 2016 16:47:23 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B4197CDE2;
        Thu, 29 Sep 2016 14:47:16 +0000 (UTC)
Received: from potion (dhcp-1-247.brq.redhat.com [10.34.1.247])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u8TElDY2002555;
        Thu, 29 Sep 2016 10:47:13 -0400
Received: by potion (sSMTP sendmail emulation); Thu, 29 Sep 2016 16:47:12 +0200
Date:   Thu, 29 Sep 2016 16:47:12 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: Re: [GIT PULL 0/6] KVM: MIPS: Updates for v4.9
Message-ID: <20160929144712.GC24662@potion>
References: <1475151193-28505-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475151193-28505-1-git-send-email-james.hogan@imgtec.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 29 Sep 2016 14:47:16 +0000 (UTC)
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55299
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

2016-09-29 13:13+0100, James Hogan:
> Hi Paolo, Radim,
> 
> The following changes since commit fa8410b355251fd30341662a40ac6b22d3e38468:
> 
>   Linux 4.8-rc3 (2016-08-21 16:14:10 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/kvm-mips.git tags/kvm_mips_4.9_1
> 
> for you to fetch changes up to bf18db4e7bd99f3a65bcc43225790b16af733321:
> 
>   KVM: MIPS: Drop dubious EntryHi optimisation (2016-09-29 12:40:12 +0100)
> 
> Thanks
> James
> 
> ----------------------------------------------------------------
> MIPS KVM updates for v4.9
> 
> - A couple of fixes in preparation for supporting MIPS EVA host kernels.
> - MIPS SMP host & TLB invalidation fixes.

Pulled to kvm/next, thanks.
