Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 May 2017 12:58:20 +0200 (CEST)
Received: from mout.web.de ([212.227.15.14]:54829 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992289AbdEYK6KAc0ap (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 May 2017 12:58:10 +0200
Received: from [192.168.1.2] ([77.181.176.35]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXYTG-1dPPzE1SKs-00WVaK; Thu, 25
 May 2017 12:57:58 +0200
Subject: Re: MIPS: Alchemy: Delete an error message for a failed memory
 allocation in alchemy_pci_probe()
To:     Manuel Lauss <manuel.lauss@gmail.com>, linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@imgtec.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <6ebb5193-239f-5c34-c5f6-2be8a2fa79a5@users.sourceforge.net>
 <CAOLZvyHq-7q0XxiBsyX3q0g0J3kjfFv4SU7amX1hpjRDyK+feQ@mail.gmail.com>
 <796029e7-60a3-a94b-8b5c-4686a0656560@users.sourceforge.net>
 <CAOLZvyH-DF_r77kzcVcn+A-tTov+aNZ1oGNQLnGWXE35UODqtQ@mail.gmail.com>
 <70394897-a67a-2b49-2d46-a20fb2de51f2@users.sourceforge.net>
 <CAOLZvyGEzzQ_Jvy3NNQqDER4QHe2Dj-Y4sX2MNANo-phXbzQ8g@mail.gmail.com>
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <6769aa4c-3a32-3ce5-fb65-f218016a1aa8@users.sourceforge.net>
Date:   Thu, 25 May 2017 12:57:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAOLZvyGEzzQ_Jvy3NNQqDER4QHe2Dj-Y4sX2MNANo-phXbzQ8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:xYfpL8Uu51CtUX2uN1wJVv5j2EMvw0uxj1uHE14zusDfggW4v7x
 az2bmh6/gEbrbK3DwLMZd4P95TqJ+xZRvINpeFWiQiPT7XWxO7/XCktcBfm9Yc2YLBuDXHr
 Mf8pX6CX8hG1l1Z9E/SBM29Oxsr4PBoKssx2JUQRtvT1USgRn2/JP5rHVUaBYeT2bAw3k2m
 CwAZafV91c56Dg+6qiGTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TtgMRqfCLNg=:7p3cgp2RXhLeMqbLZ7CBV+
 NB9fY+p8hJrfeCo3RF9jwsSfUpuVAF+8/fM8ifeZOuLLr+JI2gw2f32suFI5tGLB2kHoMCka1
 E3ApV7BqUB6Q/+XEtfr76t5IQ7rHTN3WF0R3wxoGHDziRrddIm2/dszQgL2oo5Tv8YANO2U4G
 dGPHYAqmzTop3TMSG8HXxikuMkt7lTa9SxCaHMCaoRhx5eWW1vChtiss6PKWFhaVqFyNSVqga
 tvgICZpf8p5Dc529Ng/9yUzWGmdgv6LG6YmOe225l9j434tV9EE0CH22OdeFw0fMUgmV7Rcib
 F9YeOO54a34CSsk6bhWmklEjUX+unhd4AEErkJ5fW7N21cjsGL8ch4PcI9yPItj4bQhNWUHjP
 rD0G0agCAdtyH37qNCMxnYxxcvaFVqvBxUoTL82a0ImQv7B9fdJUIkgxhheMsvR1jfqAqlJ5h
 84O0Tnx29LPky1PEb0XrN7PcKzt0BxsrW0sBTZPxhmM6iBIVZ1NweHXACinBJqu6pdSjpiZu+
 MB9GoZIGuNPLYI8ac9LZxulfNaApZem1QDF9hc0B+ETwecWyfbtt+JyqFAJLHPhD0D0I7ukhq
 7uq1g51CsYEFUTv+Y2BNviuoLyks5EYz3o1ApYHLhsJgGDwOR2ugbXWAfrx1HNaaTq56Aidb0
 uTDEBEp9ycTFj6L3dWkhfqUGlXBSIX4yMa+DlE0JmHlODfTizRcSNBRwlhkkF8/OgKqtOCvC9
 pz6noe94P+RRhhqOcx2SqIYyzYWMaDOF0WKdqPmQQp8qsLhXNY7AxNQUw5xW+RbsjQicRK1kP
 keQEI6F
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58003
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

>> * Why do you seem to insist on another message if information from a Linux
>>   allocation failure report would be sufficient already also for this
>>   software module?
>>
>> * Do you want that it can become easier to map a position in a backtrace
>>   to a place in your source code?
> 
> Does kmalloc() nowadays print a message which invocation (source line) failed?
> If so I won't be standing in your way, but if not, you need to come up with
> something for convincing than answering questions with more questions.

I suggest also to improve the corresponding documentation for the affected
programming interfaces in significant ways.
How are the chances for the desired clarification of relevant implementation details?

Regards,
Markus
