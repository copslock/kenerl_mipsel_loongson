Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 11:59:45 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:40066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992213AbdCBK7iN2elE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Mar 2017 11:59:38 +0100
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3472E3B720;
        Thu,  2 Mar 2017 10:59:32 +0000 (UTC)
Received: from [10.36.116.174] (ovpn-116-174.ams2.redhat.com [10.36.116.174])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v22AxTHM021970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 2 Mar 2017 05:59:30 -0500
Subject: Re: [PATCH 11/32] KVM: MIPS: Add VZ capability
To:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
 <17827db14f848b69e8184ae80b5d63ba01b4b106.1488447004.git-series.james.hogan@imgtec.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb40a6bb-e6b3-a37b-a08e-daccbf52bbef@redhat.com>
Date:   Thu, 2 Mar 2017 11:59:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <17827db14f848b69e8184ae80b5d63ba01b4b106.1488447004.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 02 Mar 2017 10:59:32 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56994
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



On 02/03/2017 10:36, James Hogan wrote:
>  - KVM_VM_MIPS_DEFAULT = 2
> 
>    This will provide the best available KVM implementation (even on
>    older kernels), preferring hardware assisted virtualization over trap
>    & emulate. The KVM_CAP_MIPS_VZ capability should always be checked
>    against known values to determine what type of implementation was
>    chosen.
> 
> This is designed to allow the desired implementation (T&E vs VZ) to be
> potentially chosen at runtime rather than being fixed in the kernel
> configuration.

Can the same kernel run on both TE and VZ?  If not, I'm not sure that
KVM_VM_MIPS_DEFAULT is a good idea.

Paolo
