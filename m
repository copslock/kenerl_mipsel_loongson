Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Oct 2015 20:12:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43185 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011200AbbJTSMmpGxK0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Oct 2015 20:12:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 262947BC56B78;
        Tue, 20 Oct 2015 19:12:34 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 20 Oct
 2015 19:12:36 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Tue, 20 Oct
 2015 19:12:36 +0100
Received: from [10.20.3.92] (10.20.3.92) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 20 Oct
 2015 11:12:34 -0700
Message-ID: <56268411.1080307@imgtec.com>
Date:   Tue, 20 Oct 2015 11:12:33 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        <linux-mips@linux-mips.org>, <paul.burton@imgtec.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <luto@amacapital.net>,
        <alex.smith@imgtec.com>, <macro@codesourcery.com>,
        <mpe@ellerman.id.au>
Subject: Re: [PATCH v3] MIPS64: signal: n64 kernel bugfix of MIPS32 o32 ABI
 sigaction syscall
References: <20151019183955.6212.78229.stgit@ubuntu-yegoshin> <5625FCDE.9010608@imgtec.com>
In-Reply-To: <5625FCDE.9010608@imgtec.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.92]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49611
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

On 10/20/2015 01:35 AM, Markos Chandras wrote:
> What tree did you use for this patch? It does not seem to apply to 
> mainline or Ralf's upstream-sfr. 

May I ask you to elaborate more and send me a concern details?
I definitely rebased it to mips-for-linux-next of upstream-sfr from LMO.

- Leonid
