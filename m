Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Apr 2018 22:49:11 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:57634 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990723AbeDKUtDr3nfH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Apr 2018 22:49:03 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 200E760F8D; Wed, 11 Apr 2018 20:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523479737;
        bh=lWCNQSDMOqv62cWCoZqOGQ0/bUGYWyzSD1RszUqPeMI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RsK+rulz0C1+0Jj6xjpVHVfEpmlPm/+gpSNZ/RRrNcBbV9BS+/jcGELFqWrz7NvH9
         QVFYfX2rtbXmScoPnB54LIOUmEJfwgVeEKj7/Oin8TCfQyUk5MGZmOcJ2xZ/OyLcQ2
         X5uvFie84a7YTRm9IWTZQAU+qQnMoX2g1F6Xy/58=
Received: from [10.235.228.150] (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B36F5600ED;
        Wed, 11 Apr 2018 20:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523479736;
        bh=lWCNQSDMOqv62cWCoZqOGQ0/bUGYWyzSD1RszUqPeMI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WBdH2PdKeqbK7JbonOU1ZpBjdoDxHoUvB4rgAvW1nlOjV7kx9S5L6NW/KoHIKAOL6
         cxeIBFFqSJ9M3LQqkxWVUXxKJ4wguHQ4IUav6pJAs5g4WJfnms97svjAXzyW93ID2J
         oUh3988MPI9LZokRBV6leGCUbGJdkpsxN+LZRRPc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B36F5600ED
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
To:     James Hogan <james.hogan@mips.com>
Cc:     linux-mips@linux-mips.org, arnd@arndb.de, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <41e184ae-689e-93c9-7b15-0c68bd624130@codeaurora.org>
 <b748fdcb-e09f-9fe3-dc74-30b6a7d40cbe@codeaurora.org>
 <20180406212601.GA1730@saruman>
 <0f1a4719-9a6f-0df0-7fd9-a25c10e824f5@codeaurora.org>
 <14a663f6-2ea5-230b-2cd0-e42d05d0d7ea@codeaurora.org>
 <20180411202616.GA14760@jhogan-linux.mipstec.com>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <abcad691-2ac8-ffc5-30a2-77ad6781664a@codeaurora.org>
Date:   Wed, 11 Apr 2018 16:48:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411202616.GA14760@jhogan-linux.mipstec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63503
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

On 4/11/2018 4:26 PM, James Hogan wrote:
> On Wed, Apr 11, 2018 at 01:10:41PM -0400, Sinan Kaya wrote:
>> How is the likelihood of getting this fixed on 4.17 kernel?
> 
> High.
> 

Thanks for the confirmation.

> Thanks
> James
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
