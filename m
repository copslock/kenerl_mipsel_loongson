Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jan 2016 10:21:21 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.13]:54360 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014679AbcAMJVTXdnNt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jan 2016 10:21:19 +0100
Received: from wuerfel.localnet ([134.3.118.24]) by mrelayeu.kundenserver.de
 (mreue101) with ESMTPSA (Nemesis) id 0MNL1F-1aHLnq2JSL-006zfW; Wed, 13 Jan
 2016 10:20:39 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Dave Chinner <david@fromorbit.com>, linux-mips@linux-mips.org
Cc:     y2038@lists.linaro.org, Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [Y2038] [RFC 02/15] vfs: Change all structures to support 64 bit time
Date:   Wed, 13 Jan 2016 10:20:18 +0100
Message-ID: <8960550.YnDr3xSm6r@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <20160113062716.GJ6033@dastard>
References: <1452144972-15802-1-git-send-email-deepa.kernel@gmail.com> <4788428.RCG4WOvRdT@wuerfel> <20160113062716.GJ6033@dastard>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:6Pgrwe5lC/bxaViaZzEbYfqo/F3tkf6lEROGiRVseJ2IQt/nDOL
 JgnAdVVgqYUHQjcFYbNQbjnwClvRxPzNw6PFDsJPlza64j1qaMDdpRzcMSerdLo7uMC5xP6
 2JtDsJWkR3ZFCdU+7yn6PuNBN6AqhBEuCGojIonszd+DDaxhP8Mg/Dw2mAaCqdzL+WqKTSw
 g+V9LOl0Do2CLnXy82oZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0l6q9L+81K0=:S5ZLDqpzlXoDCxC+fOPNcb
 UGa3tGxDrGyREj7N1kOCNguLKPZOgGE0lmtawqb3PcV8gtCxJts+P+/r8wtOWCpZbviDW/OOr
 VWB6nDsOgfplpVGOPPUE0xjhG2f6khbCmoJXh93aozfYZ3k3VJHKtn640JHDo4MsY6awCwbei
 OX9kC6eZ4O24TFVtLtyIrc03SeTS7j1WFNeBxj4MKe1x4dXcwlgBCureCmVqSehsuKjs9/sqo
 wjQ4qpbmHP4HSDJda31b0XroRTxht85vVlGtfOSQT8VEYfKy6x9z5InEpDmWi85KJECTHiXWi
 SwiwxH8euf0DTyDSRc1rf1JEApZ2Ql64neLnVlix4SpQndTjQdQI/larbUC1hwKZo5gMRPOIm
 7LizVN3NdDYNC1xiDQaBaeOP9WiWZ0iJ7LwA2EhPt2Xf8r+T5tV9fr/fB/xlE1Gplk2qh3geN
 qnt91KKC35Dwfr24znZP68qgo0DpHd2qA8Gc7yHjMvJ7D0LUL02ukO69vSpdi8MAL44pizI5Z
 6474pvqazry3R4hQQ5c/dVwqdKYgcdxGGLXnlqig06Nokvj2FrptpYSDkpRvgzSmycAhyZVlO
 xP06w+4ea4VTQigb70KIFdWriXnQeDee+eLZll8rJGnWLgtrksW1hQZyDUJkD8ftJppSCbMjt
 SNKsPBkGSeH3jiBSGrbGErKQ52vHatw+mBGJvRW1Rja6A0GB+12+q2MMTlJJa57g0plz0uJGj
 QJUWDTI4taRDaHa8
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51087
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

On Wednesday 13 January 2016 17:27:16 Dave Chinner wrote:
> > I think
> > it was more than that when I first looked, so it's between 0.2% and 0.3%
> > of savings in total memory, which is certainly worth discussing about,
> > given the renewed interest in conserving RAM in general.  If we want to
> > save this memory, then doing it at the same time as the timespec64 conversion
> > is the right time so we don't need to touch every file twice.
> 
> You just uttered the key words: "If we want to save this memory"
> 
> So let's stop conflating two different lines of development because
> we only actually *need* y2038k support.
> 
> The fact we haven't made timestamp space optimisations means
> that nobody has thought it necessary or worthwhile. y2038k support
> doesn't change the landscape under which we might consider the
> optimisation, so we need to determine if the benefit outweighs the
> cost in terms of code complexity and maintainability.
> 
> So separate the two changes - make the y2038k change simple and
> obviously correct first by changing everything to timespec64. Then it
> won't get delayed by bikeshedding about an optimisation of that is
> of questionable benefit.

Fine with me. I think Deepa already started simplifying the series
already. I agree that for 64-bit machines, there is no need to optimize
that code now, since we are not regressing in terms of memory size.

For 32-bit machines, we are regressing anyway, the question is whether
it's by 12 or 24 bytes per inode. Let me try to estimate the worse-case
scenario here: let's assume that we have 1GB of RAM (anything more
on a 32-bit system gets you into trouble, and if you have less, there
will be less of a problem). Filling all of system ram with small tmpfs
files means a single 4K page plus 280 bytes for the minimum inode,
so we need an additional 6MB or 12MB to store the extra timespec
bits. Probably not too bad for a worst-case scenario, but there is
also the case of storing just the inodes but no pages, and that would
be worse.

I've added the linux-arm and linux-mips lists to cc, to see if anyone has
strong opinions on this matter. We don't have to worry about x86-32 here,
because sizeof(struct timespec64) is 12 bytes there anyway, and I don't
think there are any other 32-bit architectures that have large-scale
deployments or additional requirements we don't already have on ARM.

	Arnd
