Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jan 2014 23:14:25 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:59302 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827305AbaAVWOVm3Krm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Jan 2014 23:14:21 +0100
Message-ID: <52E042AB.30802@imgtec.com>
Date:   Wed, 22 Jan 2014 14:14:03 -0800
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
CC:     <linux-arch@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [RFC][PATCH] MIPS: VPE: Remove vpe_getuid and vpe_getgid
References: <8738kh6usi.fsf@xmission.com> <52DED891.60301@imgtec.com>
In-Reply-To: <52DED891.60301@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.136.61]
X-SEF-Processed: 7_3_0_01192__2014_01_22_22_14_16
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

This is a good catch. vpe_get[u|g]id was originally used by KSPD which has 
been removed.

Reviewed-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>


Deng-Cheng

---------------------------------------------------------------------------

*From:* Steven J. Hill <mailto:Steven.Hill@imgtec.com>
*Sent:* Tuesday, January 21, 2014 12:29PM
*To:* Eric W. Biederman <mailto:ebiederm@xmission.com>
*Cc:* linux-arch <mailto:linux-arch@vger.kernel.org>, linux-mips 
<mailto:linux-mips@linux-mips.org>, Deng-Cheng Zhu 
<mailto:Dengcheng.Zhu@imgtec.com>
*Subject:* Re: [RFC][PATCH] MIPS: VPE: Remove vpe_getuid and vpe_getgid

On 01/21/2014 12:42 PM, Eric W. Biederman wrote:
>
> The linux build-bot recently reported a build error in 
> arch/mips/kernel/vpe.c
>
>       tree: 
> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git 
> for-linus
>       head:   261000a56b6382f597bcb12000f55c9ff26a1efb
>       commit: 261000a56b6382f597bcb12000f55c9ff26a1efb [4/4] userns:  
> userns: Remove UIDGID_STRICT_TYPE_CHECKS
>       config: make ARCH=mips maltaaprp_defconfig
>
>       All error/warnings:
>
>          arch/mips/kernel/vpe.c: In function 'vpe_open':
>       >> arch/mips/kernel/vpe.c:1086:9: error: incompatible types when 
> assigning to type 'unsigned int' from type 'kuid_t'
>       >> arch/mips/kernel/vpe.c:1087:9: error: incompatible types when 
> assigning to type 'unsigned int' from type 'kgid_t'
>
>       vim +1086 arch/mips/kernel/vpe.c
>
>       863abad4 Jesper Juhl   2010-10-30  1080            return -ENOMEM;
>       863abad4 Jesper Juhl   2010-10-30  1081          }
>       e01402b1 Ralf Baechle  2005-07-14  1082          v->plen = P_SIZE;
>       e01402b1 Ralf Baechle  2005-07-14  1083 v->load_addr = NULL;
>       e01402b1 Ralf Baechle  2005-07-14  1084          v->len = 0;
>       e01402b1 Ralf Baechle  2005-07-14  1085
>       d76b0d9b David Howells 2008-11-14 @1086        v->uid = 
> filp->f_cred->fsuid;
>       d76b0d9b David Howells 2008-11-14 @1087          v->gid = 
> filp->f_cred->fsgid;
>       2600990e Ralf Baechle  2006-04-05  1088
>       2600990e Ralf Baechle  2006-04-05  1089        v->cwd[0] = 0;
>       2600990e Ralf Baechle  2006-04-05  1090          ret = 
> getcwd(v->cwd, VPE_PATH_MAX);
>
> When examining the code to see what v->uid and v->gid were used for I
> discovered that the only users in the kernel are vpe_getuid and
> vpe_getgid, and that vpe_getuid and vpe_getgid are never called.
>
> So instead of proposing a conversion to use kuid_t and kgid_t instead
> of unsigned int/int as I normally would let's just kill this dead code
> so no one has to worry about it further.
>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
This patch looks good to me, however, Deng-Cheng should also confirm if 
this patch is okay. He is currently maintaining that code. Thanks.

Steve
