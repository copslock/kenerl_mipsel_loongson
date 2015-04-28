Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 16:12:56 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:48350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026211AbbD1OMywGoIg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Apr 2015 16:12:54 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3SEClh8032657
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Apr 2015 10:12:48 -0400
Received: from [10.36.112.80] (ovpn-112-80.ams2.redhat.com [10.36.112.80])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3SECfoQ016376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 28 Apr 2015 10:12:44 -0400
Message-ID: <553F955A.6050804@redhat.com>
Date:   Tue, 28 Apr 2015 16:12:42 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Christian Borntraeger <borntraeger@de.ibm.com>
CC:     KVM <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-mips@linux-mips.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH/RFC 2/2] KVM: push down irq_save from kvm_guest_exit
References: <1430217168-25504-1-git-send-email-borntraeger@de.ibm.com> <1430217168-25504-3-git-send-email-borntraeger@de.ibm.com> <553F70E9.50907@redhat.com> <553F94CF.2080409@de.ibm.com>
In-Reply-To: <553F94CF.2080409@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47134
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



On 28/04/2015 16:10, Christian Borntraeger wrote:
> > Alternatively, the irq-disabled versions could be called
> > __kvm_guest_{enter,exit}.  Then you can use those directly when it makes
> > sense.
>
> ..having a special  __kvm_guest_{enter,exit} without the WARN_ON might be even
> the cheapest way. In that way I could leave everything besides s390 alone and
> arch maintainers can do a followup patch if appropriate.

That's certainly fine with me.

Paolo
