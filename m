Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jun 2014 09:56:00 +0200 (CEST)
Received: from smtp-out-099.synserver.de ([212.40.185.99]:1032 "EHLO
        smtp-out-099.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816005AbaF2Hz6zIVaG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jun 2014 09:55:58 +0200
Received: (qmail 10157 invoked by uid 0); 29 Jun 2014 07:55:57 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 10088
Received: from ppp-46-244-166-46.dynamic.mnet-online.de (HELO ?192.168.178.23?) [46.244.166.46]
  by 217.119.54.77 with AES128-SHA encrypted SMTP; 29 Jun 2014 07:55:57 -0000
Message-ID: <53AFC68C.5010105@metafoo.de>
Date:   Sun, 29 Jun 2014 09:55:56 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.6.0
MIME-Version: 1.0
To:     Fabian Frederick <fabf@skynet.be>, linux-kernel@vger.kernel.org
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/1] MIPS: jz4740: remove unnecessary null test before
 debugfs_remove
References: <1404026663-3510-1-git-send-email-fabf@skynet.be>
In-Reply-To: <1404026663-3510-1-git-send-email-fabf@skynet.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 06/29/2014 09:24 AM, Fabian Frederick wrote:
> Fix checkpatch warning:
> WARNING: debugfs_remove(NULL) is safe this check is probably not required
>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>   arch/mips/jz4740/clock-debugfs.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/mips/jz4740/clock-debugfs.c b/arch/mips/jz4740/clock-debugfs.c
> index a8acdef..325422d0 100644
> --- a/arch/mips/jz4740/clock-debugfs.c
> +++ b/arch/mips/jz4740/clock-debugfs.c
> @@ -87,8 +87,7 @@ void jz4740_clock_debugfs_add_clk(struct clk *clk)
>   /* TODO: Locking */
>   void jz4740_clock_debugfs_update_parent(struct clk *clk)
>   {
> -	if (clk->debugfs_parent_entry)
> -		debugfs_remove(clk->debugfs_parent_entry);
> +	debugfs_remove(clk->debugfs_parent_entry);
>
>   	if (clk->parent) {
>   		char parent_path[100];
>
