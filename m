Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2018 00:20:46 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:34970 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993588AbeDLWUeGOcsD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2018 00:20:34 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 613FA60FB1; Thu, 12 Apr 2018 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523571627;
        bh=t8fyu+cXciREdrVlOP2JsdBA8C6zHOCrJSaVY+6J/VE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bo4ZiTbf6t71cOzQzXU1h24K58Gd9lgtlbpz6gAPSy4+mkPV9ZkgLzCdjqBO2NQca
         1bRnm1WKDT9O+DrXTMDZ7B5ZZNEnFBALhKESGp0lPsLTzVnoiiUdetoKYeHZEG+uP7
         pYYof1FMnJ/BAA9t/KD+ViRtiodEnsQogEVenKBs=
Received: from [10.235.228.150] (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8BC1C60F90;
        Thu, 12 Apr 2018 22:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523571626;
        bh=t8fyu+cXciREdrVlOP2JsdBA8C6zHOCrJSaVY+6J/VE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gZai8mJog7dYjJF4/eQh8vHug93oPH//Bi3vr/vVRIdYd8hMB3e/fvwyKGGunNH4d
         jx485k6P6NTfZEChRRRRzQlAvJNaB0DKLkYHZhMTbgciSQKeVxeA73CpCB43ktDDYB
         KCO23OwNQ9hvG2bH4Yshu06/wqTua8ZAl1+t0/qE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8BC1C60F90
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
To:     James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, arnd@arndb.de, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <20180412215149.GA27802@saruman>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <a50e4919-24d8-de37-c696-ec964988ca8b@codeaurora.org>
Date:   Thu, 12 Apr 2018 18:20:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412215149.GA27802@saruman>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: okaya@codeaurora.org
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

On 4/12/2018 5:51 PM, James Hogan wrote:
> But why don't we always use wmb() in the writeX() case? Might not the
> cached write to DMA buffer be reordered with the uncached write to MMIO
> register from the coherent DMA point of view? I'm waiting on feedback
> from MIPS hardware folk on this topic.

Are you asking about this?

 #if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_LOONGSON3_ENHANCEMENT)
 #define war_io_reorder_wmb()		wmb()
 #else
-#define war_io_reorder_wmb()		do { } while (0)
+#define war_io_reorder_wmb()		barrier()
 #endif

There is a write barrier in writeX() but seem to be different from platform
to platform. 

I'm not familiar with the MIPS architecture. We can always use a wmb() but it
could hurt performance where it is not needed. 

This is the kind of input we need from the MIPS folks if compiler barrier is
enough or we need a wmb() for all cases.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
