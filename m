Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2014 21:29:35 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:63079 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824283AbaAUU3dzdq2i (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Jan 2014 21:29:33 +0100
Message-ID: <52DED891.60301@imgtec.com>
Date:   Tue, 21 Jan 2014 14:29:05 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     <linux-arch@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Deng-Cheng Zhu <Dengcheng.Zhu@imgtec.com>
Subject: Re: [RFC][PATCH] MIPS: VPE: Remove vpe_getuid and vpe_getgid
References: <8738kh6usi.fsf@xmission.com>
In-Reply-To: <8738kh6usi.fsf@xmission.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.69]
X-SEF-Processed: 7_3_0_01192__2014_01_21_20_29_28
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

On 01/21/2014 12:42 PM, Eric W. Biederman wrote:
>
> The linux build-bot recently reported a build error in arch/mips/kernel/vpe.c
>
>       tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus
>       head:   261000a56b6382f597bcb12000f55c9ff26a1efb
>       commit: 261000a56b6382f597bcb12000f55c9ff26a1efb [4/4] userns:  userns: Remove UIDGID_STRICT_TYPE_CHECKS
>       config: make ARCH=mips maltaaprp_defconfig
>
>       All error/warnings:
>
>          arch/mips/kernel/vpe.c: In function 'vpe_open':
>       >> arch/mips/kernel/vpe.c:1086:9: error: incompatible types when assigning to type 'unsigned int' from type 'kuid_t'
>       >> arch/mips/kernel/vpe.c:1087:9: error: incompatible types when assigning to type 'unsigned int' from type 'kgid_t'
>
>       vim +1086 arch/mips/kernel/vpe.c
>
>       863abad4 Jesper Juhl   2010-10-30  1080			return -ENOMEM;
>       863abad4 Jesper Juhl   2010-10-30  1081  		}
>       e01402b1 Ralf Baechle  2005-07-14  1082  		v->plen = P_SIZE;
>       e01402b1 Ralf Baechle  2005-07-14  1083  		v->load_addr = NULL;
>       e01402b1 Ralf Baechle  2005-07-14  1084  		v->len = 0;
>       e01402b1 Ralf Baechle  2005-07-14  1085
>       d76b0d9b David Howells 2008-11-14 @1086		v->uid = filp->f_cred->fsuid;
>       d76b0d9b David Howells 2008-11-14 @1087  		v->gid = filp->f_cred->fsgid;
>       2600990e Ralf Baechle  2006-04-05  1088
>       2600990e Ralf Baechle  2006-04-05  1089		v->cwd[0] = 0;
>       2600990e Ralf Baechle  2006-04-05  1090 	 	ret = getcwd(v->cwd, VPE_PATH_MAX);
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
