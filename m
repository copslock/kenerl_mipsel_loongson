Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2016 17:29:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51547 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026562AbcDNP3d7TD3N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Apr 2016 17:29:33 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 3B2C3283D3EE2;
        Thu, 14 Apr 2016 16:29:22 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 14 Apr 2016 16:29:25 +0100
Received: from [192.168.154.45] (192.168.154.45) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 14 Apr
 2016 16:29:25 +0100
Subject: Re: New MIPS SoC code insertion request
To:     <Dmitry.Dunaev@baikalelectronics.ru>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
References: <E6691421972ADD4588ABC5DDDF6E279B8734754A@NRMAIL.baikal.int>
 <E6691421972ADD4588ABC5DDDF6E279B87347565@NRMAIL.baikal.int>
CC:     <Constantine.Gurin@baikalelectronics.ru>,
        <Alexey.Malahov@baikalelectronics.ru>
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Message-ID: <570FB753.3060001@imgtec.com>
Date:   Thu, 14 Apr 2016 16:29:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <E6691421972ADD4588ABC5DDDF6E279B87347565@NRMAIL.baikal.int>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

Hi Dmitry,

Thank-you very much for reaching out to the mailing list.

The Linux kernel follows a structure for patch submissions.

There’s a tutorial on github with a pdf and readmes.

https://github.com/gregkh/kernel-tutorial

Tutorial Videos on YouTube by GregKH are also very useful.

https://www.youtube.com/watch?v=LLBrBBImJt4

https://www.youtube.com/watch?v=XXix80GCvpo

These will give an overview of the entire process.

It would be nice if you could push your current working kernel
somewhere on a git server where we could see the patches
and then provide guidance accordingly.

If you don't have a public-facing git server. You could just
push the code to a repository on github and share the link.

Regards,
ZubairLK

On 14/04/16 15:43, Dmitry.Dunaev@baikalelectronics.ru wrote:
> Good day!
>
> I'm Dmitry Dunaev, software designer from Baikal Electronics - Russian semiconductor company (http://www.baikalelectronics.com/). Some time ago we are released our first MIPS processor based on P5600 core (https://www.linux-mips.org/wiki/Baikal).
>
> Now we have this SoC in silicon. Also we have released several revisions of development boards for our SoC. So it seems that we ready to add our platform code into Linux kernel mainline.
>
> Could you please clarify me what steps we should to do to add our code into kernel repositary?
>
> Best regards,
> Dmitry Dunaev
> http://www.baikalelectronics.com/
>
