Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2012 23:45:47 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:2997 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826037Ab2KFWpqN6W3P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Nov 2012 23:45:46 +0100
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qA6MjUWE010676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 6 Nov 2012 17:45:30 -0500
Received: from [10.3.112.37] (ovpn-112-37.phx2.redhat.com [10.3.112.37])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id qA6MjKeu024703;
        Tue, 6 Nov 2012 17:45:21 -0500
Message-ID: <509993A5.2000605@redhat.com>
Date:   Tue, 06 Nov 2012 17:48:05 -0500
From:   Rik van Riel <riel@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121009 Thunderbird/16.0
MIME-Version: 1.0
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Michel Lespinasse <walken@google.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>, x86@kernel.org,
        William Irwin <wli@holomorphy.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 09/16] mm: use vm_unmapped_area() in hugetlbfs on i386
 architecture
References: <1352155633-8648-1-git-send-email-walken@google.com> <1352155633-8648-10-git-send-email-walken@google.com> <20121106143826.dc3b960c.akpm@linux-foundation.org>
In-Reply-To: <20121106143826.dc3b960c.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-archive-position: 34913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: riel@redhat.com
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

On 11/06/2012 05:38 PM, Andrew Morton wrote:
> On Mon,  5 Nov 2012 14:47:06 -0800
> Michel Lespinasse <walken@google.com> wrote:
>
>> Update the i386 hugetlb_get_unmapped_area function to make use of
>> vm_unmapped_area() instead of implementing a brute force search.
>
> The x86_64 coloring "fix" wasn't copied into i386?

Only certain 64 bit AMD CPUs have that issue at all.

On x86, page coloring is really not much of an issue.

All the x86-64 patch does is make the x86-64 page
coloring code behave the same way page coloring
does on MIPS, SPARC, ARM, PA-RISC and others...
