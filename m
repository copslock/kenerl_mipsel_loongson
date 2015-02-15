Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Feb 2015 02:23:04 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47491 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012661AbbBOBXDC7UKh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Feb 2015 02:23:03 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 47A16B5155D2A;
        Sun, 15 Feb 2015 01:22:56 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sun, 15 Feb
 2015 01:22:57 +0000
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Sun, 15 Feb
 2015 01:22:56 +0000
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Sat, 14 Feb
 2015 17:22:54 -0800
Message-ID: <54DFF4EE.6010008@imgtec.com>
Date:   Sat, 14 Feb 2015 17:22:54 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Paul Bolle <pebolle@tiscali.nl>
CC:     Valentin Rothberg <valentinrothberg@gmail.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: MIPS: CONFIG_MIPS_R6?
References: <1423934469.9418.18.camel@x220>
In-Reply-To: <1423934469.9418.18.camel@x220>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45819
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

On 02/14/2015 09:21 AM, Paul Bolle wrote:
> Your commits 430857eae56c ("MIPS: mm: Add MIPS R6 instruction
> encodings") and 90163242784b ("MIPS: kernel: unaligned: Add support for
> the MIPS R6") are included in yesterday's linux-next (ie,
> next-20150213). I noticed because a script I use to check linux-next
> spotted a problem with it.
>
> These commits added three references to CONFIG_MIPS_R6, were probably
> CONFIG_CPU_MIPSR6 was intended. One reference is in a comment, which
> should be trivial to get fixed. The other two references are in
> (negative) preprocessor checks. It's not certain, at least not to me,
> how these should be fixed.
>
>
> Paul Bolle

Yes, please.

- Leonid.
