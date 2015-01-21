Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 01:02:48 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51101 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011968AbbAUACrFHxuK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 01:02:47 +0100
Date:   Wed, 21 Jan 2015 00:02:47 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
cc:     linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH RFC v2 35/70] MIPS: kernel: cps-vec: Replace addi with
 addiu
In-Reply-To: <1421405389-15512-36-git-send-email-markos.chandras@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501202356480.28301@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-36-git-send-email-markos.chandras@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Fri, 16 Jan 2015, Markos Chandras wrote:

> MIPS R6 removed the addi instruction so we replace it with addiu.
> 
> Cc: Paul Burton <paul.burton@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  arch/mips/kernel/cps-vec.S | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
> index 0384b05ab5a0..55b759a0019e 100644
> --- a/arch/mips/kernel/cps-vec.S
> +++ b/arch/mips/kernel/cps-vec.S
> @@ -99,11 +99,11 @@ not_nmi:
>  	xori	t2, t1, 0x7
>  	beqz	t2, 1f
>  	 li	t3, 32
> -	addi	t1, t1, 1
> +	addiu	t1, t1, 1
>  	sllv	t1, t3, t1
>  1:	/* At this point t1 == I-cache sets per way */
>  	_EXT	t2, v0, MIPS_CONF1_IA_SHF, MIPS_CONF1_IA_SZ
> -	addi	t2, t2, 1
> +	addiu	t2, t2, 1
>  	mul	t1, t1, t0
>  	mul	t1, t1, t2
>  

 This looks like another case of an unrelated ADDIU vs ADDI bug, there's 
nothing in this code apparent to me that would make it want trap on 
integer overflows.  This should go in separately IMHO, not as a part of R6 
changes, and right away, including all the relevant release branches.

 Of course an updated description would do, I'll mark such an update as 
reviewed by me to speed up processing.

  Maciej
