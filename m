Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2016 16:03:23 +0200 (CEST)
Received: from mout.web.de ([212.227.17.11]:52949 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992178AbcJXODQkkP3f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Oct 2016 16:03:16 +0200
Received: from [192.168.1.2] ([77.182.95.108]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MS290-1cMR7v1RjW-00TEsk; Mon, 24 Oct 2016 16:02:53
 +0200
Subject: Re: MIPS/kernel/r2-to-r6-emul: Use seq_puts() in mipsr2_stats_show()
To:     Theodore Ts'o <tytso@mit.edu>, linux-mips@linux-mips.org
References: <3809e713-2f08-db60-92c1-21d735a4f35b@users.sourceforge.net>
 <4126c272-cdf6-677a-fe98-74e8034078d8@users.sourceforge.net>
 <20161024131311.ttwr2bblphg6vd2b@thunk.org>
Cc:     Andrea Gelmini <andrea.gelmini@gelma.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <e7ac4cba-bce1-edf5-a537-4c06a357bfb3@users.sourceforge.net>
Date:   Mon, 24 Oct 2016 16:02:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161024131311.ttwr2bblphg6vd2b@thunk.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:JZgZNqm1kklc32V+y3sTy1H4xZsyK6a5R+X1aUTgdeaayVH+KY1
 aaSS7f2zCpAEoDB0cKLpoZnKpdBLRmzwxH/u6tAT4vybqVP11Tsa6u474XuGYNUosMDLKmW
 odgT0XzNp08wwFrFCXh+SMdj8QlpzBFb8jeMGefLH3CxDN1n0HV3UZjeiXA/9sC2XcHRazr
 pF94RBkR/he4FeRtPvoNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:24HWTeps0MI=:a55TCPhyY03+N4GmL9ownH
 5VJNcVXFMtBSTD5VKCtB/OkjSrIlNyMw5/Ehw7FwbHMOepPshJ9CgRdZHP8531MlmsMr5rtlL
 vuAbp4QjR1Y15itKYV6OnpBqai9HD4tc28k4MpwNzKFWL1aGcfX2Dx8bH9hUrdJrr7WfkKbs2
 QeCCPmXPXYKbLUZZcdcn1VNGnAHYfvI6tvhiM+Ids+GDJ8HFBNe9kHjy6PcrFzP68YQcKwVFw
 5NGN7BHjvsC+dyUveHhZR2oJX/Gfo39cEr4ow1kKIkgjqTZXnHdKLQ3SoEOpsgqHq6TJVhsAm
 Cj0dI3HLdDGQrWaaBuRLWSNvNBbcyxdUOxh5rDXWZ4iJPhCEQqk1qlwfl/YlO9h648DPcbA5p
 EjrdoIa2jLaTy9SW9sblKSauv6tv8TxLZzbVMqw4bKaCHGTdCRpKHXv47Ysz7w5AsQyg5+SI+
 l/Ic5NUfXX06rlbZdeCg/wQ9MQWMyXUnPgNbh+dzlL8PLMphGWN8Dm35YSOmdWDvcnIRIgKWA
 EDQL2cG8vuGwWo2ZEvDAV3zpb7TXgYY5CSX6glwYICV/omlmxC8m4IIiUvjnhJa9jgg9frshM
 0HGZb0HUhWGnH5lA/Qs3uk21UPnNE2wxHoVAy65lViTt2sN4Mnh6PAf3NXefjSnern+ERm7M5
 UgIR5MRNo0aDlQdxWBdNGf23+tjkbiZA5OgzGFVh0ZxHeKXr+E5GRjLfdI521ygdNJ5TDo3lM
 zU9/ubv13eDvWpj3iHZnc+e3p8sHw8GfR5rCSF8hvdt7fncjA1PEVrhK2+l7XaVffX9uPnBl6
 SgBkoM3
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

>> A string which did not contain a data format specification should be put
>> into a sequence.
> 
> This is not a correct description of what you are doing.  A better
> description would be to say:
> 
> "Use seq_put[sc]() instead of seq_printf() since the string does not
> contain a data format specifier".

Thanks for your suggestion about an other wording.


> You should fix this in all the patches.

I am curious if a second approach will become acceptable in the near future.


> Please also note this is really pointless patch,

If you do not like the proposed changes for some subsystems so far,
I would appreciate another clarification:

* Could you tolerate them for any other software components?

* May I continue to inform involved developers about similar change possibilities?


> since reading from /proc isn't done in a tight loop, and even if it were,
> the use of vsprintf is the tiniest part of the overhead.

Thanks for your software development opinion.


> It otherwise reduces the text space or the number of lines of code....

Do other system testers and Linux users care a bit more for corresponding
chances in improved software efficiency?

Regards,
Markus
