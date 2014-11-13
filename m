Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 15:12:08 +0100 (CET)
Received: from mail-ig0-f174.google.com ([209.85.213.174]:42992 "EHLO
        mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013508AbaKMOMEeWsGm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 15:12:04 +0100
Received: by mail-ig0-f174.google.com with SMTP id hn18so5060134igb.1
        for <multiple recipients>; Thu, 13 Nov 2014 06:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GWecSnFHSBDfApcfAsyAKV1xhkHrjY7sBshx+3vxE3U=;
        b=Ba1AuFJh7Ybcy3CKmlamKP4zmnjjyiK0PYp1llX2UvAFC60vEcSHHmnclvqWC0sTV7
         6cGTQbRfsWc8UGuSuuui0JHwG70tQYGLzevdCzSBVD47bqk89GnpVJTno7rxnhQM8UIg
         u3Jf51MwkDrGgVNysGtU5lv5ZmrPSfHt5FO2PsAp5iAPCCfhn0TpmdDlLFUHTW/so76e
         rI6w69JSIxwMBw4xbaKveztrCbbIB1YRBQxwuGoJ0x5uU0gwlKyoLBZJ5cI2srKIsp/X
         7U8Sp5Oz8CPeyVg47wtPBMn9DWuROWOCgRNkLT5buCuRPM5ShH3SkIbuSJ4OL59J1Dad
         PorQ==
MIME-Version: 1.0
X-Received: by 10.50.171.129 with SMTP id au1mr4752840igc.0.1415887918790;
 Thu, 13 Nov 2014 06:11:58 -0800 (PST)
Received: by 10.64.176.211 with HTTP; Thu, 13 Nov 2014 06:11:58 -0800 (PST)
In-Reply-To: <1415876887-13957-1-git-send-email-James.Cowgill@imgtec.com>
References: <1415876887-13957-1-git-send-email-James.Cowgill@imgtec.com>
Date:   Thu, 13 Nov 2014 22:11:58 +0800
X-Google-Sender-Auth: PD7N5cSSQroVs_4NorfAmsVZGIA
Message-ID: <CAAhV-H4Ox-zq+-PAM+NdzptQo=s9KC9FSoUa51okB2V-MF+XLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mips: fix __node_distances undefined error on loongson3
From:   Huacai Chen <chenhc@lemote.com>
To:     James Cowgill <James.Cowgill@imgtec.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
        James Hogan <james.hogan@imgtec.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Thanks.
Reviewed-by: Huacai Chen <chenhc@lemote.com>

On Thu, Nov 13, 2014 at 7:08 PM, James Cowgill <James.Cowgill@imgtec.com> wrote:
> export the __node_distances symbol in the loongson3 numa code to fix the
> build error:
>
>   Building modules, stage 2.
>   MODPOST 221 modules
> ERROR: "__node_distances" [drivers/block/nvme.ko] undefined!
> scripts/Makefile.modpost:90: recipe for target '__modpost' failed
>
> when building the kernel with:
>  CONFIG_CPU_LOONGSON3=y
>  CONFIG_NUMA=y
>  CONFIG_BLK_DEV_NVME=m
>
> Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
> Cc: <stable@vger.kernel.org> # v3.17+
> Reviewed-by: James Hogan <james.hogan@imgtec.com>
> ---
>  arch/mips/loongson/loongson-3/numa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/loongson/loongson-3/numa.c b/arch/mips/loongson/loongson-3/numa.c
> index 37ed184..42323bc 100644
> --- a/arch/mips/loongson/loongson-3/numa.c
> +++ b/arch/mips/loongson/loongson-3/numa.c
> @@ -33,6 +33,7 @@
>
>  static struct node_data prealloc__node_data[MAX_NUMNODES];
>  unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
> +EXPORT_SYMBOL(__node_distances);
>  struct node_data *__node_data[MAX_NUMNODES];
>  EXPORT_SYMBOL(__node_data);
>
> --
> 2.1.3
>
>
