Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 17:31:02 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:42526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007636AbbCZQbBAMy6J (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Mar 2015 17:31:01 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2QGUgve029145
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Mar 2015 12:30:43 -0400
Received: from [10.36.112.86] (ovpn-112-86.ams2.redhat.com [10.36.112.86])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t2QGUb5X005435
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 26 Mar 2015 12:30:39 -0400
Message-ID: <5514342B.9040106@redhat.com>
Date:   Thu, 26 Mar 2015 17:30:35 +0100
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 00/20] MIPS: KVM: Guest FPU & SIMD (MSA) support
References: <1427386113-30515-1-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1427386113-30515-1-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46556
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



On 26/03/2015 17:08, James Hogan wrote:
> This patchset primarily adds guest Floating Point Unit (FPU) and MIPS
> SIMD Architecture (MSA) support to MIPS KVM, by enabling the host
> FPU/MSA while in guest mode.
> 
> This patchset depends on Paul Burton's FP/MSA fixes patchset, which will
> make it into 4.0. I've only included the 3 patches (15, 19, 20) that
> have changed since v1, which can be found here:
> http://thread.gmane.org/gmane.linux.kernel.api/8984

Thanks, the fixes look good.

Paolo
