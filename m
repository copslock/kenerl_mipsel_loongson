Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2012 16:27:05 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:38339 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819780Ab2KAP1A5dHKH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Nov 2012 16:27:00 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qA1FPAjq018878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 1 Nov 2012 11:26:57 -0400
Received: from balrog.usersys.tlv.redhat.com (dhcp-4-121.tlv.redhat.com [10.35.4.121])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id qA1FOTtp019531;
        Thu, 1 Nov 2012 11:24:30 -0400
Message-ID: <5092942C.4080402@redhat.com>
Date:   Thu, 01 Nov 2012 17:24:28 +0200
From:   Avi Kivity <avi@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 07/20] KVM/MIPS32: Dynamic binary translation of select
  privileged instructions.
References: <3E678B37-B4C1-409F-A1CB-A7CC83B2D874@kymasys.com>
In-Reply-To: <3E678B37-B4C1-409F-A1CB-A7CC83B2D874@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-archive-position: 34846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: avi@redhat.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 10/31/2012 05:19 PM, Sanjay Lal wrote:
> Currently, the following instructions are translated:
> - CACHE (indexed)
> - CACHE (va based): translated to a synci, overkill on D-CACHE operations, but still much faster than a trap.
> - mfc0/mtc0: the virtual COP0 registers for the guest are implemented as 2-D array
>   [COP#][SEL] and this is mapped into the guest kernel address space @ VA 0x0.
>   mfc0/mtc0 operations are transformed to load/stores.
> 

Seems to be more of binary patching, yes?  Binary translation usually
involves hiding the translated code so the guest is not able to detect
that it is patched.


-- 
error compiling committee.c: too many arguments to function
