Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Sep 2015 10:14:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11738 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006854AbbIJIOYkHBf- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Sep 2015 10:14:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id AC3E97E24C4D1;
        Thu, 10 Sep 2015 09:14:17 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 10 Sep 2015 09:14:19 +0100
Received: from [192.168.154.88] (192.168.154.88) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 10 Sep
 2015 09:14:18 +0100
Subject: Re: mips VDSO
To:     <dwalker@fifo99.com>, <alex.smith@imgtec.com>
References: <20150909164309.GB27534@fifo99.com>
CC:     <linux-mips@linux-mips.org>
From:   Markos Chandras <Markos.Chandras@imgtec.com>
Message-ID: <55F13BDA.3030304@imgtec.com>
Date:   Thu, 10 Sep 2015 09:14:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20150909164309.GB27534@fifo99.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.88]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49154
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

On 09/09/2015 05:43 PM, dwalker@fifo99.com wrote:
> Hi,
> 
> I was wondering if you've made any progress on this? I was also interested in implementing a faster gettimeofday()
> for mips.
> 
> Daniel
> 
Hi,

I am currently reviewing Alex's VSDO implementation and I will post it
to this list within the next couple of weeks.

-- 
markos
