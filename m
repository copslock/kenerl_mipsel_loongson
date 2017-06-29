Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2017 12:23:49 +0200 (CEST)
Received: from resqmta-ch2-04v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:36]:53894
        "EHLO resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992675AbdF2KXmNsHSJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jun 2017 12:23:42 +0200
Received: from resomta-ch2-01v.sys.comcast.net ([69.252.207.97])
        by resqmta-ch2-04v.sys.comcast.net with SMTP
        id QWbrdlStALhyoQWbrdQ2Pk; Thu, 29 Jun 2017 10:23:39 +0000
Received: from [192.168.1.13] ([73.201.189.102])
        by resomta-ch2-01v.sys.comcast.net with SMTP
        id QWbod4UAZWlw8QWbpdDRcp; Thu, 29 Jun 2017 10:23:39 +0000
Subject: Re: [PATCH V7 2/9] MIPS: c-r4k: Add r4k_blast_scache_node for
 Loongson-3
To:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>
References: <1498144016-9111-1-git-send-email-chenhc@lemote.com>
 <1498144016-9111-3-git-send-email-chenhc@lemote.com>
 <20170628143005.GJ31455@jhogan-linux.le.imgtec.org>
 <CAAhV-H7+0v0TE=V29DVYtEhxN2fUjVhh9MP9gNV96jzkq_1yrg@mail.gmail.com>
 <64E99F82-4E2B-4D53-8750-FCE90F84A29B@imgtec.com>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <dff97c4e-62aa-eacc-c1c9-16f824eda332@gentoo.org>
Date:   Thu, 29 Jun 2017 06:23:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <64E99F82-4E2B-4D53-8750-FCE90F84A29B@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGhNqXsIfT1Bg/IhkyDW2vBkAdd7X4rLncIMVX8vZkxe1UVSF84gecvB/jPPVcbY41mfu3I61k3LYKxNIiFQMweXsI59+ZnHwUcCUF4iQiAoYe7tlW81
 uyakYc6IEp7/JhKJTlJQb63BJdBI39R6bkY0kAkhVA/Dz5anWDg1V5SEMic1f5/rvt4dydJVA4boj9OoT4p/mOSkzme3AKoPcpwzKJpr/PhhNFofSZKYbfOz
 6WEmqx4O6dyOTpeaKFVllo58zY4xAS8P6mC2/efdb3pIOeSAxMvJAS0vyTyccT7Ud0fvKYu0V8HaXwhnP4hj6Zu97cKbwML20d3Pw+0PRvHqUjMakGOBXgOO
 A6eXPPB/T0ge9TEiAdJpo0ZHejg85u2QDUhXJ01LMxNqudPJ9/1rFgcuPEAwbtKxwL/Qg0fe
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 06/29/2017 01:46, James Hogan wrote:
> On 29 June 2017 02:33:28 BST, Huacai Chen <chenhc@lemote.com> wrote:
>> Hi, James,
>>
>> Is it suitable to add this line in arch/mips/include/asm/mmzone.h?
>> #define pa_to_nid(addr) 0
> 
> It was basically malta_defconfig.
> 
> OTOH when i tried including asm/mmzone.h, that tries including <mmzone.h> which it can't find.
> 
> Cheers
> Jamee
> 

<asm/mmzone.h> is only supposed to be defined for NUMA-aware systems, as far as
I can tell.  I believe a lot of the Loongson code derives somewhat from the
IP27 code, as both are the only MIPS platforms that define a specific version
of that header.

It also looks like the generic mmzone.h header probably just needs the
<mmzone.h> include removed.  pa_to_nid is only used for pfn_to_nid when
CONFIG_DISCONTIGMEM is set, and IP27 is one of the only platforms that uses
that memory model.

--J
