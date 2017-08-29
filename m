Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 13:24:11 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:51874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994929AbdH2LXyTaWk4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2017 13:23:54 +0200
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8FD24404318;
        Tue, 29 Aug 2017 11:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 8FD24404318
Authentication-Results: ext-mx09.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx09.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=cohuck@redhat.com
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 067D86FDDC;
        Tue, 29 Aug 2017 11:23:44 +0000 (UTC)
Date:   Tue, 29 Aug 2017 13:23:42 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Graf <agraf@suse.com>
Subject: Re: [PATCH RFC v3 1/9] KVM: s390: optimize detection of started
 vcpus
Message-ID: <20170829132342.1ef25500.cohuck@redhat.com>
In-Reply-To: <67a8b09c-3e7a-943d-8684-f9ad6e70514b@redhat.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
        <20170821203530.9266-2-rkrcmar@redhat.com>
        <67a8b09c-3e7a-943d-8684-f9ad6e70514b@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 29 Aug 2017 11:23:47 +0000 (UTC)
Return-Path: <cohuck@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cohuck@redhat.com
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

On Tue, 22 Aug 2017 13:31:27 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 21.08.2017 22:35, Radim Krčmář wrote:
> > We can add a variable instead of scanning all online VCPUs to know how
> > many are started.  We can't trivially tell which VCPU is the last one,
> > though.  
> 
> You could keep the started vcpus in a list. Then you might drop unsigned
> started_vcpus;
> 
> No started vcpus: Start pointer NULL
> Single started vcpu: Only one element in the list (easy to check)
> > 1 started vcpus: More than one element int he list (easy to check)  

I'm not sure the added complication of keeping a list buys us much
here: We only have the "look for the last vcpu not stopped" operation
for the 2->1 transition.
