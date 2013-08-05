Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Aug 2013 15:18:35 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:15563 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823064Ab3HENSUGW5cT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Aug 2013 15:18:20 +0200
Message-ID: <51FFA5CD.3010406@imgtec.com>
Date:   Mon, 5 Aug 2013 14:17:01 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <kvm@vger.kernel.org>, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>, <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 1/3] mips/kvm: Improve code formatting in arch/mips/kvm/kvm_locore.S
References: <1375388555-4045-1-git-send-email-ddaney.cavm@gmail.com> <1375388555-4045-2-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1375388555-4045-2-git-send-email-ddaney.cavm@gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2013_08_05_14_18_14
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Hi David,

On 01/08/13 21:22, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> No code changes, just reflowing some comments and consistently using
> tabs and spaces.  Object code is verified to be unchanged.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>


> +   	 /* Put the saved pointer to vcpu (s1) back into the DDATA_LO Register */

git am detects a whitespace error here ("space before tab in indent").
It's got spaces before and after the tab actually.

>      /* load the guest context from VCPU and return */

this comment could have it's indentation fixed too

Otherwise, for all 3 patches:

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Thanks
James
