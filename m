Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2014 10:31:07 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:14102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860277AbaFQIVHC9IdA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jun 2014 10:21:07 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5H8L3BE010360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jun 2014 04:21:04 -0400
Received: from [10.36.5.8] (vpn1-5-8.ams2.redhat.com [10.36.5.8])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s5H8L0L1021046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Tue, 17 Jun 2014 04:21:01 -0400
Message-ID: <539FFA6B.9030004@redhat.com>
Date:   Tue, 17 Jun 2014 10:20:59 +0200
From:   Daniel Borkmann <dborkman@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexei Starovoitov <ast@plumgrid.com>
Subject: Re: mips:allmodconfig build failure in 3.16-rc1 due to bpf_jit code
References: <539FA6CB.5050703@roeck-us.net>
In-Reply-To: <539FA6CB.5050703@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <dborkman@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dborkman@redhat.com
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

On 06/17/2014 04:24 AM, Guenter Roeck wrote:
> mips:allmodconfig fails in 3.16-rc1 with lots of undefined symbols.
>
> arch/mips/net/bpf_jit.c: In function 'is_load_to_a':
> arch/mips/net/bpf_jit.c:559:7: error: 'BPF_S_LD_W_LEN' undeclared (first use in this function)
> arch/mips/net/bpf_jit.c:559:7: note: each undeclared identifier is reported only once for each function it appears in
> arch/mips/net/bpf_jit.c:560:7: error: 'BPF_S_LD_W_ABS' undeclared (first use in this function)
> arch/mips/net/bpf_jit.c:561:7: error: 'BPF_S_LD_H_ABS' undeclared (first use in this function)
> arch/mips/net/bpf_jit.c:562:7: error: 'BPF_S_LD_B_ABS' undeclared (first use in this function)
> arch/mips/net/bpf_jit.c:563:7: error: 'BPF_S_ANC_CPU' undeclared (first use in this function)
> arch/mips/net/bpf_jit.c:564:7: error: 'BPF_S_ANC_IFINDEX' undeclared (first use in this function)
> arch/mips/net/bpf_jit.c:565:7: error: 'BPF_S_ANC_MARK' undeclared (first use in this function)
>
> and so on.
>
> Those symbols are not defined anywhere.
>
> The problem is due to a conflict with commit 348059313 (net: filter: get rid of BPF_S_*
> enum), which removed those definitions.

Yep, it seems both got in this merge window from different trees. Don't have mips, but
I'll have a look, and send you a patch.
