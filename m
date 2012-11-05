Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2012 00:33:48 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:43329 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825986Ab2KEXdr2rjsJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Nov 2012 00:33:47 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qA5NXc1u009762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 5 Nov 2012 18:33:38 -0500
Received: from [10.3.112.32] (ovpn-112-32.phx2.redhat.com [10.3.112.32])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id qA5NXRsA026687;
        Mon, 5 Nov 2012 18:33:29 -0500
Message-ID: <50984D6E.60205@redhat.com>
Date:   Mon, 05 Nov 2012 18:36:14 -0500
From:   Rik van Riel <riel@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121009 Thunderbird/16.0
MIME-Version: 1.0
To:     Michel Lespinasse <walken@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>, x86@kernel.org,
        William Irwin <wli@holomorphy.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 13/16] mm: use vm_unmapped_area() on sparc64 architecture
References: <1352155633-8648-1-git-send-email-walken@google.com> <1352155633-8648-14-git-send-email-walken@google.com>
In-Reply-To: <1352155633-8648-14-git-send-email-walken@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-archive-position: 34893
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

On 11/05/2012 05:47 PM, Michel Lespinasse wrote:
> Update the sparc64 arch_get_unmapped_area[_topdown] functions to make
> use of vm_unmapped_area() instead of implementing a brute force search.
>
> Signed-off-by: Michel Lespinasse <walken@google.com>

Reviewed-by: Rik van Riel <riel@redhat.com>
