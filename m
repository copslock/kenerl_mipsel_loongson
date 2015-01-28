Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 00:14:29 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:60012 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011928AbbA1XO2JZvtt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 00:14:28 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 592435A6EFC;
        Thu, 29 Jan 2015 01:14:18 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id k40rEH9rtLtS; Thu, 29 Jan 2015 01:14:14 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id B5DB65BC016;
        Thu, 29 Jan 2015 01:14:23 +0200 (EET)
Date:   Thu, 29 Jan 2015 01:14:23 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: 3.18+: soft-float userland unusable due to .MIPS.abiflags patch
Message-ID: <20150128231423.GD591@fuloong-minipc.musicnaut.iki.fi>
References: <6D39441BF12EF246A7ABCE6654B0235320FA97DF@LEMAIL01.le.imgtec.org>
 <CAOLZvyGUGr3ubbzNjoFLCEDk29Fbn4qjoT6xmT=F1OZ4L-YhMA@mail.gmail.com>
 <CAOLZvyE7nk4r+gcYTkdbfeDWh6c75RRhijuh-XY=AK98LF81LA@mail.gmail.com>
 <6D39441BF12EF246A7ABCE6654B0235320FA9A04@LEMAIL01.le.imgtec.org>
 <20150117163832.GA12420@fuloong-minipc.musicnaut.iki.fi>
 <6D39441BF12EF246A7ABCE6654B0235320FAA1B6@LEMAIL01.le.imgtec.org>
 <CAOLZvyEvXuTYhCgO6=XZCUv5_apqVaz44WswPesSSS3fvoALaw@mail.gmail.com>
 <20150119053647.GV28594@NP-P-BURTON>
 <54BCCB4E.5070005@imgtec.com>
 <20150121000033.GA644@fuloong-minipc.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150121000033.GA644@fuloong-minipc.musicnaut.iki.fi>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Wed, Jan 21, 2015 at 02:00:33AM +0200, Aaro Koskinen wrote:
> On Mon, Jan 19, 2015 at 09:15:58AM +0000, Markos Chandras wrote:
> > On 01/19/2015 05:36 AM, Paul Burton wrote:
> > > On Sun, Jan 18, 2015 at 11:35:31AM +0100, Manuel Lauss wrote:
> > >> On Sat, Jan 17, 2015 at 8:00 PM, Matthew Fortune
> > >> <Matthew.Fortune@imgtec.com> wrote:
> > >>> Aaro Koskinen <aaro.koskinen@iki.fi> writes:
> > >>>> On Fri, Jan 16, 2015 at 08:36:12PM +0000, Matthew Fortune wrote:
> > >>>>> You are right that it is the .MIPS.abiflags patch that is causing your
> > >>>>> trouble. For a long time I had to put a restriction in the ABI plan
> > >>>>> that soft-float binaries without an ABIFLAGS pheader could not be
> > >>>>> linked against soft-float binaries with an ABIFLAGS pheader. We have
> > >>>>> since found a way to relax that restriction without reducing the
> > >>>>> effectiveness of the new compatibility checks. I would need to check
> > >>>>> the code in the kernel but I suspect that is the issue. Markos has
> > >>>>> done a significant update to this piece of code which he posted
> > >>>>> earlier today. That updated version should allow the combination of
> > >>>>> soft-float without ABIFLAGS and soft-float with ABIFLAGS.
> > >>>>
> > >>>> Are you referring to the series with 70 patches? I think a fix that
> > >>>> passes stable kernel rules is needed.
> > >>>
> > >>> Yes it was just one patch though for this issue:
> > >>> [PATCH RFC v2 68/70] MIPS: kernel: elf: Improve the overall ABI and FPU
> > >>> mode checks
> > >>>
> > >>> I wasn't trying to suggest how to fix the existing code just explaining
> > >>> how it came to be and what has been done about it for next release.
> > >>> (I'm not a kernel developer I'm just interested as I did most of the
> > >>> design work for the new ABI extensions.)
> > >>>
> > >>> I guess there are three options:
> > >>> a) revert the patch - That would remove the new ABI safety measures from
> > >>>    3.19 which is a shame given it has MSA support in it (I think anyway).
> > >>>    equally given that the new prctl FPU mode options did not make 3.19
> > >>>    then I suppose it doesn't lose too much either as the two features
> > >>>    go hand in hand to some extent.
> > >>
> > >> I favor this one.  I don't know how many systems with MSA are in the wild,
> > >> and if there are any, I'm sure they're using some mti/imgtec-supplied kernel
> > >> anyway.  Another thing I noticed last time is that companies shipping MIPS
> > >> products rarely upgrade their toolchains, so I'm sure the ABI safety measures
> > >> can wait for another release, but then function with all configurations
> > >> in the wild.
> > >>
> > >> Manuel
> > > 
> > > An alternative would be the patch I just submitted, which makes the mode
> > > checks conditional upon CONFIG_MIPS_O32_FP64_SUPPORT:
> > > 
> > >   http://marc.info/?l=linux-mips&m=142164553017027&w=2
> > > 
> > > Assuming this fixes your problem, and I believe it should, it would
> > > avoid the churn of reverting the patch & readding the modified logic
> > > again later.
> > > 
> > > Thanks,
> > >     Paul
> > > 
> > There is also this patch from James for 3.19 final
> > 
> > http://patchwork.linux-mips.org/patch/8932/
> > 
> > so with these two patches we should be good for 3.19.
> 
> This patch is also needed to run hard-float O32 userspace compiled using
> binutils 2.25 with 64-bit 3.19-rc5 (otherwise kernel fails to start init).

Seems to be still missing in 3.19-rc6...

A.
