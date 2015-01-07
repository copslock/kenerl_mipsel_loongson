Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 17:13:53 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.131]:64769 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010642AbbAGQNvoV9bU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jan 2015 17:13:51 +0100
Received: from wuerfel.localnet ([149.172.15.242]) by mrelayeu.kundenserver.de
 (mreue001) with ESMTPSA (Nemesis) id 0MRx1t-1YFAdk2Hwf-00SzI1; Wed, 07 Jan
 2015 17:13:45 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-mmc@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH, RFC] MIPS: jz4740: use dma filter function
Date:   Wed, 07 Jan 2015 17:13:44 +0100
Message-ID: <10623722.YrKe6DgiSS@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <54AD42D0.4070402@metafoo.de>
References: <22569458.nE7JkNNnz3@wuerfel> <2633187.PyovTNc8DC@wuerfel> <54AD42D0.4070402@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID:  V03:K0:R72jSrV7jOR8h23Lfme0sYvOhIs33ClQWaY55LHODU3cUoB9qms
 8C6BlY0VZvsPLILhmkUq4xy/axylS4yDe/5vCmgB9kvI72RmeBpLDIXlghNOwlmJIqpqGrr
 CoxyZa0f7ULQ3+7HgSaQlsD827YBGOBYE/OLQFPZfePLU9pMkcEbPM2QsJ0r2YMWwlvVrrD
 qD/4aYF3F+CC3bn5FZYGg==
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wednesday 07 January 2015 15:29:36 Lars-Peter Clausen wrote:
> On 01/06/2015 02:48 PM, Arnd Bergmann wrote:
> > On Tuesday 06 January 2015 11:45:58 Lars-Peter Clausen wrote:
> >> On 01/05/2015 11:39 PM, Arnd Bergmann wrote:
> >>> As discussed on the topic of shmobile DMA today, jz4740 is the only
> >>> user of the slave_id field in dma_slave_config besides shmobile. This
> >>> use is really incompatible with the way that other drivers use the
> >>> dmaengine API, so we should get rid of it.
> >>
> >> Do you have a link to that discussion?
> >
> > http://www.spinics.net/lists/linux-mmc/msg30069.html
> 
> I'm really not comfortable with this patch, since it is a step back. But I 
> guess the end justify the means. So if it helps to get rid of slave_id I'm 
> ok with it, sooner or later jz4740 will be converted to DT so once that's 
> done the filter function can be removed again. But please put the filter 
> function in a non arch specific header so we can still compile test things. 
> And maybe note in the commit message that this is meant as a temporary hack.
> 

Do you have a timeline for DT support? Maybe it's easier to just
wait for the problem to solve itself.

	Arnd
