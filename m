Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2018 05:07:45 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:45070 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990410AbeC3DHhkgiFG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Mar 2018 05:07:37 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C95FD60C55; Fri, 30 Mar 2018 03:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1522379250;
        bh=tF8xzVXXWBArBAIP05t3tvuMLf8fg+qokaTMWB6RPSM=;
        h=Subject:References:To:From:Date:In-Reply-To:From;
        b=Tj7/GT+gnMTV4QyluLU/gFM8DEii6cygg/Pp5vRim/EhLahR++Sth/kBd9GiDR+So
         PQ9G7aM0l3ufK5dWqhsHhXddfraC9oD0DiwyQmL+FRUrxXQ31f+qrjuQzO1+QwC2Fz
         QuweF6NIy7H8FPhO1YXwiHj2NaL9PHZf21LBfFrw=
Received: from [172.17.0.162] (unknown [108.175.202.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EAB7360ACA;
        Fri, 30 Mar 2018 03:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1522379250;
        bh=tF8xzVXXWBArBAIP05t3tvuMLf8fg+qokaTMWB6RPSM=;
        h=Subject:References:To:From:Date:In-Reply-To:From;
        b=Tj7/GT+gnMTV4QyluLU/gFM8DEii6cygg/Pp5vRim/EhLahR++Sth/kBd9GiDR+So
         PQ9G7aM0l3ufK5dWqhsHhXddfraC9oD0DiwyQmL+FRUrxXQ31f+qrjuQzO1+QwC2Fz
         QuweF6NIy7H8FPhO1YXwiHj2NaL9PHZf21LBfFrw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EAB7360ACA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Broken DMA vs MMIO ordering on MIPS
References: <e7983c8d-04d5-39f7-6d83-122af4e66e51@codeaurora.org>
To:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>
From:   Sinan Kaya <okaya@codeaurora.org>
X-Forwarded-Message-Id: <e7983c8d-04d5-39f7-6d83-122af4e66e51@codeaurora.org>
Message-ID: <623a6f6f-6413-62ad-f2c0-d48d72f2d129@codeaurora.org>
Date:   Thu, 29 Mar 2018 23:07:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e7983c8d-04d5-39f7-6d83-122af4e66e51@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63352
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

Hi MIPS Maintainers,

memory-barriers.txt has been updated not to require a wmb() before writel()
since Linus asked all infrastructures to follow Intel paradigm where writes
are ordered and they do not require a barrier between a memory update and
HW observation.

https://www.mail-archive.com/netdev@vger.kernel.org/msg225806.html

https://lkml.org/lkml/2018/3/27/431

We have been auditing all architectures to see if they follow this requirement
or not. 

Arnd raised the following concern that MIPS would be non-compliant.

Can somebody familiar with MIPS evaluate this?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
