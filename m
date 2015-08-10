Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2015 21:22:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37941 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010825AbbHJTWuHejEa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Aug 2015 21:22:50 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8556E66CABFC7;
        Mon, 10 Aug 2015 20:22:40 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 10 Aug
 2015 20:22:44 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Mon, 10 Aug
 2015 20:22:43 +0100
Received: from [10.20.3.79] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 10 Aug
 2015 12:22:40 -0700
Message-ID: <55C8FA00.7020807@imgtec.com>
Date:   Mon, 10 Aug 2015 12:22:40 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [4.1,013/123] MIPS: c-r4k: Fix cache flushing for MT cores
References: <20150808220718.304261727@linuxfoundation.org> <55C8EF32.5010807@imgtec.com> <20150810184953.GA19646@kroah.com> <55C8F785.5020605@imgtec.com> <20150810191928.GA7925@kroah.com>
In-Reply-To: <20150810191928.GA7925@kroah.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48756
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

On 08/10/2015 12:19 PM, gregkh@linuxfoundation.org wrote:
> On Mon, Aug 10, 2015 at 12:12:05PM -0700, Leonid Yegoshin wrote:
>> On 08/10/2015 11:49 AM, gregkh@linuxfoundation.org wrote:
>>> On Mon, Aug 10, 2015 at 11:36:34AM -0700, Leonid Yegoshin wrote:
>>> So, this is broken in Linus's tree too?
>> Yes.
> Great, as long as I am consistent, that's all that I care about :)
>
>

You asked "If anyone has any objections, please let me know" and I did that.

- Leonid.
