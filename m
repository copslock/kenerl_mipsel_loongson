Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2018 04:33:59 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:47374 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991359AbeDMCdvWUDTj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2018 04:33:51 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2550B607C7; Fri, 13 Apr 2018 02:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523586825;
        bh=yMc94yOTyTZaR7HfgQw0jVgWt/BHm0QguJXaIUnZV4A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B7KYWMwKq5I+yGLglBXDk1P1YG7BEGcVSQYfXCPHsaQP3den4iLv33RAdZ8bDtjeM
         a969SCnGy81fIRjl9HDQDa1flri+CJSriGxVgezj5ZcIhe9c1JKiz1f9RW8VTptMtU
         xlA81QO7wUtowtLJwIAgxrV+5CcfFGdgDBn9VRkw=
Received: from [192.168.0.105] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D08960264;
        Fri, 13 Apr 2018 02:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523586824;
        bh=yMc94yOTyTZaR7HfgQw0jVgWt/BHm0QguJXaIUnZV4A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=I1xKu5nVAdXNP6rfuHZrMYyYyHalB3xlzJcW7Q2R6sLaDoPk6uY8tUiG6zX4mPMqE
         CQxlegePcq6oHWsHg1ZwPRKgQkCbv0i8imnfgd69d8YUR9rzK8EDg1FPFi58mntFIV
         CwsJ/KJLvppFCdnYom3u7Fu4QWgjtb0fiiAMnMRU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D08960264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v4 2/2] MIPS: io: add a barrier after register read in
 readX()
To:     linux-mips@linux-mips.org, arnd@arndb.de, timur@codeaurora.org,
        sulrich@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
References: <1523586646-19630-1-git-send-email-okaya@codeaurora.org>
 <1523586646-19630-2-git-send-email-okaya@codeaurora.org>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <d1f91bcc-4523-e8fb-2f16-4a5932460d44@codeaurora.org>
Date:   Thu, 12 Apr 2018 22:33:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523586646-19630-2-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63518
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

On 4/12/2018 10:30 PM, Sinan Kaya wrote:
> +	/* prevent prefetching of coherent DMA dma prematurely */	\

I tried to write DMA data but my keyboard is not cooperating. I'll hold onto
posting another version until I hear back from you for wmb().

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
