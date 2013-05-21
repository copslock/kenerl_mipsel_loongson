Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 May 2013 18:28:32 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:56352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824104Ab3EUQ2WQlu6f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 May 2013 18:28:22 +0200
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4LGSDrc031030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 21 May 2013 12:28:13 -0400
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r4LGSCYR000911;
        Tue, 21 May 2013 12:28:12 -0400
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id B8EC01336CE; Tue, 21 May 2013 19:28:11 +0300 (IDT)
Date:   Tue, 21 May 2013 19:28:11 +0300
From:   Gleb Natapov <gleb@redhat.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, kvm@vger.kernel.org,
        Sanjay Lal <sanjayl@kymasys.com>, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v3 5/5] mips/kvm: Fix ABI by moving manipulation of CP0
 registers to KVM_{G,S}ET_MSRS
Message-ID: <20130521162811.GE14287@redhat.com>
References: <1369083686-27524-1-git-send-email-ddaney.cavm@gmail.com>
 <1369083686-27524-6-git-send-email-ddaney.cavm@gmail.com>
 <20130521153752.GD14287@redhat.com>
 <519B9EF2.8020107@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <519B9EF2.8020107@caviumnetworks.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Return-Path: <gleb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gleb@redhat.com
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

On Tue, May 21, 2013 at 09:21:06AM -0700, David Daney wrote:
> On 05/21/2013 08:37 AM, Gleb Natapov wrote:
> >On Mon, May 20, 2013 at 02:01:26PM -0700, David Daney wrote:
> >>From: David Daney <david.daney@cavium.com>
> >>
> >>Because not all 256 CP0 registers are ever implemented, we need a
> >>different method of manipulating them.  Use the
> >>KVM_GET_MSRS/KVM_SET_MSRS mechanism as x86 does for its MSRs.
> >>
> >Have you looked at KVM_(GET|SET)_ONE_REG interface (not used by x86, but is
> >used bu arm/ppc/s390). It looks like it is more suitable for your case.
> >Actually you can use it instead of KVM_(GET|SET)_REGS for all registers.
> 
> Yes, I suppose it could be used.  One problem it has is that there
> is no way to query the set of supported registers. 
KVM_GET_REG_LIST

>                                                     Also you have to
> make multiple calls to set multiple registers, which involves
> vcpu_{load,put} for each register.
> 
How often this happens on the fast path on mips? On x86 this never
happens on the fast path so it uses KVM_(GET|SET)_REGS mostly for
historical reasons.

> We will definitely implement it for all the FP and General Purpose
> registers.
> 
> >
> >>Code related to implementing KVM_GET_MSRS/KVM_SET_MSRS is consolidated
> 

--
			Gleb.
