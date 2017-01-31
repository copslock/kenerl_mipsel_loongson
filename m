Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2017 21:16:04 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:58990 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993920AbdAaUP4tslKi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2017 21:15:56 +0100
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 404F46079A; Tue, 31 Jan 2017 20:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1485893755;
        bh=TE3qdJJSi4qAA94Rd0+HOmsBEXzFOEsj+T9hy3913dg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KiF0gFhXwNbEk9S3RkcavRj+bpio14qbAECwd353L68rPcp0mljuJEHJLbNXbNLzJ
         +WN80pD3/+1AiH/jpJ8W/L8YTnweHZcCLs8Z+CpFhF+ur1Xkk2VmOZem3KJqQUGraG
         fqfY9bcBwrFM6Tj467cimoOr7NqZqtqc0uYC+EkI=
Received: from [10.222.143.167] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: timur@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 434F56079A;
        Tue, 31 Jan 2017 20:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1485893754;
        bh=TE3qdJJSi4qAA94Rd0+HOmsBEXzFOEsj+T9hy3913dg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jDxfSm1qRYEtlhHPG/hEIogwdo9QsWRZlAsEEbjjbhAD3S6PK0dGqHIDZDY7VnlB0
         ROxv0qxFjzkqwqENzgRtL9QGADUXFRiC0bHPZRIvbBV9B2FiJLiDn3EBs65JiwHa0I
         dSDUketzOuhuxsroDtdjvMdy1aWKqM8+ET0ry6eY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 434F56079A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH 4.10-rc3 08/13] net: emac: fix build errors when
 linux/phy*.h is removed from net/dsa.h
To:     Russell King <rmk+kernel@armlinux.org.uk>,
        linux-mips@linux-mips.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <20170131191704.GA8281@n2100.armlinux.org.uk>
 <E1cYdxI-0000Wk-5w@rmk-PC.armlinux.org.uk>
From:   Timur Tabi <timur@codeaurora.org>
Message-ID: <c7dd612a-fa69-12ca-fd53-44649a18dd11@codeaurora.org>
Date:   Tue, 31 Jan 2017 14:15:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:49.0) Gecko/20100101
 Firefox/49.0 SeaMonkey/2.46
MIME-Version: 1.0
In-Reply-To: <E1cYdxI-0000Wk-5w@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <timur@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: timur@codeaurora.org
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

On 01/31/2017 01:19 PM, Russell King wrote:
> drivers/net/ethernet/qualcomm/emac/emac-sgmii.c:58:12: error: dereferencing pointer to incomplete type 'struct phy_device'
>
> Add linux/phy.h to emac-sgmii.c
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 1 +

The version of emac-sgmii.c on net-next does not need this fixed.  I already 
removed all references to phy_device in commit "net: qcom/emac: always use 
autonegotiation to configure the SGMII link".

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
