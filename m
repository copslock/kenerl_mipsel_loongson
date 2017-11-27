Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Nov 2017 21:56:23 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:60602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990476AbdK0U4QT1mEk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Nov 2017 21:56:16 +0100
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1B58213A5F;
        Mon, 27 Nov 2017 20:56:09 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A55D17511;
        Mon, 27 Nov 2017 20:55:59 +0000 (UTC)
Subject: Re: [PATCH 01/15] KVM: Prepare for moving vcpu_load/vcpu_put into
 arch specific code
To:     Christoffer Dall <cdall@linaro.org>
Cc:     Christoffer Dall <christoffer.dall@linaro.org>,
        kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
 <20171125205718.7731-2-christoffer.dall@linaro.org>
 <838db374-6040-c805-82f3-187a2cdfc40d@redhat.com>
 <20171127195830.GB16941@cbox>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ef5e2cad-9db2-b216-85fd-d56aa8f51a53@redhat.com>
Date:   Mon, 27 Nov 2017 21:55:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171127195830.GB16941@cbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 27 Nov 2017 20:56:09 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61108
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

On 27/11/2017 20:58, Christoffer Dall wrote:
> Going back and looking, it's nicer to avoid the pid adjustment call, and
> having vcpu_load be void is also convenient, but we're stuck with the
> ifdef.  I guess I lean towards your suggestion as well, given that my
> problem with the ifdef is not a technical one, but an aesthetic one.

Same here, so I think we're in agreement.

Paolo
