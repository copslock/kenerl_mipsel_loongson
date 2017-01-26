Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2017 17:11:16 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44754 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993894AbdAZQLHs1rrJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Jan 2017 17:11:07 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v0QGB3Hm015823;
        Thu, 26 Jan 2017 17:11:03 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v0QGB0gt015821;
        Thu, 26 Jan 2017 17:11:00 +0100
Date:   Thu, 26 Jan 2017 17:11:00 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Mark Zhang <bomb.zhang@gmail.com>,
        David Miller <davem@davemloft.net>,
        Alexander Duyck <aduyck@mirantis.com>,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Bug fix]mips 64bits checksum error -- csum_tcpudp_nofold
Message-ID: <20170126161100.GJ21568@linux-mips.org>
References: <CAEbrdOCo9DeOa=rXYBxCEERNu_Cq=7N+5dDOwLwuZy87D3M6bA@mail.gmail.com>
 <CAKgT0UdBkqsUmp5y2d4fbi4MopW=6rxge_YzAwVvaKCqLj11_Q@mail.gmail.com>
 <CAEbrdOB4AQx6frAZr=_u4hutzfXS9R5TOtpdJox=9Tmw4WN0sA@mail.gmail.com>
 <CAKgT0UdNMH89JD95f7qmMLe32W3R6pupOOG_mSn=_ZkpUASBJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UdNMH89JD95f7qmMLe32W3R6pupOOG_mSn=_ZkpUASBJw@mail.gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Jan 26, 2017 at 07:57:49AM -0800, Alexander Duyck wrote:
> Date:   Thu, 26 Jan 2017 07:57:49 -0800
> From: Alexander Duyck <alexander.duyck@gmail.com>
> To: Mark Zhang <bomb.zhang@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>, David Miller <davem@davemloft.net>,
>  Alexander Duyck <aduyck@mirantis.com>, linux-mips@linux-mips.org,
>  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
> Subject: Re: [Bug fix]mips 64bits checksum error -- csum_tcpudp_nofold
> Content-Type: text/plain; charset=UTF-8
> 
> On Wed, Jan 25, 2017 at 6:33 PM, Mark Zhang <bomb.zhang@gmail.com> wrote:
> > Hi Alex,
> >
> >     Thanks for your reply.
> >     I tested your correction. The result is correct.
> >     The C language will cause this function(csum_tcpudp_nofold) become
> > 176 MIPS instructions. The assemble code is 150 MIPS instruction.
> >     If the MIPS CPU is running as 1GHz, C language cause more 60 nano
> > seconds during send/receive each tcp/udp packet. I'm not sure whether
> > it will cause any negative result if the frequency of CPU was lower.
> > MIPS arch is usually used in networking equipments.
> >     I think Ralf's correction is better.
> >
> >     - Mark
> >
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> >
> >  arch/mips/include/asm/checksum.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
> > index 5c585c5..08b6ba3 100644
> > --- a/arch/mips/include/asm/checksum.h
> > +++ b/arch/mips/include/asm/checksum.h
> > @@ -186,7 +186,9 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr,
> >         "       daddu   %0, %4          \n"
> >         "       dsll32  $1, %0, 0       \n"
> >         "       daddu   %0, $1          \n"
> > +       "       sltu    $1, %0, $1      \n"
> >         "       dsra32  %0, %0, 0       \n"
> > +       "       daddu   %0, $1          \n"
> >  #endif
> >         "       .set    pop"
> >         : "=r" (sum)
> >
> 
> This looks good to me.
> 
> Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>

I've actually checked in a slightly different version that this which
uses an ADDU rather than a DADDU for the second instruction added.  This
is because the DSRA32 ensures the 32 bit result in %0 is properly
signed extended to 64 bit as required by the MIPS architecture and the
ADDU then simply operates on that 32 bit %0.

  Ralf
