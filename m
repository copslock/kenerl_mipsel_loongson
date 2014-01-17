Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jan 2014 08:15:41 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:58204 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825360AbaAQHOAXLokH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jan 2014 08:14:00 +0100
Message-ID: <52D8D83F.1020906@phrozen.org>
Date:   Fri, 17 Jan 2014 08:14:07 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH upstream-sfr] MIPS: APRP: Use the new __wait_event*()
 interface in RTLX
References: <1389908212-19898-1-git-send-email-dengcheng.zhu@imgtec.com>
In-Reply-To: <1389908212-19898-1-git-send-email-dengcheng.zhu@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

Hi,

should we fold this fix into 9d4147a783


    John

 
On 16/01/2014 22:36, Deng-Cheng Zhu wrote:
> From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>
> The commit 35a2af94c7 (sched/wait: Make the __wait_event*() interface more
> friendly) changed __wait_event_interruptible() to use 2 parameters instead
> of 3. It also made corresponding changes to rtlx.c. However, these changes
> were partially reverted by 9d4147a783 (MIPS: APRP: Code formatting
> clean-ups.). This patch fixes it.
>
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
> ---
> Ralf, this needs to go upstream-sfr/mips-for-linux-next to fix the APRP
> build error: macro "__wait_event_interruptible" passed 3 arguments, but
> takes just 2
>
>  arch/mips/kernel/rtlx.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
> index 4658350..31b1b76 100644
> --- a/arch/mips/kernel/rtlx.c
> +++ b/arch/mips/kernel/rtlx.c
> @@ -108,10 +108,9 @@ int rtlx_open(int index, int can_sleep)
>  		p = vpe_get_shared(aprp_cpu_index());
>  		if (p == NULL) {
>  			if (can_sleep) {
> -				__wait_event_interruptible(
> +				ret = __wait_event_interruptible(
>  					channel_wqs[index].lx_queue,
> -					(p = vpe_get_shared(aprp_cpu_index())),
> -					ret);
> +					(p = vpe_get_shared(aprp_cpu_index())));
>  				if (ret)
>  					goto out_fail;
>  			} else {
