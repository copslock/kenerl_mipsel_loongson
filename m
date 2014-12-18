Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 00:56:24 +0100 (CET)
Received: from resqmta-ch2-04v.sys.comcast.net ([69.252.207.36]:48900 "EHLO
        resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008199AbaLRX4VRu3Gc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 00:56:21 +0100
Received: from resomta-ch2-12v.sys.comcast.net ([69.252.207.108])
        by resqmta-ch2-04v.sys.comcast.net with comcast
        id VBvc1p0032LrikM01BwEQV; Thu, 18 Dec 2014 23:56:14 +0000
Received: from [192.168.1.13] ([76.100.35.31])
        by resomta-ch2-12v.sys.comcast.net with comcast
        id VBwD1p0090gJalY01BwDcm; Thu, 18 Dec 2014 23:56:14 +0000
Message-ID: <54936992.2070302@gentoo.org>
Date:   Thu, 18 Dec 2014 18:56:02 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH RFC 47/67] MIPS: kernel: branch: Prevent BEQL emulation
 for MIPS R6
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-48-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1418915416-3196-48-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1418946974;
        bh=TULUWwulhwTsko5wjiXY5LEOIin2acry8B8tikyHdGk=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=SAYBhnU2WqF6Plq3mrXgjgH2o6mCUcS5gDUyO0ae+cgEx52O5b1NDE5BZavIi04bT
         2QQvIsSt6iYx95Qr2nHjv43Ckpbl9D98V3QHHU2kO9qAz5oK+DqJsNISELJHElCcpU
         xw8V5Fu4eQaajmkI582aVFECFrHA/ISFPm804wKg8j7KsQJ35QqY1TsuRmEmwhLJx2
         VGg2Y2uFmxcEsXpFHk5iGw6u/wpDErecK04vT3dfd0IIgf2jnPgBoyj0sOLp6uNPar
         NbPZxUA+Y/bWHgYmV2Xac9A6ZnmM0bf5BOvcQC5voa7gPyYUvvjvnpqTW7zDTID86s
         XUcbkP4a12sJw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44822
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

On 12/18/2014 10:09, Markos Chandras wrote:
> MIPS R6 removed the BEQL instruction so do not try to emulate it
> if the R2-to-R6 emulator is not present.

How does this affect code for the old ISAs, MIPS-II to MIPS-IV?  I.e., the SGIs
and the R10K CPUs that have to worry about the R10000_LLSC_WAR workaround and
use branch-likely insns?

--J


> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  arch/mips/kernel/branch.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
> index 5f2a168c37fd..539d059ba4fb 100644
> --- a/arch/mips/kernel/branch.c
> +++ b/arch/mips/kernel/branch.c
> @@ -572,6 +572,10 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
>  	 */
>  	case beq_op:
>  	case beql_op:
> +		if (NO_R6EMU && insn.i_format.opcode == beql_op) {
> +			ret = -SIGILL;
> +			break;
> +		}
>  		if (regs->regs[insn.i_format.rs] ==
>  		    regs->regs[insn.i_format.rt]) {
>  			epc = epc + 4 + (insn.i_format.simmediate << 2);
> 
