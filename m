Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jul 2015 10:42:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61035 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009433AbbGPImcVYFy1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Jul 2015 10:42:32 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BEEC8467FD43F;
        Thu, 16 Jul 2015 09:42:24 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 16 Jul 2015 09:42:26 +0100
Received: from [192.168.154.48] (192.168.154.48) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 16 Jul
 2015 09:42:25 +0100
Subject: Re: compile failure linux 3.10 with gcc 4.9.3 for mips
To:     Reinoud Koornstra <reinoudkoornstra@gmail.com>
References: <CAAA5faEN3MmWACoT2g2+9aOj1C=vj7UcNxd3Lez_K4_sCS8jBQ@mail.gmail.com>
 <55A613C6.3040505@imgtec.com>
 <CAAA5faHubPyT8D+QYB_M+qyCo-rRzPDO3fSH1HtSXCfCTj40HA@mail.gmail.com>
CC:     <linux-mips@linux-mips.org>
From:   Markos Chandras <Markos.Chandras@imgtec.com>
Message-ID: <55A76E71.8090909@imgtec.com>
Date:   Thu, 16 Jul 2015 09:42:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
MIME-Version: 1.0
In-Reply-To: <CAAA5faHubPyT8D+QYB_M+qyCo-rRzPDO3fSH1HtSXCfCTj40HA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 07/15/2015 08:56 PM, Reinoud Koornstra wrote:
> Thanks for your answer.
> Is this patch going in upstream
> Thanks,
> 
> Reinoud
> 

It's already upstream just not in 3.10. A more recent kernel should
compile fine with your toolchain.

-- 
markos
