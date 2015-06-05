Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2015 10:24:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25823 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007407AbbFEIY0zg7JQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jun 2015 10:24:26 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 19E0F3694EED6;
        Fri,  5 Jun 2015 09:24:19 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 5 Jun 2015 09:24:21 +0100
Received: from [192.168.154.48] (192.168.154.48) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 5 Jun
 2015 09:24:20 +0100
Message-ID: <55715CB4.6020509@imgtec.com>
Date:   Fri, 5 Jun 2015 09:24:20 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>
CC:     <linux-mips@linux-mips.org>, <netdev@vger.kernel.org>,
        <ast@plumgrid.com>, <dborkman@redhat.com>,
        <hannes@stressinduktion.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] MIPS/BPF fixes for 4.3
References: <1433415376-20952-1-git-send-email-markos.chandras@imgtec.com> <20150604.114021.2198304591433879318.davem@davemloft.net>
In-Reply-To: <20150604.114021.2198304591433879318.davem@davemloft.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47874
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

On 06/04/2015 07:40 PM, David Miller wrote:
> 
> I think your Subject meant to say "fixes for 4.2" right?
> 
> Because we're currently finishing up 4.1.x and the next merge
> window will be for 4.2.x
> 
Hi David,

Ralf only accepts patches for MIPS 4.2 that have been posted before
4.1-rc5. This is posted nearly before 4.1-rc7 so it's likely to go to
4.3 based on Ralf's policy. Unless of course he wants to merge that to
4.2 which would be nice of course.

-- 
markos
