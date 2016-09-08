Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2016 15:35:14 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:37156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990557AbcIHNfH3y0Nc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Sep 2016 15:35:07 +0200
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18B5761978;
        Thu,  8 Sep 2016 13:35:04 +0000 (UTC)
Received: from [10.36.112.47] (ovpn-112-47.ams2.redhat.com [10.36.112.47])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u88DZ0B9023919
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 8 Sep 2016 09:35:02 -0400
Subject: Re: [PATCH 0/2] MIPS: KVM: Partial EVA support
To:     James Hogan <james.hogan@imgtec.com>
References: <cover.4afb9d6281172d5a66d490da41c5ea418050dcea.1473335231.git-series.james.hogan@imgtec.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d95c50f-b9bd-49e0-9bca-71242d9d5efd@redhat.com>
Date:   Thu, 8 Sep 2016 15:34:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <cover.4afb9d6281172d5a66d490da41c5ea418050dcea.1473335231.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 08 Sep 2016 13:35:04 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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



On 08/09/2016 14:13, James Hogan wrote:
> These patches fix a couple of problems when using MIPS KVM on a host
> kernel with Enhanced Virtual Addressing (EVA) enabled.
> 
> Patch 1 fixes the HVA error codes like s390 does, due to PAGE_OFFSET
> potentially being as low as 0.
> 
> Patch 2 allows MMIO to be emulated from TLB refill exceptions as well as
> address error exceptions (since EVA configurations may make KSeg1
> addresses TLB mapped to user mode).
> 
> It isn't complete as there are still a couple of cases where KVM tries
> to directly access guest memory using normal loads and stores (which
> doesn't work with EVA's overlapping usermode & kernel mode address
> spaces). That really needs fixing properly anyway to handle the
> potential for TLB invalidations (and the resulting refills & page
> faults).
> 
> For KVM to work on EVA hosts also requires some MIPS architecture
> changes, as found in my recent "MIPS: General EVA fixes & cleanups"
> patchset.

Since there aren't any overlaps with 4.8 patches, feel free to send a
pull request for these and any other patches you might have in the rest
of this cycle.

Paolo
