Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 20:46:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37220 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010566AbbLGTqA06Xw2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 20:46:00 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 0BEC5BFE946BA;
        Mon,  7 Dec 2015 19:45:50 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.235.1; Mon, 7 Dec
 2015 19:45:53 +0000
Received: from [10.20.3.92] (10.20.3.92) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 7 Dec 2015
 11:45:51 -0800
Message-ID: <5665E1EE.1070501@imgtec.com>
Date:   Mon, 7 Dec 2015 11:45:50 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] MIPS: Don't unwind to user mode with EVA
References: <1449267902-28674-1-git-send-email-james.hogan@imgtec.com> <1449267902-28674-2-git-send-email-james.hogan@imgtec.com> <56622DF5.30005@imgtec.com> <20151207084345.GB874@jhogan-linux.le.imgtec.org>
In-Reply-To: <20151207084345.GB874@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.92]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 12/07/2015 12:43 AM, James Hogan wrote:
> On Fri, Dec 04, 2015 at 04:21:09PM -0800, Leonid Yegoshin wrote:
>> OK.
> Thanks Leonid. Can that be taken as a Reviewed-by?
>
> Cheers
> James
Yes, please.

- Leonid
