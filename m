Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 12:37:53 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:9933 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822268AbaE2Khsj75oN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 May 2014 12:37:48 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4TAaaQi012264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 May 2014 06:36:36 -0400
Received: from yakj.usersys.redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s4TAaUA6014314;
        Thu, 29 May 2014 06:36:31 -0400
Message-ID: <53870DAD.7050900@redhat.com>
Date:   Thu, 29 May 2014 12:36:29 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH v2 00/23] MIPS: KVM: Fixes and guest timer rewrite
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40351
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

Il 29/05/2014 11:16, James Hogan ha scritto:
> Here are a range of MIPS KVM T&E fixes, preferably for v3.16 but I know
> it's probably a bit late now. Changes are pretty minimal though since
> v1 so please consider. They can also be found on my kvm_mips_queue
> branch (and the kvm_mips_timer_v2 tag) here:
> git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/kvm-mips.git

That's okay for me, but I'd like to get a look at the QEMU parts.

I would also like an Acked-by for patches 2 and 14, and I have a 
question about patch 11.

Paolo
