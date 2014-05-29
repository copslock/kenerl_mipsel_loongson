Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 12:37:35 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:44666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817294AbaE2KhcvIco4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 May 2014 12:37:32 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4TAaGox027702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 May 2014 06:36:16 -0400
Received: from yakj.usersys.redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s4TAaBe8026101;
        Thu, 29 May 2014 06:36:12 -0400
Message-ID: <53870D99.3030900@redhat.com>
Date:   Thu, 29 May 2014 12:36:09 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH v2 11/23] MIPS: KVM: Fix timer race modifying guest CP0_Cause
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com> <1401355005-20370-12-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1401355005-20370-12-git-send-email-james.hogan@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40350
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
> Currently this is the only asynchronous modification of guest registers,
> therefore it is fixed by adjusting the implementations of the
> kvm_set_c0_guest_cause(), kvm_clear_c0_guest_cause(), and
> kvm_change_c0_guest_cause() macros which are used for modifying the
> guest CP0_Cause register to use ll/sc to ensure atomic modification.

Shouldn't you have a loop too around the ll/sc?

Paolo
